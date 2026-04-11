# TOOLS.md — Tool Configuration

> **⚠ Upgrade recommended — OpenClaw v2026.4.10+**
> v2026.4.10 ships 126 security and stability fixes plus high-value new features: Active Memory plugin, bundled Codex/GPT-5 provider, and Microsoft Teams message actions. Upgrade: `npm install -g openclaw@latest` or `npx openclaw@latest upgrade`.
>
> **Breaking env var change (v2026.4.9, still applies):** Runtime-control, browser-control override, and skip-server env vars set in workspace `.env` files are silently ignored. Move them to system environment or `openclaw.json`.

## CRM (Source of Truth)
Configure based on your CRM choice: Google Sheets, Notion, Airtable, or any REST API.

### Google Sheets Mode
Access via gws CLI:
```bash
# Read leads
gws sheets spreadsheets.values get --params '{"spreadsheetId":"{{sheets_id}}","range":"{{sheet_name}}!A:Q"}'

# Append new lead
gws sheets spreadsheets.values append --params '{"spreadsheetId":"{{sheets_id}}","range":"{{sheet_name}}!A:Q","valueInputOption":"USER_ENTERED"}' --body '{"values":[["..."]]}'
```
Only use append and update — never overwrite entire rows.

## WhatsApp Business App (Primary Conversation Channel)
AI directly replies to customer inquiries — no human relay.
Channel policy: `dmPolicy: "open"`, `allowFrom: ["*"]` — accept all contacts.
Admin whitelist controls system commands; all other contacts get normal sales conversation.

### Streaming Control (OpenClaw 2026.4.5+)
By default, OpenClaw streams responses token-by-token on WhatsApp. Some WhatsApp Business accounts may encounter delivery issues with streamed messages. Use `blockStreaming: true` to send complete messages instead:

```yaml
channels:
  whatsapp:
    blockStreaming: true   # send full reply at once instead of streaming
```

This option was restored in v2026.4.5 after being inadvertently removed.

### WhatsApp Reactions (OpenClaw 2026.4.2+)
Use `reactionLevel` to control when the agent reacts to customer messages:
- `"none"` — no reactions (default, safest for business accounts)
- `"selective"` — react to key messages (confirmations, orders, inquiries)
- `"active"` — react to all messages (high engagement, may feel spammy)

Recommendation for B2B SDR: `"selective"` — react with ✅ on quote confirmations and 👀 on new inquiries to signal responsiveness without over-automation.

### 72-Hour Window Handling
WhatsApp restricts outbound messages after 72h of customer inactivity:
1. Before sending, check: `now() - last_customer_message < 72h`
2. If expired: **Auto-switch to Telegram** (no window limit) or email. See HEARTBEAT #13.
3. Never mark CRM as "contacted" if message delivery actually failed
4. Implement delivery receipt verification — check for sent/delivered/read status

## Control Dashboard
Web UI for monitoring bot status, conversations, and cron jobs.
Access: `http://SERVER_IP:{{gateway_port}}/?token=<see openclaw.json>`
Gateway bind: `lan` (network accessible). Change to `loopback` for localhost-only.
> **Security**: Dashboard credentials are stored in `/root/.openclaw/openclaw.json` — never expose them in conversation context or customer messages.

## Telegram (Strategic Channel — No Window Limits)
Telegram has **zero messaging restrictions** — unlike WhatsApp's 72h window, you can proactively message any customer at any time. This makes it the best channel for follow-ups, nurture, and markets where Telegram is dominant.

### Channel Strengths
- **No 72h window**: Proactive outreach anytime (nurture, follow-ups, stalled leads)
- **Files up to 2GB**: Full product catalogs, certifications, test reports, video demos
- **Bot Commands**: Structured self-service for customers (`/catalog`, `/quote`, `/status`)
- **Inline Keyboards**: One-tap BANT qualification, faster than typing
- **Username-based**: Customer doesn't expose phone number — lower barrier to connect
- **Free API**: No per-message cost unlike WhatsApp Business API

