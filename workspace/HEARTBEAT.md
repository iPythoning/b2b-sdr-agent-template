# HEARTBEAT.md — Pipeline Inspection

Only report when action is needed. Otherwise reply: HEARTBEAT_OK

## 1. New Leads Check
Read CRM for rows where created_at = today AND status = new.
Found: List them (name, country, product interest, source). Suggest ICP scoring + research + draft first-touch message.
None: Skip.

## 2. Stalled Leads Check
Read CRM for rows where status = contacted/interested/quote_sent/negotiating AND last_contact > 5 business days.
Found: List them (name, company, country, status, last contact). Suggest follow-up draft.
None: Skip.

## 3. Quote Tracking
Find rows where status = quote_sent AND last_contact > 3 business days.
Found: Suggest follow-up on quote feedback.
None: Skip.

## 4. Today's Meetings
Find rows where status = meeting_set AND next_action contains today's date.
Found: Remind to prepare materials.
None: Skip.

## 5. Nurture Check (Mondays only)
Find status = nurture AND last_contact > 14 days → Suggest nurture touch.
Find status = closed_won AND last_contact > 30 days → Suggest after-sale care.
Find status = closed_lost AND last_contact > 90 days → Suggest quarterly follow-up.

## 6. Data Quality (Weekdays, once daily)
Check rows where whatsapp is empty AND status is not closed_*.
Check rows where icp_score is empty AND status is not new.
Found: List them, suggest completion.
None: Skip.

## 7. Email Sequence Check (Daily 11:00)
Check CRM for leads with status = email_sent:
- Day 3 since last email and no reply → Send follow-up #2
- Day 7 since last email and no reply → Send follow-up #3
- Day 14 since last email and no reply → Send final follow-up, move to nurture
- Email replied → Update status to email_replied, notify owner
None: Skip.

## 8. Lead Discovery (Daily 10:00)
Execute lead-discovery skill:
1. Select target market based on day of week (Mon/Tue: Africa, Wed/Thu: ME, Fri: SEA, Sat: LatAm, Sun: Other)
2. Run 2-3 search queries via Jina Search
3. Evaluate discovered companies, write ICP >= 5 to CRM
4. Report findings to owner
Found: Report per lead-discovery skill output format.
None: Skip.

## 9. Gmail Inbox Monitor (Every heartbeat)
Check Gmail for new client replies:
- Match sender email to CRM records
- If match found: Update last_contact, notify owner of reply
- If new sender with business inquiry: Create new CRM record, begin qualification
None: Skip.

## 10. Competitor Intelligence (Weekly Friday)
Search for competitor activity:
- New product launches, pricing changes, market expansion
- Store findings in Supermemory with tag "competitor_intel"
- Report significant findings to owner
None: Skip.

## 11. Memory Health Check (Daily 14:00)
Run `memory:stats` + `chroma:stats` to check full memory system.
- Supermemory: If total > 500, suggest archiving old `market_signal` entries. If 0 `customer_fact`, alert.
- ChromaDB: If 0 turns stored in last 24h, alert — L3 may not be capturing. Report top 5 customers by turn count.
- Report: "Supermemory: [X] facts, [Y] insights, [Z] signals. ChromaDB: [N] turns across [M] customers."

## 12. CRM Snapshot (Daily 12:00)
Run `chroma:snapshot` to backup current pipeline state to ChromaDB (L4 fallback).
- Read full CRM via gws, store summary in ChromaDB with date tag.
- This is disaster recovery — if MemOS or Supermemory has issues, ChromaDB has the data.
- Report: "CRM snapshot stored: [N] active leads, [M] pipeline value."

No issues → reply only: HEARTBEAT_OK
