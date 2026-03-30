# chroma-memory — Per-Turn Conversation Memory with ChromaDB

> Long-term vector memory for customer conversations. Stores every turn with customer isolation, auto-tags quotes and commitments, enables semantic retrieval across sessions.

## Commands

| Command | Description |
|---------|-------------|
| `chroma:store` | Store a conversation turn (auto-called after each turn) |
| `chroma:search <query>` | Semantic search across conversation history |
| `chroma:recall <customer_id>` | Recall recent history for a returning customer |
| `chroma:snapshot` | Store daily CRM snapshot as fallback (L4) |
| `chroma:stats` | Show storage statistics |

## Usage

```bash
# Store a turn (normally auto-triggered by hook)
chroma:store --customer "+971501234567" --turn 5 --user "What's the price for 500 units?" --agent "Let me prepare a detailed quote..." --stage qualifying --topic pricing

# Search history
chroma:search "Dubai customer pricing discussion" --customer "+971501234567" --limit 5

# Recall for returning customer (auto-triggered when gap > 7 days)
chroma:recall "+971501234567" --limit 10

# Daily CRM snapshot (triggered by HEARTBEAT #12)
chroma:snapshot

# Stats
chroma:stats
```

## Architecture

This skill implements **Layer 3 (L3)** and **Layer 4 (L4)** of the 4-layer Anti-Amnesia system:

- **L3**: Every conversation turn → ChromaDB with customer_id isolation + auto-tagging
- **L4**: Daily CRM snapshot → ChromaDB as disaster recovery fallback

## Auto-Tagging

Turns are automatically tagged based on content analysis:

| Tag | Trigger |
|-----|---------|
| `has_quote` | Price/cost/quote discussed |
| `has_commitment` | Promise made by either party |
| `has_objection` | Customer objection detected |
| `has_order` | Order/purchase confirmed |
| `has_sample` | Sample request discussed |

## Customer Isolation

All data is partitioned by `customer_id` (phone number). Queries always include `where={"customer_id": ...}` to ensure strict tenant isolation.

## Dependencies

- `chromadb` skill (vector database, install via ClawHub)
- OpenClaw Gateway with session-memory hook enabled
