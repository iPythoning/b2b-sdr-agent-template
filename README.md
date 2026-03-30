# B2B SDR Agent Template

> Turn any B2B export business into an AI-powered sales machine in 5 minutes.

An open-source, production-ready template for building AI Sales Development Representatives (SDRs) that handle the **full sales pipeline** — from lead capture to deal closing — across WhatsApp, Telegram, and email.

Built on [OpenClaw](https://openclaw.dev), battle-tested with real B2B export companies.

**🌐 English | [中文](./README.zh-CN.md) | [Español](./README.es.md) | [Français](./README.fr.md) | [العربية](./README.ar.md) | [Português](./README.pt-BR.md) | [日本語](./README.ja.md) | [Русский](./README.ru.md)**

---

## Architecture: 7-Layer Context System

```
┌─────────────────────────────────────────────────┐
│              AI SDR Agent                        │
├─────────────────────────────────────────────────┤
│  IDENTITY.md   → Who am I? Company, role        │
│  SOUL.md       → Personality, values, rules     │
│  AGENTS.md     → Full sales workflow (10 stages)│
│  USER.md       → Owner profile, ICP, scoring    │
│  HEARTBEAT.md  → 12-item pipeline inspection    │
│  MEMORY.md     → 4-layer anti-amnesia protocol  │
│  TOOLS.md      → CRM, channels, integrations    │
├─────────────────────────────────────────────────┤
│  Skills        → Extensible capabilities        │
│  Product KB    → Your product catalog           │
│  Cron Jobs     → 12 automated scheduled tasks   │
├─────────────────────────────────────────────────┤
│  OpenClaw Gateway (WhatsApp / Telegram / Email) │
└─────────────────────────────────────────────────┘
```

Each layer is a Markdown file you customize for your business. The AI reads all layers on every conversation, giving it deep context about your company, products, and sales strategy.

## Quick Start

### Option A: OpenClaw Users (1 Command)

If you already have [OpenClaw](https://openclaw.dev) running:

```bash
clawhub install b2b-sdr-agent
```

Done. The skill installs the full 7-layer context system, delivery-queue, and sdr-humanizer into your workspace. Then customize:

```bash
# Edit the key files for your business
vim ~/.openclaw/workspace/skills/b2b-sdr-agent/references/IDENTITY.md
vim ~/.openclaw/workspace/skills/b2b-sdr-agent/references/USER.md

# Or copy to your main workspace
cp ~/.openclaw/workspace/skills/b2b-sdr-agent/references/*.md ~/.openclaw/workspace/
```

Replace all `{{placeholders}}` with your actual company info, and your AI SDR is live.

### Option B: Full Deployment (5 Minutes)

#### 1. Clone & Configure

```bash
git clone https://github.com/iPythoning/b2b-sdr-agent-template.git
cd b2b-sdr-agent-template

# Edit the 7 workspace files for your business
vim workspace/IDENTITY.md   # Company info, role, pipeline
vim workspace/USER.md       # Your products, ICP, competitors
vim workspace/SOUL.md       # AI personality and rules
```

#### 2. Set Up Deployment Config

```bash
cd deploy
cp config.sh.example config.sh
vim config.sh               # Fill in: server IP, API key, WhatsApp number
```

#### 3. Deploy

```bash
./deploy.sh my-company

# Output:
# ✅ Deploy Complete: my-company
# Gateway:  ws://your-server:18789
# WhatsApp: Enabled
# Skills:   b2b_trade (28 skills)
```

That's it. Your AI SDR is live on WhatsApp and ready to sell.

## What It Does

### Full-Pipeline Sales Automation (10 Stages)

| Stage | What the AI Does |
|-------|-----------------|
| **1. Lead Capture** | Auto-detect inbound messages (WhatsApp/Telegram/CTWA ads), create CRM records |
| **2. BANT Qualification** | Natural conversation to assess Budget, Authority, Need, Timeline |
| **3. CRM Entry** | Structured data capture — name, company, country, ICP score, product interest |
| **4. Research & Enrichment** | Jina AI web search + company website analysis, 3-layer enrichment pipeline |
| **5. Quotation** | Auto-generate PDF quotes, multi-language, send to owner for approval |
| **6. Negotiation** | Track counter-offers, recommend strategy, escalate when needed |
| **7. Reporting** | Daily 09:00 pipeline reports, 15:00 stalled alerts, weekly summaries |
| **8. Nurture** | Automated follow-ups, industry news, post-sale care, quarterly check-ins |
| **9. Email Outreach** | Personalized cold email sequences (Day 1/3/7/14), auto follow-up |
| **10. Multi-Channel Orchestration** | Cross-channel coordination (WhatsApp + Email + Telegram), auto-switching |

### Automated Scheduling (12 Cron Jobs)

| Schedule | Task |
|----------|------|
| Every 30 min | Gmail inbox scan for client replies |
| Daily 09:00 | Pipeline report to owner via WhatsApp |
| Daily 10:00 | AI lead discovery (market rotation: Africa/ME/SEA/LatAm) |
| Daily 11:00 | Email follow-up sequence check |
| Daily 15:00 | Stalled lead detection |
| Weekly Wed | Nurture campaign |
| Weekly Fri | Competitor intelligence gathering |
| Weekly Mon | Weekly summary report |
| Daily 12:00 | CRM snapshot to ChromaDB (L4 disaster recovery) |
| Daily 14:00 | Memory health check (Supermemory + ChromaDB stats) |

### Human-Like Conversations
- Responds in the customer's language (auto-detected)
- Natural message pacing with delivery-queue skill (3-90s delays, message splitting)
- Timezone-aware sending (7 market timezone mappings)
- Cultural adaptation (Middle East, Africa, SEA, LatAm, Europe)
- Never reveals AI identity — presents as your sales consultant

### Dynamic ICP Scoring
- Initial score based on 5 weighted dimensions (purchase volume, product match, region, payment ability, authority)
- **Auto-adjusts** based on interaction: fast reply +1, asks for quote +2, mentions competitor +2, 7d no reply -1
- Hot leads (ICP>=7) auto-flagged, owner notified immediately

### 4-Layer Anti-Amnesia System

AI agents lose context in long conversations and across sessions. Our **4-layer anti-amnesia architecture** ensures your AI SDR never forgets:

```
Message In ──→ L1 MemOS auto-recall (structured memory injection)
    │
    ├──→ L3 ChromaDB per-turn store (customer-isolated, auto-tagged)
    │
    ├──→ L2 Proactive Summary at 65% tokens (haiku compression, zero info loss)
    │
    └──→ L4 CRM Snapshot daily 12:00 (disaster recovery fallback)
```

| Layer | Engine | What It Does |
|-------|--------|-------------|
| **L1: MemOS** | Structured memory | Auto-extracts BANT, commitments, objections every turn. Injects into System Prompt at conversation start. |
| **L2: Proactive Summary** | Token monitoring | Compresses at 65% context usage via haiku-class model. All numbers, quotes, commitments preserved verbatim. |
| **L3: ChromaDB** | Per-turn vector store | Every conversation turn stored with `customer_id` isolation. Auto-tags quotes, commitments, objections. Semantic retrieval across sessions. |
| **L4: CRM Snapshot** | Daily backup | Stores full pipeline state daily to ChromaDB as disaster recovery. If any layer fails, L4 has the data. |

**Result**: Your AI SDR remembers every customer, every quote, every commitment — even after 100+ turns, weeks of silence, or system restarts.

> See **[ANTI-AMNESIA.md](./ANTI-AMNESIA.md)** for the full implementation spec with code, prompts, and deployment guide.

## The 7 Layers Explained

| Layer | File | Purpose |
|-------|------|---------|
| **Identity** | `IDENTITY.md` | Company info, role definition, pipeline stages, lead tiering |
| **Soul** | `SOUL.md` | AI personality, communication style, hard rules, growth mindset |
| **Agents** | `AGENTS.md` | 10-stage sales workflow, BANT qualification, multi-channel orchestration |
| **User** | `USER.md` | Owner profile, product lines, ICP scoring, competitors |
| **Heartbeat** | `HEARTBEAT.md` | 12-item automated pipeline inspection + memory health |
| **Memory** | `MEMORY.md` | 4-layer anti-amnesia protocol (MemOS + Summary + ChromaDB + CRM) |
| **Tools** | `TOOLS.md` | CRM commands, channel config, web research, email access |

## Skills

Pre-built capabilities that extend your AI SDR:

| Skill | Description |
|-------|-------------|
| **delivery-queue** | Schedule messages with human-like delays. Drip campaigns, timed follow-ups. |
| **supermemory** | Semantic memory engine. Store research notes, competitor intel, market insights. |
| **chroma-memory** | Per-turn conversation storage with customer isolation, auto-tagging, and CRM snapshots. |
| **sdr-humanizer** | Rules for natural conversation — pacing, cultural adaptation, anti-patterns. |
| **lead-discovery** | AI-driven lead discovery. Web search for potential buyers, ICP evaluation, CRM auto-entry. |
| **quotation-generator** | Auto-generate PDF proforma invoices with company letterhead, multi-language support. |

### Skill Profiles

Choose a pre-configured skill set based on your needs:

| Profile | Skills | Best For |
|---------|--------|----------|
| `b2b_trade` | 28 skills | B2B export companies (default) |
| `lite` | 16 skills | Getting started, low-volume |
| `social` | 14 skills | Social media-focused sales |
| `full` | 40+ skills | Everything enabled |

## Industry Examples

Ready-to-use configurations for common B2B export verticals:

| Industry | Directory | Highlights |
|----------|-----------|------------|
| **Heavy Vehicles** | `examples/heavy-vehicles/` | Trucks, machinery, fleet sales, African/ME markets |
| **Consumer Electronics** | `examples/electronics/` | OEM/ODM, Amazon sellers, sample-driven sales |
| **Textiles & Garments** | `examples/textiles/` | Sustainable fabrics, GOTS certified, EU/US markets |

To use an example, copy it into your workspace:

```bash
cp examples/heavy-vehicles/IDENTITY.md workspace/IDENTITY.md
cp examples/heavy-vehicles/USER.md workspace/USER.md
# Then customize for your specific business
```

## Product Knowledge Base

Structure your product catalog so the AI can generate accurate quotes:

```
product-kb/
├── catalog.json                    # Product catalog with specs, MOQ, lead times
├── products/
│   └── example-product/info.json   # Detailed product info
└── scripts/
    └── generate-pi.js              # Proforma invoice generator
```

## Control Dashboard

After deployment, your AI SDR comes with a built-in web dashboard:

```
http://YOUR_SERVER_IP:18789/?token=YOUR_GATEWAY_TOKEN
```

The dashboard shows:
- Real-time bot status and WhatsApp connection
- Message history and conversation threads
- Cron job execution status
- Channel health monitoring

The token is auto-generated during deployment and printed in the output. Keep it private — anyone with the URL+token has full access.

> **Security note**: Set `GATEWAY_BIND="loopback"` in config.sh to disable remote dashboard access. Default is `"lan"` (accessible from network).

## WhatsApp Configuration

By default, the AI SDR accepts messages from **all WhatsApp contacts** (`dmPolicy: "open"`). This is the recommended setting for sales agents — you want every potential customer to be able to reach you.

| Setting | Value | Meaning |
|---------|-------|---------|
| `WHATSAPP_DM_POLICY` | `"open"` (default) | Accept DMs from anyone |
| | `"allowlist"` | Only accept from `ADMIN_PHONES` |
| | `"pairing"` | Require pairing code first |
| `WHATSAPP_GROUP_POLICY` | `"allowlist"` (default) | Only respond in whitelisted groups |

To change after deployment, edit `~/.openclaw/openclaw.json` on the server:

```json
{
  "channels": {
    "whatsapp": {
      "dmPolicy": "open",
      "allowFrom": ["*"]
    }
  }
}
```

Then restart: `systemctl --user restart openclaw-gateway`

## Deployment

### Prerequisites
- A Linux server (Ubuntu 20.04+ recommended)
- Node.js 18+
- An AI model API key (OpenAI, Anthropic, Google, Kimi, etc.)
- WhatsApp Business account (optional but recommended)

### Configuration

All configuration lives in `deploy/config.sh`. Key sections:

```bash
# Server
SERVER_HOST="your-server-ip"

# AI Model
PRIMARY_API_KEY="sk-..."

# Channels
WHATSAPP_ENABLED=true
TELEGRAM_BOT_TOKEN="..."

# CRM
SHEETS_SPREADSHEET_ID="your-google-sheets-id"

# Admin (who can manage the AI)
ADMIN_PHONES="+1234567890"
```

### Managed Deployment

Don't want to self-host? **[PulseAgent](https://ai.pulseagent.io)** offers fully managed B2B SDR agents with:
- One-click deployment
- Dashboard & analytics
- Multi-channel management
- Priority support

[Get Started →](https://ai.pulseagent.io)

## Contributing

Contributions welcome! Areas where we'd love help:

- **Industry templates**: Add examples for your industry
- **Skills**: Build new capabilities
- **Translations**: Translate workspace templates to other languages
- **Documentation**: Improve guides and tutorials

## License

MIT — use it for anything.

---

<p align="center">
  Built with ❤️ by <a href="https://ai.pulseagent.io">PulseAgent</a><br/>
  <em>Context as a Service — AI SDR for B2B Export</em>
</p>
