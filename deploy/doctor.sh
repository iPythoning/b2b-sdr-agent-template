#!/bin/bash
# B2B SDR Agent — Post-deploy health checks
# Usage: ./doctor.sh [--dry-run]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/config.sh"
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'

log()  { echo -e "${GREEN}[OK]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
err()  { echo -e "${RED}[FAIL]${NC} $*" >&2; }
info() { echo -e "${CYAN}[..]${NC} $*"; }

DRY_RUN=false
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=true ;;
    -*) err "Unknown option: $arg"; exit 1 ;;
  esac
done

if [ ! -f "$CONFIG_FILE" ]; then
  err "Missing config: $CONFIG_FILE"
  echo "Run: cp config.sh.example config.sh && edit config.sh"
  exit 1
fi

source "$CONFIG_FILE"

SERVER_USER="${SERVER_USER:-root}"
SERVER_PORT="${SERVER_PORT:-22}"
if [ -z "${REMOTE_HOME:-}" ]; then
  if [ "$SERVER_USER" = "root" ]; then
    REMOTE_HOME="/root"
  else
    REMOTE_HOME="/home/$SERVER_USER"
  fi
fi
REMOTE_OPENCLAW_HOME="${REMOTE_OPENCLAW_HOME:-$REMOTE_HOME/.openclaw}"
REMOTE_CONFIG_HOME="${REMOTE_CONFIG_HOME:-$REMOTE_HOME/.config}"
REMOTE_WORKSPACE_DIR="${REMOTE_WORKSPACE_DIR:-$REMOTE_OPENCLAW_HOME/workspace}"

validate_remote_path() {
  if ! [[ "$1" =~ ^/[a-zA-Z0-9._/-]+$ ]]; then
    err "Invalid remote path: $1"
    exit 1
  fi
}

[ -n "${SERVER_HOST:-}" ] || { err "Missing SERVER_HOST"; exit 1; }
[[ "$GATEWAY_PORT" =~ ^[0-9]+$ ]] || { err "Invalid GATEWAY_PORT: $GATEWAY_PORT"; exit 1; }
validate_remote_path "$REMOTE_HOME"
validate_remote_path "$REMOTE_OPENCLAW_HOME"
validate_remote_path "$REMOTE_CONFIG_HOME"
validate_remote_path "$REMOTE_WORKSPACE_DIR"

SSH_OPTS="-o StrictHostKeyChecking=accept-new -o ConnectTimeout=10"
[ -n "${SSH_KEY:-}" ] && SSH_OPTS="$SSH_OPTS -i $SSH_KEY"

SSHPASS_PREFIX=""
if [ -n "${SSH_PASS:-}" ]; then
  if ! command -v sshpass >/dev/null 2>&1; then
    err "sshpass required for password auth: brew install sshpass / apt install sshpass"
    exit 1
  fi
  PW_FILE=$(mktemp "${TMPDIR:-/tmp}/.sdr-doctor-pw.XXXXXX")
  chmod 600 "$PW_FILE"
  python3 -c "import os,sys; open(sys.argv[2], 'w').write(sys.argv[1]); os.chmod(sys.argv[2], 0o600)" "$SSH_PASS" "$PW_FILE"
  SSHPASS_PREFIX="sshpass -f $PW_FILE"
  SSH_OPTS="$SSH_OPTS -o PubkeyAuthentication=no"
fi
cleanup_pw() { [ -n "${PW_FILE:-}" ] && shred -u "$PW_FILE" 2>/dev/null || rm -f "${PW_FILE:-}"; }
trap cleanup_pw EXIT

SSH_CMD="$SSHPASS_PREFIX ssh $SSH_OPTS -p ${SERVER_PORT:-22} ${SERVER_USER}@${SERVER_HOST}"

remote() {
  if [ "$DRY_RUN" = true ]; then
    echo "[dry-run] ssh: $*"
  else
    $SSH_CMD "$@"
  fi
}

FAILURES=0
check() {
  local name="$1" cmd="$2"
  info "$name"
  if remote "$cmd" >/tmp/b2b-sdr-doctor.out 2>&1; then
    log "$name"
  else
    FAILURES=$((FAILURES + 1))
    err "$name"
    sed 's/^/    /' /tmp/b2b-sdr-doctor.out >&2 || true
  fi
}

echo ""
echo "B2B SDR Agent Doctor"
echo "Server: ${SERVER_USER}@${SERVER_HOST}:${SERVER_PORT}"
echo "OpenClaw home: ${REMOTE_OPENCLAW_HOME}"
echo ""

check "SSH connectivity" "echo ok"
check "Node.js available" "node --version"
check "npm available" "npm --version"
check "OpenClaw CLI available" "openclaw --version"
check "OpenClaw home exists" "test -d '$REMOTE_OPENCLAW_HOME'"
check "openclaw.json exists" "test -f '$REMOTE_OPENCLAW_HOME/openclaw.json'"
check "openclaw.json permissions are private" "perm=\$(stat -c '%a' '$REMOTE_OPENCLAW_HOME/openclaw.json' 2>/dev/null || stat -f '%Lp' '$REMOTE_OPENCLAW_HOME/openclaw.json'); test \"\$perm\" = 600"
check "Workspace context files installed" "for f in IDENTITY.md SOUL.md AGENTS.md USER.md MEMORY.md HEARTBEAT.md TOOLS.md; do test -f '$REMOTE_WORKSPACE_DIR/'\"\$f\" || exit 1; done"
check "Local template skills installed" "for d in chroma-memory delivery-queue graphify lead-discovery quotation-generator sdr-humanizer supermemory telegram-toolkit; do test -f '$REMOTE_WORKSPACE_DIR/skills/'\"\$d\"'/SKILL.md' || exit 1; done"
check "Gateway service active" "systemctl --user is-active openclaw-gateway"
check "Gateway health endpoint responds" "curl -fsS --max-time 5 'http://127.0.0.1:$GATEWAY_PORT/health'"

if [ "${CHROMADB_ENABLED:-false}" = true ]; then
  check "Chroma memory script installed" "test -f '$REMOTE_WORKSPACE_DIR/skills/chroma-memory/chroma.mjs'"
  check "Chroma memory stats command runs" "OPENCLAW_HOME='$REMOTE_OPENCLAW_HOME' node '$REMOTE_WORKSPACE_DIR/skills/chroma-memory/chroma.mjs' stats >/dev/null"
fi

echo ""
if [ "$FAILURES" -eq 0 ]; then
  log "Doctor checks passed"
else
  err "$FAILURES doctor check(s) failed"
  exit 1
fi
