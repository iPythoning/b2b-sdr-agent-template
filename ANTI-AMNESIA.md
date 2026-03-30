# Anti-Amnesia Implementation Spec v2.0
# PulseAgent x OpenClaw B2B SDR Digital Worker
# Version: v2.0 | 2026-03-30

---

## Overview

This document is an **executable implementation spec**. Import it into your OpenClaw Agent's Knowledge Base or attach it as a System Prompt supplement. The Agent will automatically build a **four-layer** anti-amnesia mechanism:

1. **Layer 1: MemOS Structured Memory** — Key business state persistence, auto-extract/inject every turn
2. **Layer 2: Proactive Summary Trigger** — Token threshold monitoring (65%), haiku-class compression, zero info loss
3. **Layer 3: ChromaDB Per-Turn Storage** — Every turn stored with customer_id isolation + auto-tagging (quotes, commitments, objections)
4. **Layer 4: CRM Snapshot Fallback** — Daily pipeline backup to ChromaDB as disaster recovery

---

## Prerequisites

```yaml
required_skills:
  - name: "chromadb"          # Vector database skill
    source: ClawHub
    status: must_install

  - name: "gog"               # Google Sheets/Calendar sync
    source: ClawHub
    status: already_installed

  - name: "summarize"         # Summary generation skill
    source: ClawHub
    status: already_installed

external_services:
  - name: "MemOS"
    dashboard: "https://memos-dashboard.openmem.net"
    api_endpoint: "https://api.openmem.net/v1"
    auth: "Bearer <YOUR_MEMOS_API_KEY>"
    note: "Free tier available"

environment_variables:
  MEMOS_API_KEY: "<from MemOS Dashboard>"
  MEMOS_NAMESPACE: "pulseagent_prod"
  CHROMA_COLLECTION: "conversation_history"
  TOKEN_THRESHOLD: 0.65        # Context usage trigger threshold (65%)
  MEMORY_EXTRACT_INTERVAL: 1   # Extract memory every 1 conversation turn
```

---

## LAYER 1: MemOS Structured Memory

### 1.1 Memory Schema

Each customer conversation maintains a structured memory object, stored in MemOS:

```json
{
  "memory_type": "customer_session",
  "customer_id": "{{whatsapp_phone_number}}",
  "last_updated": "{{ISO_8601_timestamp}}",
  "version": 1,

  "identity": {
    "name": "",
    "company": "",
    "role": "",
    "language": "",
    "timezone": ""
  },

  "bant": {
    "budget": "",
    "authority": "",
    "need": "",
    "timeline": ""
  },

  "conversation_state": {
    "stage": "first_contact | qualifying | pitched | objection_handling | negotiation | closed_won | closed_lost | dormant",
    "last_topic": "",
    "pending_action": "",
    "next_followup_date": "",
    "human_escalation_needed": false
  },

  "product_interest": {
    "products_discussed": [],
    "preferred_specs": {},
    "moq_discussed": "",
    "price_range_discussed": "",
    "samples_requested": false,
    "quotes_sent": []
  },

  "objections_log": [
    {
      "objection": "",
      "response_given": "",
      "resolved": false,
      "timestamp": ""
    }
  ],

  "commitments": [
    {
      "who": "agent | customer",
      "what": "",
      "by_when": "",
      "status": "pending | done | overdue"
    }
  ],

  "key_facts": []
}
```

### 1.2 Memory Extraction Prompt (auto-execute after each turn)

Configure this as an OpenClaw **Post-Conversation Hook**. If hooks are unavailable, run as a Cron skill checking for new completed conversations every minute.

```
You are a memory extractor. Your sole task is to extract structured information
from conversation content and update the customer memory object.

## Input
- Current conversation content (latest turn or multiple turns)
- Existing memory object (if any)

## Rules
1. Only extract factual information, no speculation
2. If a field has no new information, keep the existing value unchanged
3. If new information contradicts old information, overwrite with the new,
   and record the change in key_facts
4. conversation_state.stage can only advance forward in the state machine,
   never backward (unless customer explicitly says "no longer interested")
5. All timestamps use ISO 8601 format
6. In commitments, if by_when has passed and status is still pending,
   auto-change to overdue

## Output
Output only the updated JSON object, no explanatory text.
```

