---
name: quotation-generator
description: "Auto-generate professional PDF proforma invoices with company letterhead, multi-language support, and post-quote tracking."
---

# Quotation Generator

Generate professional proforma invoices for B2B export deals.

## Trigger
- Customer requests quote/pricing
- Owner instructs: "Send quote to [customer]"
- Stage 5 of sales pipeline

## Quote Content
Each proforma invoice includes:
1. **Company letterhead** — logo, company name, address, contact info
2. **Customer info** — company, contact person, country
3. **Product table** — item, specs, quantity, unit price, total
4. **Terms** — payment terms, delivery time, shipping method, Incoterms
5. **Validity** — quote valid for 30 days (configurable)
6. **Notes** — special conditions, certifications, warranty

## Naming Convention
`{{brand_code}}-YYYYMMDD-NNN` (e.g., FY-20260324-001)

## Multi-Language Support
Generate quotes in customer's language:
- English (default)
- French (West/Central Africa)
- Arabic (Middle East/North Africa)
- Spanish (Latin America)
- Portuguese (Brazil, Mozambique)

## Workflow
1. AI drafts quote based on conversation context and product-kb
2. Send draft to owner via WhatsApp for approval
3. Owner approves → AI sends to customer
4. Update CRM: status = `quote_sent`, attach quote reference

## Post-Quote Tracking
- Day 3: If no reply → Follow up asking for feedback
- Day 7: If no reply → Second follow-up with value proposition
- Day 14: If no reply → Final follow-up or move to nurture
- Reply received → Update CRM, continue negotiation (Stage 6)

## Product KB Integration
Reads from `product-kb/catalog.json` for:
- Product specs, dimensions, weight
- FOB/CIF pricing
- MOQ (Minimum Order Quantity)
- Lead time / production time
- Available certifications
