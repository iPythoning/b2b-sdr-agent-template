---
name: b2b-sdr-agent
description: "Open-source B2B AI SDR template. 7-layer context system with 10-stage sales pipeline, 4-layer anti-amnesia memory, 13 automated cron jobs, WhatsApp IP isolation, multi-channel (WhatsApp+Telegram+Email). Built on OpenClaw."
license: MIT-0
---

# B2B SDR Agent — AI Sales Development Representative

Turn any B2B export business into an AI-powered sales machine. Full-stack SDR that handles lead capture → qualification → follow-up → quoting → closing across WhatsApp, Telegram, and email.

## 7-Layer Context System

| Layer | File | Purpose |
|-------|------|---------|
| Identity | IDENTITY.md | Company name, role, product catalog |
| Soul | SOUL.md | Personality, values, communication rules |
| Workflow | AGENTS.md | 10-stage sales pipeline with stage gates |
| User | USER.md | Owner profile, ICP scoring, admin whitelist |
| Heartbeat | HEARTBEAT.md | 13-item pipeline inspection (cron) |
| Memory | MEMORY.md | 4-layer anti-amnesia protocol |
| Tools | TOOLS.md | CRM, channels, integrations |

## Key Features

- **10-Stage Sales Pipeline**: Cold Lead → Engaged → Qualified → Proposal → Negotiation → Closed
- **4-Layer Memory**: L1 pinned context, L2 session KV, L3 vector search, L4 CRM snapshots
- **13 Cron Jobs**: Auto heartbeat, follow-up reminders, lead scoring, pipeline reports
- **Multi-Channel**: WhatsApp, Telegram, Email — with channel-specific strategies
- **WhatsApp IP Isolation**: Per-tenant Cloudflare WARP proxy for multi-tenant deployments
- **Human-Like Conversations**: SDR humanizer skill for natural, trust-building messages
- **Operator Bilingual Mode**: English to customers + Chinese self-chat sync for non-English operators, zero config required

## Deploy

```bash
# One-click deploy
cp deploy/config.sh.example deploy/config.sh
# Edit config.sh with your server, API keys, and channel settings
./deploy/deploy.sh your-client-name
```

### IP Isolation (Multi-Tenant)

Each tenant gets a unique Cloudflare exit IP so WhatsApp sees independent devices:

```bash
./deploy/ip-isolate.sh tenant-name
```

Architecture: `tenant → wireproxy (SOCKS5, ~4MB) → WARP account → unique Cloudflare IP`

## Skills Included

- **sdr-humanizer** — Human-like conversation rules
- **delivery-queue** — Async message delivery with retry
- **lead-discovery** — AI-driven lead search and ICP scoring
- **quotation-generator** — PDF proforma invoice generation
- **chroma-memory** — Per-turn conversation memory with ChromaDB
- **telegram-toolkit** — Telegram-specific SDR strategies

## Requirements

- Linux server (Ubuntu 20.04+)
- Node.js 18+
- AI model API key (OpenAI, Anthropic, Google, etc.)
- [OpenClaw](https://openclaw.dev) gateway

## Links

- [GitHub](https://github.com/iPythoning/b2b-sdr-agent-template)
- [PulseAgent (Managed)](https://pulseagent.io/app)