### 1.3 Memory Injection Template (inject into System Prompt at conversation start)

Add the following dynamic section to the Agent's System Prompt:

```
## Customer Memory Snapshot (auto-injected, do not manually edit)

[Customer] {{identity.name}} | {{identity.company}} | {{identity.role}}
[Language] {{identity.language}}
[Stage] {{conversation_state.stage}}
[BANT]
  - Budget: {{bant.budget}}
  - Authority: {{bant.authority}}
  - Need: {{bant.need}}
  - Timeline: {{bant.timeline}}
[Product Interest] {{product_interest.products_discussed | join(", ")}}
[Spec Preferences] {{product_interest.preferred_specs | json}}
[Quote History] {{product_interest.quotes_sent | json}}
[Samples] {{product_interest.samples_requested ? "Requested" : "Not requested"}}
[Last Topic] {{conversation_state.last_topic}}
[Pending Action] {{conversation_state.pending_action}}
[Next Follow-up] {{conversation_state.next_followup_date}}
[Unresolved Objections]
{% for obj in objections_log if not obj.resolved %}
  - {{obj.objection}} (last response: {{obj.response_given}})
{% endfor %}
[Outstanding Commitments]
{% for c in commitments if c.status == "pending" or c.status == "overdue" %}
  - [{{c.status | upper}}] {{c.who}}: {{c.what}} (due: {{c.by_when}})
{% endfor %}
[Key Facts]
{% for fact in key_facts[-5:] %}
  - {{fact}}
{% endfor %}
```

### 1.4 MemOS API Call Flow

```python
# === Read memory (at conversation start) ===

import requests
import json

MEMOS_API = "https://api.openmem.net/v1"
HEADERS = {
    "Authorization": "Bearer <MEMOS_API_KEY>",
    "Content-Type": "application/json"
}

def get_customer_memory(customer_id: str) -> dict:
    """Read customer memory from MemOS"""
    resp = requests.get(
        f"{MEMOS_API}/memories",
        headers=HEADERS,
        params={
            "namespace": "pulseagent_prod",
            "filter": json.dumps({
                "memory_type": "customer_session",
                "customer_id": customer_id
            }),
            "limit": 1
        }
    )
    if resp.status_code == 200 and resp.json().get("data"):
        return resp.json()["data"][0]
    return None  # New customer, no history


# === Write memory (at conversation end) ===

def upsert_customer_memory(customer_id: str, memory_obj: dict):
    """Write or update customer memory to MemOS"""
    memory_obj["customer_id"] = customer_id
    memory_obj["memory_type"] = "customer_session"

    resp = requests.post(
        f"{MEMOS_API}/memories/upsert",
        headers=HEADERS,
        json={
            "namespace": "pulseagent_prod",
            "key": f"customer:{customer_id}",
            "value": memory_obj
        }
    )
    return resp.status_code == 200
```

---

## LAYER 2: Proactive Summary Trigger

### 2.1 Token Monitoring Logic

Configure in OpenClaw as a Heartbeat skill or embed the following logic:

```python
# === Token usage monitoring ===

import tiktoken

MODEL_MAX_TOKENS = {
    "claude-haiku-4-5": 200000,
    "claude-sonnet-4-5": 200000,
    "claude-opus-4-6": 200000,
    "gpt-4o": 128000,
    "kimi-2.5": 128000,
    "deepseek-v3.2": 128000,
}

def estimate_token_usage(messages: list, model: str) -> float:
    """Estimate current conversation token usage ratio"""
    try:
        enc = tiktoken.encoding_for_model("gpt-4o")  # Universal approximation
    except:
        enc = tiktoken.get_encoding("cl100k_base")

    total_tokens = sum(len(enc.encode(str(m))) for m in messages)
    max_tokens = MODEL_MAX_TOKENS.get(model, 128000)

    return total_tokens / max_tokens


def should_trigger_compaction(messages: list, model: str) -> bool:
    """Trigger proactive summary when usage exceeds 65%"""
    usage = estimate_token_usage(messages, model)
    return usage >= 0.65
```

