---
name: contact-check
description: "Check whether a cold email to one address is allowed (UK, US, Canada, Germany, France) before the first email of a sequence. Returns a verdict, the rule, what the footer must include and a receipt id."
---

# contact-check — Cold Email Permission Check

> Before the Day 1 email to a new address, ask whether a cold email to that buyer is allowed. Germany and France want prior consent in many cases, a UK sole trader counts as an individual, and Canada's CASL depends on whether the address was published. One call per address, before the first email, and again if the pitch or where you got the address changes.

Powered by [Precleared](https://precleared.dev): a per-address verdict under UK PECR and UK GDPR, US CAN-SPAM, Canada's CASL, Germany's UWG and France's rules, with the rule quoted and a signed receipt. Nothing is sent to the buyer.

**Off by default.** The skill does nothing until `PRECLEARED_SENDER_COUNTRY` is set (see Configuration); until then it exits `0` with `"skipped": true` and the sequence carries on as before.

## Commands

| Command | Description |
|---------|-------------|
| `contact:check` | Check one address before the first cold email |

## Usage

```bash
node skills/contact-check/check.mjs --email buyer@company.de --source published --pitch "truck spare parts" --country DE
```

| Option | Required | Meaning |
|--------|----------|---------|
| `--email` | yes | The buyer's email address |
| `--source` | yes | Where the address came from: `published` (their website, a directory, a trade-show catalogue), `bought` (a purchased list), `scraped` (collected by a tool), `given` (they gave it to you) or `unknown`. It changes the verdict, so never assume `published` |
| `--pitch` | no | What you are offering, in a few words |
| `--country` | no | Buyer's two-letter country code, if known |
| `--sender` | no | `GB` or `US`, where your business is based (overrides `PRECLEARED_SENDER_COUNTRY` for one call) |
| `--existing-customer` | no | The buyer has bought from you before |
| `--dry-run` | no | Print the request without sending it |

## Reading the result

The script prints one JSON object and exits with a code you can gate on:

| Exit | Verdict | What to do |
|------|---------|------------|
| `0` | `ok_to_email`, or the check is off | Send the sequence. The footer must meet `footer_text` (who you are, a postal address, a way to opt out). It describes the requirement; write it in your own words |
| `2` | `consent_needed`, `blocked` or `unknown` | Do not email. Follow `next_step` (for example, get consent through their contact form or a channel the buyer opened) and note it in the CRM |
| `3` | none | The check could not be made (network, daily limit, an unexpected response). Do not email that lead yet: try again on the next run and carry on with replies and other leads |

Always save `receipt_id` in the CRM notes next to the lead. Anyone can open the receipt at `https://precleared.dev/r/<receipt_id>` to see what was checked and why.

## Configuration

```bash
# Optional, in .secrets/env
PRECLEARED_SENDER_COUNTRY="GB" # GB or US. Setting this turns the check on
PRECLEARED_API_KEY=""          # Optional. Free key at https://precleared.dev/get-key (25 checks/day)
```

Without a key, Precleared allows 10 checks a day per server. A free key raises that to 25 a day; paid packs cover more.

## File Structure
```
contact-check/
├── SKILL.md          # This file
└── check.mjs         # Precleared API call (Node 18+, no dependencies)
```
