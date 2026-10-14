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
  .github/workflows/validate.yml \
  workspace/IDENTITY.md workspace/SOUL.md workspace/AGENTS.md workspace/USER.md \
  workspace/MEMORY.md workspace/HEARTBEAT.md workspace/TOOLS.md \
  deploy/config.sh.example deploy/deploy.sh deploy/doctor.sh deploy/generate-config.sh deploy/skill-profiles.sh \
  skills/chroma-memory/SKILL.md skills/chroma-memory/chroma.mjs \
  skills/contact-check/SKILL.md skills/contact-check/check.mjs \
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

node --check "$ROOT/skills/contact-check/check.mjs"
env -u PRECLEARED_SENDER_COUNTRY node "$ROOT/skills/contact-check/check.mjs" --email buyer@example.de --source published > "$TMP_DIR/contact-check-off.json"
jq -e '.skipped == true and .send == true' "$TMP_DIR/contact-check-off.json" >/dev/null
node "$ROOT/skills/contact-check/check.mjs" --email buyer@example.de --source published --country de --sender GB --dry-run > "$TMP_DIR/contact-check.json"
jq -e '.dry_run == true and .payload.address_source == "published" and .payload.recipient_country == "DE" and .payload.sender_country == "GB"' "$TMP_DIR/contact-check.json" >/dev/null
if node "$ROOT/skills/contact-check/check.mjs" --email buyer@example.de --source guessed --sender GB > /dev/null; then
  fail "contact-check accepted an invalid --source"
fi
pass "Contact check skill parses and builds requests"

CONTACT_CHECK="$ROOT/skills/contact-check/check.mjs" node --input-type=module -e '
import assert from "node:assert/strict";
import { pathToFileURL } from "node:url";
const { summarise } = await import(pathToFileURL(process.env.CONTACT_CHECK).href);
for (const body of [[], "ok_to_email", null, { verdict: "maybe" }, { reasons: [] }]) {
  assert.equal(summarise(200, body).exitCode, 3);
}
const odd = summarise(200, { verdict: "consent_needed", reasons: { text: "x" }, next_step: 5, receipt: "cc_rcpt_X" });
assert.equal(odd.exitCode, 2);
assert.deepEqual([odd.result.rule, odd.result.next_step, odd.result.receipt_id], [null, null, null]);
assert.equal(summarise(200, { verdict: "ok_to_email", receipt: { id: "cc_rcpt_X" } }).result.receipt_id, "cc_rcpt_X");
assert.equal(summarise(429, { error: "daily_limit" }).result.error, "daily_limit");
'
pass "Contact check treats unexpected responses as unavailable"

source "$ROOT/deploy/skill-profiles.sh"
skill_list="$(get_skills_for_profile b2b_trade) chromadb"
skill_count="$(printf '%s\n' $skill_list | sort -u | wc -l | tr -d ' ')"
[ "$skill_count" = "41" ] || fail "Expected b2b_trade profile to install 41 skills, got $skill_count"
pass "b2b_trade skill profile count is current"

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
  .agents.defaults.workspace == "/root/.openclaw/workspace" and
  .plugins.entries.whatsapp.enabled == true
' "$TMP_DIR/deploy/openclaw.json" >/dev/null
pass "OpenClaw config generation works"

awk '
  /^SERVER_HOST=/ { print "SERVER_HOST=\"127.0.0.1\""; next }
  /^SERVER_USER=/ { print "SERVER_USER=\"openclaw\""; next }
  /^PRIMARY_API_KEY=/ { print "PRIMARY_API_KEY=\"sk-validation-primary\""; next }
  /^FALLBACK_API_KEY=/ { print "FALLBACK_API_KEY=\"sk-validation-fallback\""; next }
  { print }
' "$ROOT/deploy/config.sh.example" > "$TMP_DIR/deploy/config-nonroot.sh"
mv "$TMP_DIR/deploy/config.sh" "$TMP_DIR/deploy/config-root.sh"
mv "$TMP_DIR/deploy/config-nonroot.sh" "$TMP_DIR/deploy/config.sh"
bash "$ROOT/deploy/generate-config.sh" "$TMP_DIR/deploy" >/dev/null
jq -e '.agents.defaults.workspace == "/home/openclaw/.openclaw/workspace"' "$TMP_DIR/deploy/openclaw.json" >/dev/null
pass "Non-root OpenClaw workspace path generation works"

printf '\nAll template checks passed.\n'