### 2.2 Proactive Summary Prompt

When `should_trigger_compaction()` returns True, immediately execute:

```
You are a conversation compressor. Your task is to compress the current
conversation history into a concise structured summary with zero information loss.

## Compression Rules

1. **Must preserve (verbatim or equivalent):**
   - Customer's explicit needs, quantities, budget, timeline
   - Sent quote numbers and terms
   - Commitments and agreements from both sides
   - Customer objections and Agent's responses
   - Customer emotional signals (dissatisfaction, hesitation, enthusiasm)
   - All specific numbers involving amounts, dates, quantities

2. **Can compress:**
   - Small talk and pleasantries -> "[rapport established]"
   - Repeated product introductions -> "[introduced product X, emphasized Y and Z]"
   - Multi-round confirmations -> "[after multiple rounds, finalized as X]"

3. **Never discard:**
   - Any numbers (prices, quantities, dates)
   - Customer decision signals ("I need to discuss with my boss", "send a sample")
   - Incomplete action items

## Output Format

=== Conversation Summary (compressed at {{timestamp}}) ===

[Turns] Original {{N}} turns -> Compressed
[Customer Stage] {{stage}}
[Key Conversation Threads]
1. [time] Event/information
2. [time] Event/information
...

[Verbatim Preserved]
- Quote: "..."
- Customer (key): "..."
- Commitment: "..."

[Compressed]
- [Ice-breaking complete, customer tone friendly]
- [Introduced product line, customer interested in model X]
...

=== Summary End ===
```

### 2.3 Compaction Execution Flow

```python
def execute_compaction(agent, messages: list, model: str):
    """
    Proactive summary execution:
    1. Update MemOS memory first (safety net)
    2. Generate conversation summary
    3. Replace historical messages with summary
    4. Re-inject MemOS memory snapshot
    """

    # Step 1: Update MemOS first (safety net)
    memory_obj = extract_memory_from_conversation(messages)
    upsert_customer_memory(customer_id, memory_obj)

    # Step 2: Generate summary
    summary = agent.call_llm(
        system_prompt=COMPACTION_PROMPT,
        messages=[{
            "role": "user",
            "content": f"Please compress the following conversation:\n\n{format_messages(messages)}"
        }]
    )

    # Step 3: Rebuild message queue
    new_messages = [
        {
            "role": "system",
            "content": f"{ORIGINAL_SYSTEM_PROMPT}\n\n{inject_memory(memory_obj)}"
        },
        {
            "role": "assistant",
            "content": summary
        },
        # Keep last 3 turns of raw conversation (latest info uncompressed)
        *messages[-6:]  # Last 3 turns = 6 messages (user+assistant each)
    ]

    return new_messages
```

### 2.4 Cron Configuration

```yaml
cron_jobs:
  - name: "token_monitor"
    schedule: "*/1 * * * *"     # Every minute
    action: |
      Check token usage ratio for all active conversations.
      If any exceeds 65%, immediately execute proactive summary.
      After summary, insert invisible marker [COMPACTED_AT:timestamp].

  - name: "memory_sync"
    schedule: "*/5 * * * *"     # Every 5 minutes
    action: |
      Sync latest memory extraction results from all active conversations to MemOS.
      Also sync to Google Sheets (via gog skill) as backup.

  - name: "stale_memory_cleanup"
    schedule: "0 3 * * *"       # Daily at 3:00 AM
    action: |
      Check MemOS for customer memories with last_updated > 90 days.
      Mark as dormant but do not delete.
      Generate summary report and send to admin.
```

---

## LAYER 3: ChromaDB Long-Term Memory

### 3.1 Collection Setup

```python
import chromadb

client = chromadb.Client()

collection = client.get_or_create_collection(
    name="conversation_history",
    metadata={
        "description": "Long-term memory store for all customer conversations",
        "hnsw:space": "cosine"
    }
)
```

### 3.2 Conversation Storage Schema

