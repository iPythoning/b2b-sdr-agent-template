# Customer Delivery Guide — WhatsApp Legacy Account Onboarding

> One-page reference for delivering this spec to a paying customer.
> Read this **before** the kick-off call so you can set realistic
> expectations about WhatsApp's historical-data limitations.

中文版见 [CUSTOMER-DELIVERY-GUIDE.zh-CN.md](CUSTOMER-DELIVERY-GUIDE.zh-CN.md).

---

## ⚠️ Critical expectation alignment (do this on the kick-off call)

Most customers ask: **"Can the AI just read all my WhatsApp chats once we connect?"**

The honest answer:

| Account type | Historical data | New messages from go-live |
|---|---|---|
| **WhatsApp Business API** | ❌ Zero history. Webhook only delivers messages received **after** connection. | ✅ Real-time |
| **WhatsApp Business App** | ⚠️ History exists on the phone, but only extractable via per-chat "Export" or device backup parsing | ✅ Yes, if proxied through Baileys or similar |
| **Personal account** | ⚠️ Same as Business App + higher ban risk on third-party automation | ⚠️ Allowed via Baileys, ToS grey zone |

**Set this expectation in writing during sales**, not after the contract:

> "We migrate your historical WhatsApp conversations using **backup
> extraction** (your iCloud/iTunes/Google Drive backup), not through
> WhatsApp's API. Anything not in a backup we can access can't be recovered.
> Going forward, the AI handles every new conversation."

---

## Delivery decision tree

```
Q1. Is the customer using Business API, Business App, or a personal account?
   ├─ Business API           → Path A
   ├─ Business App (phone)   → Path B  (or Path D — see Q2.5)
   └─ Personal account       → Path C  (or Path D — see Q2.5)

Q2. (B and C only) What's the customer's phone OS?
   ├─ iOS    → B.1 / C.1   (iTunes backup or iMazing)
   └─ Android → B.2 / C.2  (msgstore.db.crypt15 extraction)

Q2.5 — Path D consideration (Multi-Device sync via PulseAgent)
   Path D is the lowest-friction option BUT requires:
   - PA whatsapp-relay running with SYNC_HISTORY=1
   - Customer's WhatsApp can tolerate 30 min – 6 hours of background sync
   - Customer is willing to do a fresh QR scan (= temporary disconnect
     of any currently-linked WhatsApp Web sessions)
   - Customer's iPhone has "Device History → All chat history" enabled
     (Settings → Chats → Device History)

   If all four are true → Path D
   If any is false      → fall back to Path B/C device backup

Q3. (B/C only) Do they have a recent backup?
   ├─ Yes, < 24h    → proceed
   ├─ Yes, > 7 days → ask them to take a fresh backup first
   └─ No / never    → backup creation is Step 0 of the delivery
```

---

## Path A — WhatsApp Business API customer

**No history. Don't promise otherwise.** Delivery focuses on Layer B + future
Layer C accumulation.

1. Confirm Cloud API / on-prem and BSP identity
2. Onboarding window: 30 / 60 / 90 days of webhook capture → then run extractor
3. Layer A profiles bootstrap from `customer_profile_seed.yaml` filled in by
   the salesperson (5 min per top customer, ~30 customers max for v1)
4. Layer B: import 30-50 manually selected sample conversations from email /
   CRM if they have them

**Timeline**: 1 week to set up, 30+ days to accumulate enough history for
Layer C to be useful.

---

## Path B/C — Phone-based account (history extraction)

### Step 0 — Take a fresh, complete backup (mandatory)

The customer must do this themselves. We don't touch their phone.

**B.1 / C.1 (iOS)**
- WhatsApp → Settings → Chats → Chat Backup → Back Up Now
- Include videos: **off** (saves 70% time, we don't need them)
- Then connect to laptop → iTunes / Finder → encrypted backup (**set a
  password the customer remembers** — required for decryption)

**B.2 / C.2 (Android)**
- WhatsApp → Settings → Chats → Chat Backup → Back Up
- Local backup is enough (Google Drive backup is encrypted with a key the
  customer must locate)
- Customer also needs the 64-character **encryption key** for
  `msgstore.db.crypt15` decryption. WhatsApp surfaces this via Settings →
  Account → End-to-end encrypted backup → Manage → Reveal key.

### Step 1 — Run bootstrap

```bash
cd whatsapp-old-account-onboarding
bash scripts/bootstrap.sh
```

The script will:
1. Detect Python + Anthropic SDK + extraction tools
2. Ask the customer scenario questions (path A/B/C, iOS/Android, etc.)
3. Generate a one-time PII salt and save it to `~/.secrets/`
4. Walk the customer through their specific extraction path
5. Run parser → extractor → output to `./out/`
6. Print a verification report

### Step 2 — Manual review (30-40% of profiles)

`./out/profiles/_manual_review.txt` lists customers blocked by the strict
gate. The salesperson reviews each — most are fine after a one-line override.

### Step 3 — Push to MemOS + KB

The bootstrap script prompts for your PulseAgent API endpoint + token at the
end. It does:
- MemOS upsert (Layer A) — auto for all `_auto_onboard: true` profiles
- `sales_playbook` import (Layer B) — opens an interactive segment-review UI
- `conversation_history` embed (Layer C) — runs in the background

### Step 4 — Pre-launch verification

Run the 5 verification cases listed in `system-prompt-template.md`. **All
must pass** before the customer's WhatsApp number routes to the AI.

### Step 5 — Shadow → whitelist → rollout

Per the schedule in `README.md`. Default timeline:
- Week 1: shadow mode
- Week 2: whitelist 5-10 high-trust customers
- Week 3-6: expand 20-30% / week

---

## Deliverables checklist (per customer)

- [ ] Signed expectation-alignment paragraph (historical data scope)
- [ ] Fresh backup taken with included passwords/keys recorded
- [ ] Bootstrap script run end-to-end, log saved to project folder
- [ ] `_manual_review.txt` reviewed and resolved
- [ ] MemOS contains N profiles where N >= 80% of approved customers
- [ ] 5 verification cases passing
- [ ] Customer signs off on shadow-mode samples before whitelist enable
- [ ] Rollout schedule confirmed in writing
- [ ] Salt + API tokens handed to customer's password manager (not ours)

---

## Pricing reference points

This is not a fixed price sheet — it's a starting frame for your quote.

| Customer size | Suggested fee | Why |
|---|---|---|
| < 50 customers in history | $500-$1,500 | 1 day work, mostly manual review |
| 50-300 customers | $2,500-$5,000 | 2-3 days, real ROI on automation |
| 300-1000 customers | $8,000-$15,000 | 1 week, ADB automation tier needed |
| > 1000 customers | Custom | Likely needs Business API parallel track |

Recurring: $200-$500/month for ongoing MemOS update + KB drift tuning.

---

## What we explicitly do NOT deliver

- WhatsApp account ban recovery (customer's risk)
- Backup creation on the customer's device (they do this themselves)
- iCloud / Google Drive credentials handling (customer extracts to laptop)
- Multi-device sync setup (out of scope)
- Voice / video / sticker analysis (text only)
- Conversations from groups (only 1-on-1 sales chats)

Put these in the proposal explicitly. Boundary clarity prevents scope creep.