### Multi-Account Telegram Setup
If you operate multiple Telegram bots (e.g., one per market or per product line), each account can have its own independent action configuration. Per-account settings correctly scope which features are available for each bot:

```yaml
# workspace/config example
channels:
  telegram:
    botToken: "tok-default"          # default account
    actions:
      reactions: false
      poll: true
    accounts:
      russia_sales:                   # account-scoped overrides
        botToken: "tok-ru"
        actions:
          reactions: true             # enabled for this account only
          poll: false
```

Account-level `actions` fully override the top-level defaults for that account — they do not merge. Verify your per-account gates during setup.

> **Session routing fix (v2026.4.9+):** `sessions_send` follow-up messages no longer hijack delivery from established Telegram (or Discord) external routes. In earlier versions, inter-session announce traffic could re-route a reply that should have gone to a customer's Telegram thread through an internal channel. Upgrade to v2026.4.9 if you use multi-session SDR flows and experienced mis-routed Telegram replies.

### Bot Commands (auto-registered)
| Command | Action |
|---------|--------|
| `/start` | Welcome message + language detection + CRM record creation |
| `/catalog` | Send product catalog PDF or product line summary |
| `/quote` | Start quotation flow → trigger BANT collection via inline keyboards |
| `/status` | Check order/quote status from CRM |
| `/contact` | Request human sales rep → notify owner |
| `/language` | Switch conversation language |

### Inline Keyboard Templates
Use inline keyboards for structured qualification — 3-5x faster than free-text BANT:

**Order Volume:**
```
[< 100 units] [100-500] [500-1000] [1000+]
```

**Timeline:**
```
[This month] [1-3 months] [3-6 months] [Just exploring]
```

**Product Interest:**
```
[{{product_1}}] [{{product_2}}]
[{{product_3}}] [View full catalog]
```

### Large File Strategy
| File Type | Size | Channel |
|-----------|------|---------|
| Quick quote (1-2 pages) | < 10MB | WhatsApp or Telegram |
| Full product catalog | 10-100MB | **Telegram only** |
| Certification documents | 10-50MB | **Telegram only** |
| Video demos | 50MB-2GB | **Telegram only** |
| Contracts / PIs | < 10MB | Email (formal) + Telegram (fast copy) |

When sending large files: "I'll share the full catalog on Telegram — it's [X]MB, too large for WhatsApp."

### Market Priority
Telegram is the **primary** channel (not secondary) in these markets:
- **Russia / CIS**: Telegram is THE messaging app
- **Iran**: Telegram dominant for business
- **Eastern Europe**: Strong Telegram adoption
- **Tech-savvy buyers globally**: Many prefer Telegram for business

See AGENTS.md Stage 10 for market-adaptive channel priority rules.

## Gmail (Email Outreach + Inbox Monitoring)
Access via gws CLI:
```bash
# Read inbox
gws gmail users messages list --params '{"userId":"me","maxResults":10}'

# Read specific message
gws gmail users messages get --params '{"userId":"me","id":"MESSAGE_ID"}'

# Send email
gws gmail users messages send --params '{"userId":"me"}' --body '{"raw":"BASE64_ENCODED_EMAIL"}'
```
Used for: Cold email sequences, inbox monitoring for replies, formal document delivery.

## Jina AI (Web Search + Content Extraction)
For proactive lead discovery and company research.

### Search (find potential buyers)
```bash
curl -s 'https://s.jina.ai/QUERY_URL_ENCODED' \
  -H 'Authorization: Bearer $JINA_API_KEY' \
  -H 'Accept: application/json'
```

### Read webpage (deep company research)
```bash
curl -s 'https://r.jina.ai/https://target-company.com' \
  -H 'Authorization: Bearer $JINA_API_KEY' \
  -H 'Accept: application/json'
```

API Key is injected via environment variable `JINA_API_KEY`. Get one free at https://jina.ai/

### Security Constraints
- **Blocked URLs**: Never read localhost, 127.0.0.1, 10.*, 192.168.*, 172.16-31.* (internal networks)
- **Rate limit**: Max 20 API calls per day (search + reader combined)
- **Query sanitization**: URL-encode all search queries, strip HTML tags and shell metacharacters

