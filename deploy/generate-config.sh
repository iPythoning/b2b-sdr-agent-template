#!/bin/bash
# Generate openclaw.json from config.sh
# Usage: ./generate-config.sh <config-directory>

set -euo pipefail

CONFIG_DIR="${1:-.}"
source "$CONFIG_DIR/config.sh"

# Auto-generate Gateway Token if not set
if [ -z "$GATEWAY_TOKEN" ]; then
  GATEWAY_TOKEN=$(openssl rand -hex 24 2>/dev/null || head -c 48 /dev/urandom | xxd -p | tr -d '\n' | head -c 48)
fi

# ─── Build models.providers JSON ─────────────────────────
build_providers() {
  local providers=""
  local primary_api_field=""
  if [ "$PRIMARY_API_TYPE" = "google-generative-ai" ]; then
    primary_api_field=""
  else
    primary_api_field="\"api\": \"$PRIMARY_API_TYPE\","
  fi

  providers=$(cat <<PJSON
    "$PRIMARY_PROVIDER": {
      "baseUrl": "$PRIMARY_BASE_URL",
      $([ -n "$PRIMARY_API_KEY" ] && echo "\"apiKey\": \"$PRIMARY_API_KEY\"," || true)
      $primary_api_field
      "models": [{
        "id": "$PRIMARY_MODEL_ID",
        "name": "$PRIMARY_MODEL_NAME",
        "reasoning": true,
        "input": ["text", "image"],
        "cost": {"input": 0, "output": 0, "cacheRead": 0, "cacheWrite": 0},
        "contextWindow": $PRIMARY_CONTEXT_WINDOW,
        "maxTokens": $PRIMARY_MAX_TOKENS
      }]
    }
PJSON
  )

  if [ -n "$FALLBACK_PROVIDER" ]; then
    local fallback_api_field="\"api\": \"$FALLBACK_API_TYPE\","
    providers="$providers,
    \"$FALLBACK_PROVIDER\": {
      \"baseUrl\": \"$FALLBACK_BASE_URL\",
      $([ -n "$FALLBACK_API_KEY" ] && echo "\"apiKey\": \"$FALLBACK_API_KEY\"," || true)
      $fallback_api_field
      \"models\": [{
        \"id\": \"$FALLBACK_MODEL_ID\",
        \"name\": \"$FALLBACK_MODEL_NAME\"
      }]
    }"
  fi
  echo "$providers"
}

# ─── Build plugins JSON ──────────────────────────────────
build_plugins() {
  local allow='"telegram", "whatsapp"'
  local entries='{
      "telegram": {"enabled": '$TELEGRAM_ENABLED'},
      "whatsapp": {"enabled": '$WHATSAPP_ENABLED'}'

  if [ "${MEMOS_ENABLED:-false}" = true ] && [ -n "${MEMOS_API_KEY:-}" ]; then
    allow="$allow, \"memos-cloud-openclaw-plugin\""
    entries="$entries,
      \"memos-cloud-openclaw-plugin\": {
        \"enabled\": true,
        \"config\": {
          \"apiKey\": \"$MEMOS_API_KEY\",
          \"recallEnabled\": true,
          \"addEnabled\": true,
          \"captureStrategy\": \"last_turn\",
          \"asyncMode\": true
        }
      }"
  fi

  if [ "${LANCEDB_ENABLED:-false}" = true ]; then
    allow="$allow, \"memory-lancedb\""
    entries="$entries,
      \"memory-lancedb\": {
        \"enabled\": true,
        \"config\": {
          \"embedding\": {
            \"model\": \"$EMBEDDING_MODEL\",
            \"apiKey\": \"ollama\",
            \"baseUrl\": \"$OLLAMA_BASE_URL\",
            \"dimensions\": 768
          },
          \"autoCapture\": true,
          \"autoRecall\": true
        }
      }"
  fi

  entries="$entries
    }"

  echo "{
    \"allow\": [$allow],
    $([ "${LANCEDB_ENABLED:-false}" = true ] && echo '"slots": {"memory": "memory-lancedb"},' || true)
    \"entries\": $entries
  }"
}

