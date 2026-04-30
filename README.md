# B2B SDR Agent Template

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub Stars](https://img.shields.io/github/stars/iPythoning/b2b-sdr-agent-template)](https://github.com/iPythoning/b2b-sdr-agent-template/stargazers)
[![GitHub Issues](https://img.shields.io/github/issues/iPythoning/b2b-sdr-agent-template)](https://github.com/iPythoning/b2b-sdr-agent-template/issues)

<a href="https://www.producthunt.com/products/b2b-sdr-agent?embed=true&utm_source=badge-b2b-sdr-agent&utm_medium=badge&utm_source=badge-b2b-sdr-agent" target="_blank"><img src="https://ph-files.imgix.net/388786bc-d811-4059-9f0d-40d5fc49d848.png?auto=format&fit=crop&w=80&h=80" alt="PulseAgent B2B SDR Agent Skill - Product Hunt" width="80" height="80" align="left" style="margin-right:12px" /></a>

**We're live on Product Hunt!** → [PulseAgent B2B SDR Agent Skill](https://www.producthunt.com/products/b2b-sdr-agent?embed=true&utm_source=embed&utm_medium=post_embed) — Open-source AI SDR for WhatsApp, Email & Telegram. An upvote means the world to us 🙏

<br clear="left" />

> Turn any B2B export business into an AI-powered sales machine in 5 minutes.

> 🚀 **New · 2026-04-30** — **OpenClaw v2026.4.27**: DeepInfra joins as a bundled AI provider for cost-efficient large-scale inference, memory search gains bounded top-K results and streaming support, Codex Computer Use adds marketplace discovery with fail-closed safety, Docker sandbox gets GPU passthrough, and operator-managed outbound proxy routing lands for enterprise network compliance. [See full changelog →](./CHANGELOG.md)

An open-source, production-ready template for building AI Sales Development Representatives (SDRs) that handle the **full sales pipeline** — from lead capture to deal closing — across WhatsApp, Telegram, and email.

Built on [OpenClaw](https://openclaw.dev), battle-tested with real B2B export companies.

**🌐 English | [中文](./README.zh-CN.md) | [Español](./README.es.md) | [Français](./README.fr.md) | [العربية](./README.ar.md) | [Português](./README.pt-BR.md) | [日本語](./README.ja.md) | [Русский](./README.ru.md)**

---

## Architecture: 7-Layer Context System

```
┌─────────────────────────────────────────────────┐
│              AI SDR Agent                       │
├─────────────────────────────────────────────────┤
│  IDENTITY.md   → Who am I? Company, role        │
│  SOUL.md       → Personality, values, rules     │
│  AGENTS.md     → Full sales workflow (10 stages)│
│  USER.md       → Owner profile, ICP, scoring    │
│  HEARTBEAT.md  → 13-item pipeline inspection    │
│  MEMORY.md     → 4-layer anti-amnesia protocol  │
│  TOOLS.md      → CRM, channels, integrations    │
├─────────────────────────────────────────────────┤
│  Skills        → Extensible capabilities        │
│  Product KB    → Your product catalog           │
│  Cron Jobs     → 13 automated scheduled tasks   │
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

> Browse more skills on [ClawHub](https://clawhub.ai) — the AI agent skill marketplace.

Done. The skill installs the full 7-layer context system, delivery-queue, and sdr-humanizer into your workspace. Then customize:

```bash
# Edit the key files for your business
vim ~/.openclaw/workspace/skills/b2b-sdr-agent/references/IDENTITY.md
vim ~/.openclaw/workspace/skills/b2b-sdr-agent/references/USER.md

# Or copy to your main workspace
cp ~/.openclaw/workspace/skills/b2b-sdr-agent/references/*.md ~/.openclaw/workspace/
```

Replace all `{{placeholders}}` with your actual company info, and your AI SDR is live.

### Option A2: Hermes Agent Users (1 Command)

If you use [Hermes Agent](https://github.com/NousResearch/hermes-agent) instead of OpenClaw:

```bash
hermes skills install github:iPythoning/b2b-sdr-hermes-skill
```

Same 10-stage SDR pipeline, adapted for Hermes conventions (native cron, skill config, built-in WhatsApp). Migrating from OpenClaw? Run `hermes claw migrate` first, then install the skill.

→ [**b2b-sdr-hermes-skill repo**](https://github.com/iPythoning/b2b-sdr-hermes-skill)

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

### Automated Scheduling (13 Cron Jobs)

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
| Every 30 min | WhatsApp 72h window expiry check → auto-switch to Telegram |

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
| **Heartbeat** | `HEARTBEAT.md` | 13-item automated pipeline inspection + memory health |
| **Memory** | `MEMORY.md` | 4-layer anti-amnesia protocol (MemOS + Summary + ChromaDB + CRM) |
| **Tools** | `TOOLS.md` | CRM commands, channel config, web research, email access |

## Skills

Pre-built capabilities that extend your AI SDR:

| Skill | Description |
|-------|-------------|
| **delivery-queue** | Schedule messages with human-like delays. Drip campaigns, timed follow-ups. |
| **supermemory** | Semantic memory engine. Store research notes, competitor intel, market insights. |
| **chroma-memory** | Per-turn conversation storage with customer isolation, auto-tagging, and CRM snapshots. |
| **telegram-toolkit** | Bot commands, inline keyboards, large file handling, and Telegram-first market strategies. |
| **sdr-humanizer** | Rules for natural conversation — pacing, cultural adaptation, anti-patterns. |
| **lead-discovery** | AI-driven lead discovery. Web search for potential buyers, ICP evaluation, CRM auto-entry. |
| **quotation-generator** | Auto-generate PDF proforma invoices with company letterhead, multi-language support. |
| **graphify** | Knowledge graph engine — map product relationships, customer intelligence, and market research into queryable graphs. Powered by [graphify](https://github.com/safishamsi/graphify). |

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

### WhatsApp IP Isolation (Multi-Tenant)

When running multiple agents on the same server, each should have a unique exit IP so WhatsApp sees independent devices. This prevents cross-account flagging.

```bash
# After deploying a client, isolate their WhatsApp IP:
./deploy/ip-isolate.sh acme-corp

# Or with a specific SOCKS5 port:
./deploy/ip-isolate.sh acme-corp 40010
```

**How it works:**

```
                  ┌─ wireproxy :40001 → WARP Account A → CF IP-A
                  │    ↑
tenant-a ─────────┘    ALL_PROXY=socks5://host:40001

tenant-b ─────────┐    ALL_PROXY=socks5://host:40002
                  │    ↓
                  └─ wireproxy :40002 → WARP Account B → CF IP-B
```

Each tenant gets:
- A dedicated free [Cloudflare WARP](https://1.1.1.1/) account
- An isolated [wireproxy](https://github.com/pufferffish/wireproxy) instance (~4MB RAM)
- A unique Cloudflare exit IP for all outbound traffic (including WhatsApp)

To auto-enable during deploy, set `IP_ISOLATE=true` in `config.sh`.

### Managed Deployment

Don't want to self-host? **[PulseAgent](https://pulseagent.io/app)** offers fully managed B2B SDR agents with:
- One-click deployment
- Dashboard & analytics
- Multi-channel management
- Priority support

[Get Started →](https://pulseagent.io/app)

## Community

Join the conversation, ask questions, and share your use cases:

- [Discord](https://discord.gg/V3M23TJ3) — Real-time chat with the team
- [Telegram](https://t.me/PACommunitybot) — Community discussions
- [X / Twitter](https://x.com/PulseAgentHQ) — Announcements & updates
- [Product Hunt](https://www.producthunt.com/products/b2b-sdr-agent) — Upvote & reviews

**Learn more:**
- [PulseAgent Blog](https://pulseagent.io/en/blog) — Tutorials, release notes, and case studies
- [Open Source Hub](https://pulseagent.io/en/open-source) — All repos, docs, and ecosystem links
- [ClawHub](https://clawhub.ai) — Browse and install AI agent skills
- [Running on Kimi K2.6](docs/RUNNING-ON-KIMI.md) — LLM setup guide (pitfalls, auth profiles, context budgeting)

## Contributing

Contributions welcome! See our **[Contributing Guide](CONTRIBUTING.md)** for details. Areas where we'd love help:

- **Industry templates**: Add examples for your industry
- **Skills**: Build new capabilities
- **Translations**: Translate workspace templates to other languages
- **Documentation**: Improve guides and tutorials

## License

MIT — use it for anything.

---

<p align="center">
  Built with ❤️ by <a href="https://pulseagent.io/app">PulseAgent</a><br/>
  <em>Context as a Service — AI SDR for B2B Export</em>
</p>
