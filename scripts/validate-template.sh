#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/b2b-sdr-validate.XXXXXX")"
trap 'rm -rf "$TMP_DIR"' EXIT

pass() { printf 'OK %s\n' "$1"; }
fail() { printf 'FAIL %s\n' "$1" >&2; exit 1; }

require_file() {
  [ -f "$ROOT/$1" ] || fail "Missing required file: $1"
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || fail "Missing command: $1"
}

require_cmd node
require_cmd jq

for file in \
  README.md README.zh-CN.md CHANGELOG.md SKILL.md \
  workspace/IDENTITY.md workspace/SOUL.md workspace/AGENTS.md workspace/USER.md \
  workspace/MEMORY.md workspace/HEARTBEAT.md workspace/TOOLS.md \
  deploy/config.sh.example deploy/deploy.sh deploy/generate-config.sh deploy/skill-profiles.sh \
  skills/chroma-memory/SKILL.md skills/chroma-memory/chroma.mjs \
  product-kb/catalog.json product-kb/scripts/generate-pi.js
do
  require_file "$file"
done
pass "Required template files exist"

while IFS= read -r script; do
  bash -n "$script"
done < <(find "$ROOT" -path "$ROOT/.git" -prune -o -type f -name '*.sh' -print)
pass "Shell scripts parse cleanly"

jq empty "$ROOT/product-kb/catalog.json"
jq empty "$ROOT/product-kb/products/example-product/info.json"
pass "Product KB JSON is valid"

node "$ROOT/product-kb/scripts/generate-pi.js" \
  --buyer "Validation Buyer Ltd." \
  --products "prod-001:2,prod-002:1" \
  --terms "FOB Shanghai" \
  --output "$TMP_DIR/pi.json" >/dev/null 2>&1
jq -e '.document == "PROFORMA INVOICE" and (.items | length) == 2 and .buyer.company == "Validation Buyer Ltd."' "$TMP_DIR/pi.json" >/dev/null
pass "Proforma invoice generator works"

OPENCLAW_HOME="$TMP_DIR/openclaw" node "$ROOT/skills/chroma-memory/chroma.mjs" store \
  --customer "+15550123456" \
  --turn 1 \
  --user "Can you quote 10 units?" \
  --agent "I will send a FOB quote tomorrow." \
  --stage "qualifying" \
  --topic "pricing" >/dev/null
OPENCLAW_HOME="$TMP_DIR/openclaw" node "$ROOT/skills/chroma-memory/chroma.mjs" search \
  "FOB quote tomorrow" \
  --customer "+15550123456" \
  --limit 1 > "$TMP_DIR/chroma-search.json"
jq -e 'length == 1 and .[0].has_quote == true and .[0].has_commitment == true' "$TMP_DIR/chroma-search.json" >/dev/null
pass "Chroma memory smoke test works"

mkdir -p "$TMP_DIR/deploy"
awk '
  /^SERVER_HOST=/ { print "SERVER_HOST=\"127.0.0.1\""; next }
  /^PRIMARY_API_KEY=/ { print "PRIMARY_API_KEY=\"sk-validation-primary\""; next }
  /^FALLBACK_API_KEY=/ { print "FALLBACK_API_KEY=\"sk-validation-fallback\""; next }
  /^CHROMADB_ENABLED=/ { print "CHROMADB_ENABLED=true"; next }
  { print }
' "$ROOT/deploy/config.sh.example" > "$TMP_DIR/deploy/config.sh"

bash "$ROOT/deploy/generate-config.sh" "$TMP_DIR/deploy" >/dev/null
jq -e '
  .gateway.port == 18789 and
  .channels.whatsapp.enabled == true and
  .agents.defaults.model.primary == "deepseek/deepseek-v4-flash" and
  .plugins.entries.whatsapp.enabled == true
' "$TMP_DIR/deploy/openclaw.json" >/dev/null
pass "OpenClaw config generation works"

printf '\nAll template checks passed.\n'