```python
def store_conversation_turn(
    customer_id: str,
    turn_number: int,
    user_message: str,
    agent_response: str,
    metadata: dict
):
    """Store each conversation turn in ChromaDB"""

    doc_id = f"{customer_id}_turn_{turn_number}_{metadata['timestamp']}"

    document = f"""
[Customer {customer_id}] [{metadata['timestamp']}] [Turn {turn_number}]
Customer: {user_message}
Agent: {agent_response}
Stage: {metadata.get('stage', 'unknown')}
Topic: {metadata.get('topic', 'general')}
"""

    collection.add(
        documents=[document],
        ids=[doc_id],
        metadatas=[{
            "customer_id": customer_id,
            "turn_number": turn_number,
            "timestamp": metadata["timestamp"],
            "stage": metadata.get("stage", "unknown"),
            "topic": metadata.get("topic", "general"),
            "has_quote": metadata.get("has_quote", False),
            "has_objection": metadata.get("has_objection", False),
            "has_commitment": metadata.get("has_commitment", False),
        }]
    )
```

### 3.3 History Retrieval Logic

```python
def recall_relevant_history(
    customer_id: str,
    current_query: str,
    n_results: int = 5
) -> list:
    """Retrieve relevant history from ChromaDB when Agent needs to recall"""

    results = collection.query(
        query_texts=[current_query],
        n_results=n_results,
        where={"customer_id": customer_id}
    )

    return results["documents"][0] if results["documents"] else []


def recall_by_topic(
    customer_id: str,
    topic: str,
    n_results: int = 3
) -> list:
    """Retrieve history by topic"""

    results = collection.query(
        query_texts=[topic],
        n_results=n_results,
        where={
            "$and": [
                {"customer_id": customer_id},
                {"topic": topic}
            ]
        }
    )

    return results["documents"][0] if results["documents"] else []
```

### 3.4 Auto-Retrieval Trigger Conditions

Add to System Prompt so the Agent knows when to call history retrieval:

```
## History Memory Retrieval Rules

You MUST call ChromaDB history retrieval in these situations:

1. **Customer references past conversations**: e.g. "the price you mentioned last time",
   "that model we discussed before"
   -> Call recall_relevant_history(customer_id, customer's exact words)

2. **Customer contacts again after 7+ day gap**
   -> Auto-call recall_relevant_history(customer_id, "latest conversation summary")
   -> Naturally continue from last topic: "Hi [Name]! Last time we discussed [topic],
      any updates on your end?"

3. **MemOS memory has overdue commitments**
   -> Call recall_by_topic(customer_id, commitment.what)
   -> Find original commitment context, follow up properly

4. **Customer mentions a product or detail with no current context**
   -> Call recall_relevant_history(customer_id, product name/detail keyword)
   -> If history found, reference it; if not, politely confirm

Note: Retrieval results are for your reference only. Never say "I found in my database..."
Express naturally, as if you always remembered.
```

---

## Four-Layer Integration Flow

```
+------------------------------------------------------------------+
|                    New message arrives on WhatsApp                 |
+-------------------------------+----------------------------------+
                                |
                                v
+------------------------------------------------------------------+
|  Step 1: Read MemOS Memory (L1)                                  |
|  GET /memories?customer_id=<phone>                                |
|  -> If found, inject into System Prompt "Customer Memory" section |
|  -> If not found (new customer), use empty template               |
+-------------------------------+----------------------------------+
                                |
                                v
+------------------------------------------------------------------+
|  Step 2: Check if history retrieval needed (L3 triggers)          |
|  -> Gap >7 days? Overdue commitment? Customer references past?    |
|  -> If yes, call ChromaDB recall, append results to context       |
+-------------------------------+----------------------------------+
                                |
                                v
+------------------------------------------------------------------+
|  Step 3: Check token usage (L2)                                   |
|  -> If >= 65%, execute proactive summary via haiku-class model    |
|  -> Compress history, store summary in ChromaDB                   |
|  -> Re-inject MemOS snapshot + keep last 3 turns                  |
+-------------------------------+----------------------------------+
                                |
                                v
+------------------------------------------------------------------+
|  Step 4: Agent generates reply                                    |
|  Full context = System Prompt + MemOS snapshot                    |
|               + ChromaDB results (if any)                         |
|               + Compressed history + Last 3 raw turns             |
|               + Current user message                              |
+-------------------------------+----------------------------------+
                                |
                                v
+------------------------------------------------------------------+
|  Step 5: Post-processing                                          |
|  A) Extract memory -> Update MemOS (L1)                           |
|  B) Store this turn -> ChromaDB with auto-tags (L3)               |
|  C) Sync CRM -> Google Sheets via gog skill                       |
+-------------------------------+----------------------------------+
                                |
                                v (Daily 12:00 cron)
+------------------------------------------------------------------+
|  Step 6: CRM Snapshot (L4 — disaster recovery)                    |
|  Read full CRM pipeline -> Store summary in ChromaDB              |
|  -> Tagged with date, acts as fallback if L1/L3 have issues       |
+------------------------------------------------------------------+
```

