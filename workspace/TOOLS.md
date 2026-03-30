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

## WhatsApp (Primary Conversation Channel)
AI directly replies to customer inquiries — no human relay.
Channel policy: `dmPolicy: "open"`, `allowFrom: ["*"]` — accept all contacts.
CTWA ad leads can be replied to directly (72-hour conversation window).

### 72-Hour Window Handling
WhatsApp Business API restricts outbound messages after 72h of customer inactivity:
1. Before sending, check: `now() - last_customer_message < 72h`
2. If expired: Switch to email channel or notify owner for manual WhatsApp contact
3. Never mark CRM as "contacted" if message delivery actually failed
4. Implement delivery receipt verification — check for sent/delivered/read status

## Control Dashboard
Web UI for monitoring bot status, conversations, and cron jobs.
Access: `http://SERVER_IP:{{gateway_port}}/?token={{gateway_token}}`
Gateway bind: `lan` (network accessible). Change to `loopback` for localhost-only.

## Telegram (Secondary Channel)
Quick updates, document sharing. Use WhatsApp for detailed discussion.

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

API Key in .secrets/env (JINA_API_KEY). Get one free at https://jina.ai/

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

## ChromaDB (Conversation History — L3 + L4)
Per-turn vector store with customer_id isolation and auto-tagging.
- L3: Every conversation turn auto-stored with quote/commitment/objection tags
- L4: Daily CRM snapshot as disaster recovery fallback
- Commands: `chroma:store`, `chroma:search`, `chroma:recall`, `chroma:snapshot`, `chroma:stats`
- Customer isolation: All queries scoped by customer_id (phone number)