# ─── Build agent models ──────────────────────────────────
build_agent_models() {
  local models="\"$PRIMARY_PROVIDER/$PRIMARY_MODEL_ID\": {\"alias\": \"$PRIMARY_MODEL_NAME\"}"
  if [ -n "$FALLBACK_PROVIDER" ]; then
    models="$models, \"$FALLBACK_PROVIDER/$FALLBACK_MODEL_ID\": {\"alias\": \"$FALLBACK_MODEL_NAME\"}"
  fi
  echo "{$models}"
}

# ─── Generate main config ────────────────────────────────
PROVIDERS=$(build_providers)
PLUGINS=$(build_plugins)
AGENT_MODELS=$(build_agent_models)

cat > "$CONFIG_DIR/openclaw.json" <<ENDJSON
{
  "meta": {
    "lastTouchedAt": "$(date -u +%Y-%m-%dT%H:%M:%S.000Z)"
  },
  "logging": {
    "level": "warn",
    "consoleLevel": "error",
    "consoleStyle": "compact",
    "redactSensitive": "tools"
  },
  "models": {
    "mode": "merge",
    "providers": {
$PROVIDERS
    }
  },
  "agents": {
    "defaults": {
      "model": {
        "primary": "$PRIMARY_PROVIDER/$PRIMARY_MODEL_ID"$([ -n "$FALLBACK_PROVIDER" ] && echo ",
        \"fallbacks\": [\"$FALLBACK_PROVIDER/$FALLBACK_MODEL_ID\"]" || true)
      },
      "models": $AGENT_MODELS,
      "workspace": "/root/.openclaw/workspace",
      "contextTokens": 60000,
      "heartbeat": {"every": "30m", "target": "last", "directPolicy": "allow"},
      "maxConcurrent": 4$([ -n "${COMPACTION_PROVIDER:-}" ] && echo ",
      \"compaction\": {\"provider\": \"$COMPACTION_PROVIDER\"}" || true)
    }
  },
  "channels": {
    "whatsapp": {
      "enabled": $WHATSAPP_ENABLED,
      "dmPolicy": "$WHATSAPP_DM_POLICY",
      "allowFrom": ["*"],
      "groupPolicy": "$WHATSAPP_GROUP_POLICY",
      "debounceMs": $WHATSAPP_DEBOUNCE_MS
    },
    "telegram": {
      "enabled": $TELEGRAM_ENABLED,
      "dmPolicy": "$TELEGRAM_DM_POLICY",
      "allowFrom": ["*"],
      "botToken": "${TELEGRAM_BOT_TOKEN:-}",
      "groupPolicy": "$TELEGRAM_GROUP_POLICY"
    }
  },
  "gateway": {
    "port": $GATEWAY_PORT,
    "mode": "local",
    "bind": "${GATEWAY_BIND:-lan}",
    "auth": {"mode": "token", "token": "$GATEWAY_TOKEN"},
    "controlUi": {"allowedOrigins": ["*"]}
  },
  "tools": {
    "profile": "full",
    "sessions": {"visibility": "all"}
  },
  "skills": {"install": {"nodeManager": "npm"}},
  "hooks": {
    "internal": {
      "enabled": true,
      "entries": {
        "boot-md": {
          "enabled": true,
          "files": ["IDENTITY.md", "SOUL.md", "AGENTS.md", "USER.md", "MEMORY.md", "HEARTBEAT.md", "TOOLS.md"]
        }
      }
    }
  },
  "plugins": $PLUGINS
}
ENDJSON

# Validate generated JSON
if command -v jq &>/dev/null; then
  if ! jq empty "$CONFIG_DIR/openclaw.json" 2>/dev/null; then
    echo "✗ Generated openclaw.json is invalid JSON! Check for special characters in API keys." >&2
    exit 1
  fi
fi

echo "✓ Generated $CONFIG_DIR/openclaw.json"
echo "  Gateway Token: [hidden — see openclaw.json]"