## Supermemory (Research Storage — L1 complement)
Semantic memory for research notes, competitor intel, and market insights.
- Auto-store research findings with appropriate tags
- Query before every outreach for relevant context
- Tags: customer_fact, competitor_intel, effective_tactic, market_signal
- Commands: `memory:add`, `memory:search`, `memory:list`, `memory:stats`

## Active Memory Plugin (Auto Context Before Replies — OpenClaw 2026.4.10+)
Optional plugin that inserts a dedicated memory sub-agent step before each main reply. The sub-agent automatically searches memory for relevant preferences, past lead details, deal context, and communication history — then surfaces the top results into the reply's context window without requiring any manual memory commands.

### Enable
```yaml
# in openclaw.json
plugins:
  active-memory:
    enabled: true
    mode: "recent"        # "message" | "recent" | "full"
    verbose: false        # set true to inspect what memory was pulled (use /verbose in chat)
    persistTranscripts: false   # opt-in debug transcript storage
```

### Context Modes
| Mode | Behavior | SDR Use Case |
|------|----------|--------------|
| `message` | Only the current message triggers memory search | Lowest latency; good for simple FAQs |
| `recent` | Last N messages used as search query | Recommended — captures thread context |
| `full` | Full conversation history used | Best recall; higher token cost |

### B2B SDR Value
Before replying to "What's my order status?", the agent automatically retrieves: which products the lead enquired about, their preferred shipping port, their negotiated pricing tier, and the last follow-up date — without any manual `memory:search` call in the prompt. Keeps multi-week sales threads coherent with zero extra prompting.

> Docs: https://docs.openclaw.ai/concepts/active-memory

## AI Model Provider (LLM Backend)
OpenClaw supports multiple AI model providers. The recommended provider is Claude (Anthropic), but the following are also fully supported as drop-in alternatives:

| Provider | API Type | Notes |
|----------|----------|-------|
| Anthropic (Claude) | Native | Default — recommended |
| OpenAI | openai-responses | GPT-4o, o3, etc. |
| Mistral | openai-completions | Full compat as of 2026-04-03 — use `api: openai-completions`, `provider: mistral` |
| Groq | openai-completions | Fast inference |
| Qwen (Alibaba) | openai-completions | Added v2026.4.5 — recommended for China deployments |
| MiniMax | openai-completions | Added v2026.4.5 — Chinese provider, good for multilingual tasks |
| Fireworks AI | openai-completions | Added v2026.4.5 — fast inference, open-source models |
| StepFun | openai-completions | Added v2026.4.5 — Chinese provider |
| Gemma 4 (Google) | openai-completions | Added v2026.4.7 — use `thinkingOff: true` for fast, non-reasoning responses |
| Arcee AI | openai-completions | Added v2026.4.7 — Trinity catalog; task-specialized models for targeted workflows |
| xAI / Grok | openai-completions | `api.grok.x.ai` recognized as native endpoint as of v2026.4.8 |
| Codex (GPT-5 family) | codex | Added v2026.4.10 — use `codex/gpt-5` or `codex/gpt-5.4`; Codex-managed auth, native threads, auto-compaction |
| Custom / self-hosted | openai-completions | Point `baseUrl` to your endpoint; add `allowPrivateNetwork: true` for trusted internal endpoints (v2026.4.10+) |

**Claude thinking blocks (v2026.4.8+):** Interleaved thinking blocks are now correctly preserved and forwarded for Claude Opus 4.5+, Sonnet 4.5+, and all Claude 4-family models. Earlier versions were silently stripping thinking blocks before forwarding, causing reasoning regressions on complex SDR tasks (multi-step BANT, objection handling chains, pricing negotiations). No config change needed — works automatically after upgrade.

**Claude compaction provider (v2026.4.8+):** You can now use a different (cheaper) model for session compaction without affecting your main conversation model:
```yaml
agents:
  defaults:
    compaction:
      provider: "claude-haiku-4-5"   # fast, cheap compaction; main model unchanged
```