---

## System Prompt Template (with Anti-Amnesia integrated)

Use as the base System Prompt for all WhatsApp AI-SDR Agents.
`{{...}}` markers are dynamically filled by MemOS and the system.

```
# {{agent_name}} - WhatsApp AI-SDR
# PulseAgent x OpenClaw {{tier}} | Anti-Amnesia v1.0

## Identity & Responsibilities
(Paste AI-SDR configurator output: identity, product info, communication style, etc.)

---

## Customer Memory Snapshot (auto-injected by MemOS, refreshed every turn)
{{MEMOS_INJECTION_BLOCK}}
(Empty for new customers. Agent should proactively collect information.)

---

## Historical Conversation Retrieval (auto-injected by ChromaDB, on-demand)
{{CHROMADB_INJECTION_BLOCK}}
(Empty if no retrieval needed or no results.)

---

## Anti-Amnesia Protocol

### Memory rules you MUST follow:

1. **Never say "sorry I don't remember."** If unsure about a detail, call ChromaDB
   to retrieve history. If retrieval returns nothing, use "let me confirm that"
   as a natural transition, never expose memory gaps.

2. **After every conversation turn, you must execute memory extraction internally.**
   Results are written to MemOS. This is mandatory, cannot be skipped.

3. **When you sense context growing long, proactively trigger summary.**
   Don't wait for system-forced truncation. When conversation exceeds 20 turns,
   proactively execute compression before your next reply.

4. **Use the memory snapshot for continuity.** Before each reply, read the
   "Customer Memory Snapshot" above. Ensure your reply is consistent with
   known information. If customer provides new info contradicting memory,
   update the memory; don't insist on old information.

5. **Cross-session continuity.** When a customer contacts you in a new session,
   MemOS snapshot is auto-injected. Naturally reference the last topic as an opener.
   - Yes: "Hi [Name]! Last time we discussed [product] samples, did you receive them?"
   - No: "Hello! How can I help you today?" (no memory continuity)

6. **Commitment tracking.** If memory snapshot has overdue commitments,
   prioritize handling them in your reply.
   - If it's your (Agent) overdue commitment: apologize first, then remedy.
   - If it's customer's overdue commitment: gently remind.

---

## Behavioral Boundaries
(Paste AI-SDR configurator output: behavioral boundaries)

---

*Anti-Amnesia v1.0 | PulseAgent x OpenClaw*
```

---

## LAYER 4: CRM Snapshot Fallback

### 4.1 Daily Pipeline Backup

Layer 4 is the disaster recovery layer. Even if MemOS has an outage or ChromaDB loses data, the daily CRM snapshot ensures pipeline state is never lost.

```python
def crm_snapshot():
    """Daily 12:00 — Store CRM pipeline state in ChromaDB"""
    # Read full CRM via gws/Google Sheets API
    pipeline = read_crm_pipeline()

    # Store as a timestamped snapshot
    snapshot = {
        "date": datetime.now().isoformat()[:10],
        "total_leads": len(pipeline),
        "by_status": count_by_status(pipeline),
        "hot_leads": [l for l in pipeline if l["lead_tier"] == "hot_lead"],
        "pending_quotes": [l for l in pipeline if l["status"] == "quote_sent"],
        "summary": generate_pipeline_summary(pipeline),
    }

    collection.add(
        documents=[json.dumps(snapshot)],
        ids=[f"crm_snapshot_{snapshot['date']}"],
        metadatas=[{"type": "crm_snapshot", "date": snapshot["date"]}]
    )
```

