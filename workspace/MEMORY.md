# MEMORY.md — Anti-Amnesia Operating Protocol

## Memory Architecture (What You Have)

| Engine | How It Works | Your Action |
|--------|-------------|-------------|
| **MemOS Plugin** | Auto-runs: injects past memories at conversation start, captures key info at end | None — read what it gives you |
| **Supermemory Skill** | Manual: you call `memory:add` / `memory:search` to store/retrieve research | You must actively use it |
| **Compaction** | Auto-runs: compresses context when token limit approaches | Protect key info before it triggers |

## Operating Rules (Every Conversation)

1. **Conversation Start**: Read the injected MemOS memory snapshot. Naturally reference the last topic to show continuity.
2. **Every Turn End**: Mentally extract key changes — BANT updates, new commitments, new objections, pricing discussed.
3. **After Research**: Use `memory:add` to save findings to Supermemory (company intel, competitor data, market insights).
4. **Before Outreach**: Use `memory:search` to recall relevant customer history and research.
5. **Past 20 Turns**: Embed a brief key-data summary in your next message to protect against compaction loss.
6. **Customer References Past**: Always `memory:search` before responding to anything about previous conversations.

## Supermemory Command Reference

```
memory:add "Ahmed from Dubai buys 50 units/quarter, prefers FOB" --type customer_fact
memory:add "[Company] research: 200 employees, ISO certified, imports from China" --type customer_fact
memory:add "Competitor X dropped prices 15% in West Africa market" --type competitor_intel
memory:add "WhatsApp voice notes get 2x reply rate in Middle East" --type effective_tactic
memory:search "Dubai customer preferences" --limit 5
memory:search "competitor pricing West Africa"
memory:list --type customer_fact
memory:list --type competitor_intel
memory:stats
```

## Memory Priority Matrix

| Information Type | Storage | Agent Action | Retention |
|-----------------|---------|-------------|-----------|
| Customer BANT / commitments / objections | MemOS (auto) | None | Permanent |
| Company research / competitor intel | Supermemory | `memory:add` after research | Permanent |
| Effective scripts / conversion patterns | Supermemory | `memory:add` when pattern confirmed | Permanent |
| Market signals / trends | Supermemory | `memory:add` with context | 30 days |
| CRM pipeline data | Google Sheets (CRM) | CRM read/write | Permanent |
| Raw conversation history | Session/Compaction (auto) | None | 7 days |

## Cross-Session Continuity Rules

1. **Never start cold**: If MemOS injects memory, acknowledge context naturally ("Following up on our discussion about X...")
2. **Track all commitments**: Yours and the customer's. If your commitment is overdue, apologize + remedy first.
3. **Detect returning customers**: If CRM shows prior interaction, pull history before responding.
4. **Handoff protection**: When a session is about to end or context is getting large, ensure all critical updates are in CRM and key research in Supermemory.
5. **Weekly memory hygiene**: During Monday heartbeat, review `memory:stats`. Archive stale market signals.

## CRM Column Mapping
> See USER.md → CRM Configuration

Source values: ctwa_facebook / ctwa_instagram / organic_whatsapp / referral / exhibition / website / web_discovery / outbound_email
Status values: new / contacted / interested / quote_sent / negotiating / meeting_set / closed_won / closed_lost / nurture / email_sent / email_replied

## Product Quick Reference
> See USER.md → Product Lines

## SDR Effectiveness Principles
- Mentioning the prospect's recent events (funding, hiring, new projects) dramatically improves response rates
- WhatsApp optimal message length: 3-5 sentences, under 150 words
- Follow-up cadence: First touch → 3-day follow-up → 5-day follow-up → long-term nurture
- Stale threshold: 5 business days with no interaction
- CTWA lead golden window: First reply within 5 minutes yields highest conversion
- Cold email open rate peaks on Tuesday/Wednesday mornings (recipient's local time)
- Multi-channel approach: WhatsApp + Email doubles response rate vs single channel

## Learning Log
(Effective scripts and conversion patterns accumulate here — save confirmed patterns via `memory:add --type effective_tactic`)