**Mistral-specific notes (v2026.4.8+):** `reasoning_effort` is now sent for Mistral Small 4 with thinking-level mapping. OpenClaw also correctly uses `max_tokens` (not `max_completion_tokens`) and disables unsupported params (`store`) when the provider is Mistral. These apply automatically — no manual config needed.

**Memory vector recall (v2026.4.8+):** OpenClaw now shows an explicit warning when `sqlite-vec` is unavailable or writes are degraded, rather than silently falling back. If you see `[memory] sqlite-vec unavailable — vector recall disabled` in logs, install `sqlite-vec` on your server.

**Web Fetch (v2026.4.8+):** HTTP/2 is now explicitly disabled for undici 8.0 compatibility. If you run Node 22+ and experienced web-fetch failures in v2026.4.7, upgrade to v2026.4.8.

**Exa Search:** Now visible in the onboarding and provider pickers — it was previously hidden from the setup UI despite being a supported search provider.

**OpenAI reasoning effort default `high` (v2026.4.9+):** When no `reasoning_effort` is set, OpenAI Responses, WebSocket, and compatible completions transports now default to `high`. This increases token consumption for OpenAI users who previously relied on the implicit no-effort default. Set explicitly if needed:
```yaml
model:
  id: "o3"
  provider: "openai"
  reasoningEffort: "medium"   # override if "high" is too expensive
```

**Ollama thinking output (v2026.4.9+):** Ollama models using `api: "ollama"` now display thinking output when `/think` is set to a non-off level. Useful for local reasoning-model deployments where you want to inspect chain-of-thought.

**OpenRouter model refs (v2026.4.9+):** Provider-qualified model IDs containing slashes (e.g. `anthropic/claude-3-5-sonnet`) now correctly preserve the `openrouter/` prefix when submitted. Previously, picker selections would drop the prefix and fail allowlist validation.

**Provider auth aliases (v2026.4.9+):** Provider manifests now support `providerAuthAliases`, allowing provider variants to share a single set of environment variables and auth profiles. Useful when running multiple OpenAI-compatible or Anthropic-compatible endpoints (e.g., Azure + OpenAI, or multiple Ollama instances) without duplicating credentials.

**Codex/GPT-5 provider (v2026.4.10+):** Use `codex/gpt-5` or `codex/gpt-5.4` as the model ID. The bundled `codex` provider handles Codex-managed auth, native thread management, and automatic compaction. The standard `openai/gpt-*` path is unchanged. If you were using GPT-5 via the `openai` provider, migrate model IDs to `codex/gpt-5` for optimal performance.

**`openclaw exec-policy` CLI (v2026.4.10+):** Manage exec approval policy without editing config files manually. Use `openclaw exec-policy show` to inspect, `openclaw exec-policy preset secure` to apply a hardened preset, and `openclaw exec-policy set key=value` for granular overrides. Includes rollback safety to prevent policy drift:
```bash
openclaw exec-policy show                      # view current policy
openclaw exec-policy preset secure             # apply hardened preset
openclaw exec-policy set security=ask          # override individual keys
```

**Microsoft Teams message actions (v2026.4.10+):** New actions available for Teams channels: `pin`, `unpin`, `read`, `react`, `listReactions`. Pin confirmed deal terms or SLA commitments in Teams threads; react to acknowledge messages without breaking conversation flow.

**Gateway `commands.list` RPC (v2026.4.10+):** Remote clients can enumerate all agent commands (native, text, skill, plugin) via `commands.list`. Useful for external dashboards or n8n/Zapier automations that need to discover available agent capabilities dynamically.

**Agent timeout inheritance (v2026.4.9+):** LLM idle timeout now inherits `agents.defaults.timeoutSeconds` when configured. The idle watchdog is disabled for cron runs to prevent spurious timeout kills on long-processing SDR cron jobs. If your cron SDR agent was dying mid-task with "idle timeout" errors, configure:
```yaml
agents:
  defaults:
    timeoutSeconds: 300          # global task timeout
    llm:
      idleTimeoutSeconds: 120    # per-turn LLM idle limit (set explicitly to override inherited)
```

