# B2B SDR Agent Template

> Turn any B2B export business into an AI-powered sales machine in 5 minutes.

An open-source, production-ready template for building AI Sales Development Representatives (SDRs) that handle the **full sales pipeline** — from lead capture to deal closing — across WhatsApp, Telegram, and email.

Built on [OpenClaw](https://openclaw.dev), battle-tested with real B2B export companies.

**🌐 English | [中文](./README.zh-CN.md) | [Español](./README.es.md) | [Français](./README.fr.md) | [العربية](./README.ar.md) | [Português](./README.pt-BR.md) | [日本語](./README.ja.md) | [Русский](./README.ru.md)**

---

## Architecture: 7-Layer Context System

```
┌─────────────────────────────────────────────┐
│              AI SDR Agent                    │
├─────────────────────────────────────────────┤
│  IDENTITY.md   → Who am I? Company, role    │
│  SOUL.md       → Personality, values, rules │
│  AGENTS.md     → Full sales workflow (8 stages) │
│  USER.md       → Owner profile, ICP, scoring│
│  HEARTBEAT.md  → Automated pipeline checks  │
│  MEMORY.md     → 3-tier memory architecture │
│  TOOLS.md      → CRM, channels, integrations│
├─────────────────────────────────────────────┤
│  Skills        → Extensible capabilities    │
│  Product KB    → Your product catalog       │
├─────────────────────────────────────────────┤
│  OpenClaw Gateway (WhatsApp / Telegram)     │
└─────────────────────────────────────────────┘
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

### Full-Pipeline Sales Automation

| Stage | What the AI Does |
|-------|-----------------|
| **Lead Capture** | Auto-detect inbound messages, create CRM records, extract key info |
| **BANT Qualification** | Natural conversation to assess Budget, Authority, Need, Timeline |
| **Research** | Search prospect's company, LinkedIn, news — update ICP score |
| **Quotation** | Generate quotes, send to owner for approval, deliver to customer |
| **Negotiation** | Track counter-offers, recommend strategy, escalate when needed |
| **Reporting** | Daily pipeline reports, stalled lead alerts, weekly summaries |
| **Nurture** | Automated follow-ups, industry news, post-sale care |

### Human-Like Conversations
- Responds in the customer's language (auto-detected)
- Natural message pacing with delivery-queue skill
- Cultural adaptation (Middle East, Africa, SEA, LatAm, Europe)
- Never reveals AI identity — presents as your sales consultant

### Smart Memory
- **Hot memory**: Company context loaded every session
- **Warm memory**: Daily conversation logs, loaded on demand
- **Cold memory**: Archived insights, searchable via vector DB

## The 7 Layers Explained

| Layer | File | Purpose |
|-------|------|---------|
| **Identity** | `IDENTITY.md` | Company info, role definition, pipeline stages, lead tiering |
| **Soul** | `SOUL.md` | AI personality, communication style, hard rules, growth mindset |
| **Agents** | `AGENTS.md` | 8-stage sales workflow, BANT qualification, security policy |
| **User** | `USER.md` | Owner profile, product lines, ICP scoring, competitors |
| **Heartbeat** | `HEARTBEAT.md` | Automated pipeline inspection — new leads, stalled deals, data quality |
| **Memory** | `MEMORY.md` | 3-tier memory architecture, SDR effectiveness principles |
| **Tools** | `TOOLS.md` | CRM commands, channel config, web research, email access |

## Skills

Pre-built capabilities that extend your AI SDR:

| Skill | Description |
|-------|-------------|
| **delivery-queue** | Schedule messages with human-like delays. Drip campaigns, timed follow-ups. |
| **supermemory** | Semantic memory engine. Auto-capture customer insights, search across all conversations. |
| **sdr-humanizer** | Rules for natural conversation — pacing, cultural adaptation, anti-patterns. |

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
