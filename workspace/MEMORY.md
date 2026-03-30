# MEMORY.md — 4-Layer Anti-Amnesia Operating Protocol

## Memory Architecture (4 Layers — Never Forget)

```
Message In → L1 MemOS auto-recall
           → L3 chroma:store (every turn)
           → L2 proactive-summary (at 65% token usage)
           → L4 CRM snapshot (daily 12:00 fallback)
```

| Layer | Engine | How It Works | Your Action |
|-------|--------|-------------|-------------|
| **L1: MemOS** | Structured memory | Auto-injects past memories at conversation start, auto-captures BANT/commitments/objections at end | Read what it gives you |
| **L2: Proactive Summary** | Token monitoring | Compresses at 65% context usage via haiku-class model. Zero info loss on numbers/quotes/commitments | Embed key-data summary past 20 turns |
| **L3: ChromaDB** | Per-turn vector store | Every turn stored with customer_id isolation + auto-tagging (quotes, commitments, objections) | Use `chroma:search` before outreach |
| **L4: CRM Snapshot** | Daily backup | 12:00 daily pipeline snapshot to ChromaDB as disaster recovery | None — automatic |

## Operating Rules (Every Conversation)

1. **Conversation Start**: Read MemOS snapshot. Naturally reference last topic for continuity.
2. **Before Outreach**: `chroma:search` + `memory:search` to recall customer history and research.
3. **Every Turn End**: L3 auto-stores turn. Mentally extract BANT changes, new commitments, objections.
4. **After Research**: `memory:add` findings to Supermemory (company intel, competitor data).
5. **Past 20 Turns**: Embed a brief key-data summary in your message (protects against L2 compression).
6. **Customer References Past**: Always `chroma:search` + `memory:search` before responding.
7. **Returning Customer (7+ day gap)**: `chroma:recall <customer_id>` for full history context.

## Command Reference

### Supermemory (Research & Insights)
```
memory:add "Ahmed from Dubai buys 50 units/quarter, prefers FOB" --type customer_fact
memory:add "Competitor X dropped prices 15% in West Africa" --type competitor_intel
memory:add "WhatsApp voice notes get 2x reply rate in ME" --type effective_tactic
memory:search "Dubai customer preferences" --limit 5
memory:list --type customer_fact
memory:stats
```

### ChromaDB (Conversation History)
```
chroma:store --customer "+971501234567" --turn 5 --user "price?" --agent "let me quote..." --stage qualifying --topic pricing
chroma:search "pricing discussion Dubai" --customer "+971501234567" --limit 5
chroma:recall "+971501234567" --limit 10
chroma:snapshot
chroma:stats
```

## Memory Priority Matrix

| Information Type | L1 MemOS | L2 Summary | L3 ChromaDB | L4 CRM | Retention |
|-----------------|----------|------------|-------------|--------|-----------|
| Customer BANT / commitments | Auto-capture | Preserved verbatim | Per-turn stored | — | Permanent |
| Quotes / pricing discussed | Auto-capture | Preserved verbatim | Auto-tagged `has_quote` | — | Permanent |
| Customer objections | Auto-capture | Preserved verbatim | Auto-tagged `has_objection` | — | Permanent |
| Company research / competitor intel | — | — | — | — | Permanent (Supermemory) |
| Effective scripts / patterns | — | — | — | — | Permanent (Supermemory) |
| Market signals / trends | — | — | — | — | 30 days (Supermemory) |
| Pipeline status | — | — | — | Daily snapshot | Permanent |
| Raw conversation turns | — | Compressed | Full text stored | — | Permanent (ChromaDB) |

## Cross-Session Continuity Rules

1. **Never start cold**: If MemOS injects memory, reference it naturally ("Following up on our discussion about X...")
2. **Track all commitments**: Yours and customer's. Overdue yours → apologize + remedy first.
3. **Detect returning customers**: CRM prior interaction → `chroma:recall` before responding.
4. **Handoff protection**: Before session end, ensure CRM updated + key research in Supermemory.
5. **Weekly memory hygiene**: Monday heartbeat → `memory:stats` + `chroma:stats`. Archive stale signals.

## Auto-Tagging (L3 ChromaDB)

Every stored turn is automatically analyzed and tagged:

| Tag | Triggers On |
|-----|-------------|
| `has_quote` | Price, cost, FOB, CIF, $, €, discount |
| `has_commitment` | "I will", "we'll send", "by Monday", promises |
| `has_objection` | "too expensive", "not interested", "competitor cheaper" |
| `has_order` | "place order", "confirm purchase", "deposit" |
| `has_sample` | "sample", "trial", "prototype" |

## L2 Compression Rules

When token usage hits 65%, the proactive summary engine:
1. Updates MemOS first (safety net)
2. Compresses with haiku-class model (fast, cheap)
3. **Preserves verbatim**: all numbers, quotes, commitments, BANT data
4. **Compresses**: small talk, repeated intros, multi-round confirmations
5. Stores compressed summary in ChromaDB
6. Keeps last 3 raw turns uncompressed

## CRM Column Mapping
> See USER.md → CRM Configuration

Source values: ctwa_facebook / ctwa_instagram / organic_whatsapp / referral / exhibition / website / web_discovery / outbound_email
Status values: new / contacted / interested / quote_sent / negotiating / meeting_set / closed_won / closed_lost / nurture / email_sent / email_replied

## Product Quick Reference
> See USER.md → Product Lines

## SDR Effectiveness Principles
- Mentioning prospect's recent events (funding, hiring, new projects) dramatically improves response rates
- WhatsApp optimal: 3-5 sentences, under 150 words
- Follow-up cadence: First touch → 3-day → 5-day → long-term nurture
- Stale threshold: 5 business days with no interaction
- CTWA lead golden window: First reply within 5 minutes
- Cold email peaks: Tuesday/Wednesday mornings (recipient local time)
- Multi-channel (WhatsApp + Email) doubles response rate vs single channel

## Learning Log
(Save confirmed patterns via `memory:add --type effective_tactic`)