Set your model in the OpenClaw workspace config:
```yaml
model:
  id: "mistral-large-latest"
  provider: "mistral"
  api: "openai-completions"
```

## Webhook Ingress Plugin (Inbound Automation — OpenClaw 2026.4.7+)
Allows external systems (CRMs, n8n, Zapier, custom services) to create and drive TaskFlows via HTTP POST to the OpenClaw gateway. Ideal for triggering outreach sequences on new lead events.

### Setup
```yaml
# in openclaw.json
plugins:
  webhook-ingress:
    enabled: true
    secret: "{{WEBHOOK_SECRET}}"   # HMAC-SHA256 shared secret
    endpoint: "/webhooks/crm"      # gateway path (gateway must be LAN-bound)
```

### Trigger an outreach TaskFlow on new lead
```bash
# From your CRM / automation tool
curl -s -X POST "http://SERVER_IP:{{gateway_port}}/webhooks/crm" \
  -H "Content-Type: application/json" \
  -H "X-Webhook-Secret: $WEBHOOK_SECRET" \
  -d '{
    "event": "lead.created",
    "flow": "outreach-sequence",
    "data": {
      "name": "Li Wei",
      "company": "Shenzhen MFG Co",
      "phone": "+8613800138000",
      "source": "alibaba",
      "product_interest": "Industrial bearings"
    }
  }'
```

### Security
- Always use HTTPS in production (put gateway behind nginx + TLS)
- The `secret` field enforces HMAC-SHA256 validation — mismatched requests are rejected
- Gateway must be bound to `lan` (not `loopback`) to receive external webhook calls

## Slack (Enterprise Channel — Corporate Buyers)
Use Slack for enterprise accounts where buyers communicate primarily in shared Slack Connect channels.

### Corporate Proxy Support (v2026.4.8+)
Slack's Socket Mode WebSocket connections now honor ambient proxy environment variables. Required for deployments behind corporate firewalls:

```bash
# Set in your server environment or docker-compose
export HTTPS_PROXY="http://proxy.corp.example.com:3128"
export NO_PROXY="localhost,127.0.0.1,*.internal.corp"
```

OpenClaw picks these up automatically — no Slack-specific config required.

### SecretRef Bot Tokens
If your bot token is stored as a `SecretRef` (vault/k8s secret), token resolution is now stable across gateway restarts (`openclaw gateway restart` no longer invalidates the resolved token).

---

## Graphify (Knowledge Graph — Sales Intelligence)
Build queryable knowledge graphs from product catalogs, customer conversations, and market research.
- **Product graph**: Map product-kb → cross-sell paths, product families, spec relationships
- **Customer graph**: Map CRM + conversations → buying patterns, referral paths, stalled leads
- **Market graph**: Map research notes → competitive landscape, market opportunities

### Graph Query (runtime)
```bash
# Broad context around a topic
python3 -m graphify query "hydraulic excavator certification" --budget 1500

# Trace a specific relationship chain
python3 -m graphify query "Dubai fleet customer" --dfs --budget 1000
```

### Graph Outputs
- `graphify-out/GRAPH_REPORT.md` — God nodes, communities, knowledge gaps
- `graphify-out/graph.json` — Machine-readable graph (feed to CRM, reports)
- `graphify-out/graph.html` — Interactive visualization (share with owner)

### When to Query
- Before quotation → find cross-sell products
- Before cold outreach → understand prospect's market context
- During BANT → check product fit from graph relationships
- Weekly pipeline review → visualize customer clusters

## ChromaDB (Conversation History — L3 + L4)
Per-turn vector store with customer_id isolation and auto-tagging.
- L3: Every conversation turn auto-stored with quote/commitment/objection tags
- L4: Daily CRM snapshot as disaster recovery fallback
- Commands: `chroma:store`, `chroma:search`, `chroma:recall`, `chroma:snapshot`, `chroma:stats`
- Customer isolation: All queries scoped by customer_id (phone number)
