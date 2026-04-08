# TOOLS.md — Tool Configuration

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
| Custom / self-hosted | openai-completions | Point `baseUrl` to your endpoint |

**Mistral-specific notes:** OpenClaw now correctly uses `max_tokens` (not `max_completion_tokens`) and disables unsupported OpenAI-specific params (`store`, `reasoning_effort`) when the provider is Mistral or the `baseUrl` points to `api.mistral.ai`. This fix applies automatically — no manual config needed.

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
