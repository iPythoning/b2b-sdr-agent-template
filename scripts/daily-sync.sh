#!/bin/bash
# Daily Upstream Sync Monitor
# Fetches new commits from openclaw/openclaw and generates a structured report
# Usage: ./scripts/daily-sync.sh [--report-only]
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SYNC_DIR="$REPO_DIR/.sync"
LAST_COMMIT_FILE="$SYNC_DIR/last-synced-commit"
REPORT_FILE="$SYNC_DIR/latest-report.md"

cd "$REPO_DIR"

# Ensure upstream remote exists
if ! git remote get-url upstream &>/dev/null; then
  git remote add upstream https://github.com/openclaw/openclaw.git
fi

# Read last synced commit
if [ ! -f "$LAST_COMMIT_FILE" ]; then
  echo "❌ No baseline commit found. Run initial setup first."
  exit 1
fi
LAST_SHA=$(cat "$LAST_COMMIT_FILE" | tr -d '[:space:]')

# Fetch upstream (via GitHub API to avoid slow git fetch)
echo "🔍 Fetching upstream commits since $LAST_SHA..."
COMMITS_JSON=$(gh api "repos/openclaw/openclaw/commits?per_page=100" 2>/dev/null || echo "[]")

# Find new commits (everything before LAST_SHA in the list)
NEW_COMMITS=$(echo "$COMMITS_JSON" | jq -r --arg last "$LAST_SHA" '
  . as $all |
  ($all | to_entries | map(select(.value.sha == $last)) | .[0].key // length) as $idx |
  if $idx == 0 then empty
  else
    $all[:$idx] | reverse | .[] |
    "\(.sha[0:7]) | \(.commit.author.name) | \(.commit.message | split("\n")[0])"
  end
')

if [ -z "$NEW_COMMITS" ]; then
  echo "✅ No new commits since last sync."
  exit 0
fi

COMMIT_COUNT=$(echo "$NEW_COMMITS" | wc -l | tr -d ' ')
LATEST_SHA=$(echo "$COMMITS_JSON" | jq -r '.[0].sha')

echo "📊 Found $COMMIT_COUNT new commits"

# Generate structured report
cat > "$REPORT_FILE" << EOF
# Upstream Sync Report — $(date +%Y-%m-%d)

**Source**: openclaw/openclaw (main)
**Last synced**: $LAST_SHA
**Latest upstream**: $LATEST_SHA
**New commits**: $COMMIT_COUNT

## Commit Log

| SHA | Author | Message |
|-----|--------|---------|
$(echo "$NEW_COMMITS" | while IFS='|' read -r sha author msg; do
  echo "| $sha |$author |$msg |"
done)

## Categories (for AI analysis)

Categorize each commit as:
- **RELEVANT** — Affects WhatsApp/Telegram/Email transport, sales pipeline, CRM, multi-tenant, deploy scripts
- **WATCH** — General platform improvements, bug fixes, CI/CD changes worth monitoring
- **SKIP** — Unrelated (Discord, iMessage, Signal, Line, Zalo, internal refactors)

## Action Items

For RELEVANT commits:
1. Adapt changes to b2b-sdr-agent-template workspace/deploy/skills
2. Update CHANGELOG.md
3. Write blog post summarizing the updates

EOF

echo ""
echo "📋 Report saved to: $REPORT_FILE"
echo ""
cat "$REPORT_FILE"

# If not --report-only, update the last synced commit
if [[ "${1:-}" != "--report-only" ]]; then
  echo "$LATEST_SHA" > "$LAST_COMMIT_FILE"
  echo ""
  echo "✅ Updated last synced commit to: $LATEST_SHA"
fi
