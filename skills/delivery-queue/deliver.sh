#!/bin/bash
# delivery-queue — Queue management for scheduled message delivery
# Usage: ./deliver.sh <command> [options]

set -euo pipefail

QUEUE_DIR="${OPENCLAW_HOME:-$HOME/.openclaw}/delivery-queue"
mkdir -p "$QUEUE_DIR"
shopt -s nullglob

# ─── Input Validation ────────────────────────────────────
validate_channel() {
  if [[ ! "$1" =~ ^(whatsapp|telegram|email)$ ]]; then
    echo "Invalid channel: $1 (allowed: whatsapp, telegram, email)" >&2; exit 1
  fi
}

validate_recipient() {
  if [[ ! "$1" =~ ^[+@a-zA-Z0-9._-]+$ ]]; then
    echo "Invalid recipient format: $1" >&2; exit 1
  fi
}

validate_id() {
  if [[ ! "$1" =~ ^[a-f0-9]{12}$ ]]; then
    echo "Invalid delivery ID format: $1 (expected 12-char hex)" >&2; exit 1
  fi
}

validate_delay() {
  if [[ ! "$1" =~ ^[0-9]+$ ]] || [ "$1" -gt 604800 ]; then
    echo "Invalid delay: $1 (must be 0-604800 seconds)" >&2; exit 1
  fi
}

safe_json_string() {
  python3 -c 'import sys,json; print(json.dumps(sys.argv[1]))' "$1"
}

# ─── Commands ────────────────────────────────────────────
case "${1:-help}" in
  schedule)
    # Schedule a message for delivery
    # Args: <channel> <recipient> <message> [delay_seconds]
    CHANNEL="${2:?Channel required (whatsapp/telegram/email)}"
    RECIPIENT="${3:?Recipient required}"
    MESSAGE="${4:?Message required}"
    DELAY="${5:-0}"

    validate_channel "$CHANNEL"
    validate_recipient "$RECIPIENT"
    validate_delay "$DELAY"

    DELIVER_AT=$(($(date +%s) + DELAY))
    ID=$(date +%s%N | sha256sum | head -c 12)

    MESSAGE_JSON=$(safe_json_string "$MESSAGE")
    RECIPIENT_JSON=$(safe_json_string "$RECIPIENT")

    cat > "$QUEUE_DIR/$ID.json" <<EOF
{
  "id": "$ID",
  "channel": "$CHANNEL",
  "recipient": $RECIPIENT_JSON,
  "message": $MESSAGE_JSON,
  "deliver_at": $DELIVER_AT,
  "created_at": $(date +%s),
  "status": "pending",
  "retries": 0
}
EOF
    echo "Scheduled: $ID (deliver at $(date -d @$DELIVER_AT 2>/dev/null || date -r $DELIVER_AT))"
    ;;

  list)
    # List all pending deliveries
    echo "=== Pending Deliveries ==="
    for f in "$QUEUE_DIR"/*.json; do
      [ -f "$f" ] || continue
      python3 -c "
import json, sys
with open(sys.argv[1]) as fh:
    d = json.load(fh)
    if d['status'] == 'pending':
        print(f\"  {d['id']} | {d['channel']} → {d['recipient']} | deliver at {d['deliver_at']}\")
" "$f"
    done
    ;;

  cancel)
    # Cancel a scheduled delivery
    ID="${2:?Delivery ID required}"
    validate_id "$ID"

    TARGET="$QUEUE_DIR/$ID.json"
    REAL_PATH=$(realpath "$TARGET" 2>/dev/null || echo "$TARGET")
    if [[ ! "$REAL_PATH" =~ ^"$QUEUE_DIR"/ ]]; then
      echo "Path traversal blocked" >&2; exit 1
    fi

    if [ -f "$TARGET" ]; then
      python3 -c "
import json, sys
path = sys.argv[1]
with open(path, 'r+') as f:
    d = json.load(f); d['status'] = 'cancelled'
    f.seek(0); json.dump(d, f); f.truncate()
" "$TARGET"
      echo "Cancelled: $ID"
    else
      echo "Not found: $ID" >&2; exit 1
    fi
    ;;

  flush)
    # Send all pending messages immediately
    NOW=$(date +%s)
    SENT=0
    for f in "$QUEUE_DIR"/*.json; do
      [ -f "$f" ] || continue
      STATUS=$(python3 -c "import json,sys; print(json.load(open(sys.argv[1]))['status'])" "$f")
      [ "$STATUS" = "pending" ] || continue

      python3 -c "
import json, sys
path = sys.argv[1]; now = int(sys.argv[2])
with open(path, 'r+') as fh:
    d = json.load(fh); d['status'] = 'sent'; d['sent_at'] = now
    fh.seek(0); json.dump(d, fh); fh.truncate()
" "$f" "$NOW"
      SENT=$((SENT + 1))
    done
    echo "Flushed $SENT messages"
    ;;

  clean)
    # Remove completed/cancelled deliveries older than 7 days
    CUTOFF=$(($(date +%s) - 604800))
    CLEANED=0
    for f in "$QUEUE_DIR"/*.json; do
      [ -f "$f" ] || continue
      python3 -c "
import json, sys
d = json.load(open(sys.argv[1]))
if d['status'] in ('sent', 'cancelled') and d.get('created_at', 0) < int(sys.argv[2]):
    sys.exit(0)
sys.exit(1)
" "$f" "$CUTOFF" && rm "$f" && CLEANED=$((CLEANED + 1))
    done
    echo "Cleaned $CLEANED old entries"
    ;;

  *)
    echo "Usage: deliver.sh <schedule|list|cancel|flush|clean>"
    echo ""
    echo "Commands:"
    echo "  schedule <channel> <recipient> <message> [delay_sec]"
    echo "  list                    List pending deliveries"
    echo "  cancel <id>             Cancel a delivery"
    echo "  flush                   Send all pending now"
    echo "  clean                   Remove old entries"
    ;;
esac
