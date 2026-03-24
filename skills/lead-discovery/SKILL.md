---
name: lead-discovery
description: "AI-driven lead discovery for B2B export. Searches web for potential buyers matching ICP, evaluates fit, and creates CRM records for follow-up."
---

# Lead Discovery — AI-Powered Prospecting

Automatically search, filter, and evaluate potential buyers based on your ICP profile.

## Triggers
- Cron scheduled execution (Daily 10:00)
- Manual command from owner: "Search for leads in [market/industry]"

## Search Strategy

### Search Dimensions (rotate daily, pick 1-2)
1. **Target Market Procurement**
   - "{{product}} buyers [target country] 2026"
   - "[target country] fleet expansion logistics company"
   - "[target country] construction equipment procurement"

2. **Trade Shows & Procurement Signals**
   - "{{product}} buyers exhibition Africa Middle East 2026"
   - "transport logistics tender [region]"

3. **Company Research (read website)**
   - After discovering a target company, read their website for detailed info

4. **Customs / Trade Data**
   - "[target country] {{product}} import statistics"
   - "{{product}} import demand [region] 2026"

## Search Execution

### Jina Search (find potential buyers)
```bash
curl -s 'https://s.jina.ai/QUERY_URL_ENCODED' \
  -H 'Authorization: Bearer $JINA_API_KEY' \
  -H 'Accept: application/json'
```

### Jina Reader (read company website)
```bash
curl -s 'https://r.jina.ai/https://target-company.com' \
  -H 'Authorization: Bearer $JINA_API_KEY' \
  -H 'Accept: application/json'
```

JINA_API_KEY in .secrets/env. Get one free at https://jina.ai/

## 3-Layer Enrichment Pipeline

### Layer 1: Website Extraction
Read company website via Jina Reader → extract:
- Company size, employee count
- Product lines, services
- Certifications (ISO, etc.)
- Contact info (email, phone, WhatsApp)
- Office/warehouse locations

### Layer 2: Purchase Signal Search
Jina Search for:
- "[company name] procurement tender"
- "[company name] fleet expansion"
- "[company name] import export"

### Layer 3: Information Integration
- Combine all findings into enrichment profile
- Calculate ICP score based on USER.md criteria
- Store research notes in Supermemory with tag "customer_research"

## Evaluation Flow
For each discovered prospect:
1. Extract: company name, country, industry, size, contact info (email/WhatsApp/phone)
2. Read company website via Jina Reader for deep understanding
3. Score per USER.md ICP criteria (1-10)
4. ICP >= 5: Write to CRM (source=`web_discovery`, status=`new`)
5. ICP >= 7: Also mark as hot_lead, create research note
6. Email found: Mark next_action=`email_outreach`
7. WhatsApp found: Mark next_action=`whatsapp_outreach`

## Output Format (report to owner)
```
Today discovered X potential leads:

1. [Company] - [Country] - ICP [X]/10
   Industry: [industry] | Size: [size]
   Source: [search query]
   Contact: [email/website/whatsapp]
   Recommendation: [Send cold email / WhatsApp contact / More research / Enter nurture pool]

Added to CRM: X | Pending email outreach: X | Pending WhatsApp: X
```

## Search Frequency & Quota
- Max 20 searches per day (API quota management)
- Weekly coverage: Africa 2 days, Middle East 2 days, SEA 1 day, LatAm 1 day, Other 1 day
- Duplicate companies auto-skipped (check CRM first)

## Search Templates by Market

### Africa (Mon/Tue)
- "{{product}} importers Nigeria Lagos"
- "logistics company Tanzania fleet"
- "construction company Kenya equipment procurement"

### Middle East (Wed/Thu)
- "{{product}} dealers Saudi Arabia"
- "logistics fleet UAE Dubai"
- "construction equipment Oman transport"

### Southeast Asia (Fri)
- "{{product}} importers Philippines Manila"
- "logistics company Vietnam fleet"
- "construction Indonesia heavy vehicles"

### Latin America (Sat)
- "{{product}} importers Brazil"
- "logistics company Chile fleet"
- "mining transport vehicles Peru"