### 4.2 Recovery Scenarios

| Scenario | Recovery Using L4 |
|----------|-------------------|
| MemOS API down | Read latest CRM snapshot from ChromaDB for customer context |
| ChromaDB turns corrupted | CRM snapshot has pipeline state; rebuild from CRM + Supermemory |
| Server migration | Export CRM snapshots for continuity on new server |
| Audit request | Historical pipeline snapshots available by date |

### 4.3 Cron Configuration

```yaml
cron_jobs:
  - name: "crm_snapshot"
    schedule: "0 12 * * *"     # Daily at 12:00
    action: |
      Read full CRM pipeline via gws skill.
      Store summary snapshot in ChromaDB with date tag.
      Report: "CRM snapshot stored: N active leads, M pipeline value."
```

---

## Verification Checklist

After deployment, use these test scenarios to verify the anti-amnesia mechanism:

### Test 1: Single-session long conversation memory retention
```
1. Start a new conversation
2. Tell the Agent your company name and budget at turn 5
3. Continue conversation to turn 25+ (past compression threshold)
4. At turn 26, ask: "What was the budget I mentioned earlier?"
Pass: Agent answers accurately
Fail: Agent says it doesn't remember or gives wrong number
```

### Test 2: Cross-session memory continuity
```
1. Complete a full conversation discussing product A and pricing
2. Wait 5 minutes, then start a new conversation from the same number
3. Send: "Hi, what about that product we discussed last time?"
Pass: Agent naturally references product A and previous pricing
Fail: Agent replies as if meeting for the first time
```

### Test 3: Commitment tracking
```
1. In a conversation, have the Agent commit to "send a quote tomorrow"
2. Wait until "tomorrow", then start a new conversation from the same number
3. Send any message
Pass: Agent proactively mentions the quote ("Sorry the quote is delayed, preparing it now")
Fail: Agent doesn't mention the quote at all
```

### Test 4: Contradictory information handling
```
1. First tell the Agent you need 1000 units
2. Continue conversation for 20 turns
3. Change to "actually I only need 200 units"
Pass: Agent confirms the change ("OK, adjusting from 1000 to 200, let me recalculate")
Fail: Agent continues quoting for 1000 units
```

---

## Monitoring Metrics

Create the following monitoring table in Google Sheets (via gog skill):

| Metric | Calculation | Alert Threshold |
|--------|-------------|-----------------|
| Memory extraction success rate | Successful extractions / Total turns | < 95% |
| Proactive summary triggers/day | Daily count | > 50 needs investigation |
| ChromaDB retrieval hit rate | Effective retrievals / Total retrievals | < 70% |
| Customer "you don't remember" count | Manual tagging | > 0 investigate immediately |
| MemOS write latency | API response time | > 2 seconds |

---

## Quick Start Deployment

```
Step 1: Install ChromaDB skill
  -> ClawHub -> Search "chromadb" -> Install

Step 2: Configure MemOS connection
  -> Agent Settings -> Environment Variables
  -> Add MEMOS_API_KEY and MEMOS_NAMESPACE

Step 3: Import this document to Knowledge Base
  -> Agent -> Knowledge Base -> Upload
  -> Upload this .md file

Step 4: Update System Prompt
  -> Replace Agent's System Prompt with the template above
  -> Ensure {{MEMOS_INJECTION_BLOCK}} placeholder exists

Step 5: Configure Cron jobs
  -> Cron skill -> Add token_monitor / memory_sync / stale_memory_cleanup

Step 6: Run verification checklist
  -> Execute all 4 test scenarios above
  -> After all pass, switch to production

Step 7: Set up Google Sheets monitoring
  -> gog skill -> Connect monitoring sheet
  -> Configure daily auto-fill for metric data
```

---

*B2B SDR Agent Template - Anti-Amnesia Implementation Spec v2.0*
*Technical support: [PulseAgent](https://ai.pulseagent.io)*
