---
name: tweetclaw-social-intel
description: "Use TweetClaw to find B2B buying signals on X/Twitter, enrich prospects, monitor competitors, and prepare approved social replies for the SDR pipeline."
---

# TweetClaw Social Intel

Use this skill when lead discovery, competitor intelligence, or customer research
needs current X/Twitter context.

TweetClaw is optional. If it is not installed or configured, skip this skill and
continue with web search, CRM history, and existing memory.

TweetClaw is MIT-licensed. It connects to Xquik, a closed-source hosted service
operated independently from X Corp. Xquik is not affiliated with or endorsed by
X Corp.

## Setup

Install the OpenClaw plugin:

```bash
openclaw plugins install clawhub:@xquik/tweetclaw
openclaw config set tools.alsoAllow '["explore", "tweetclaw"]'
```

For account-backed workflows, configure the API key outside chat:

```bash
openclaw config set plugins.entries.tweetclaw.config.apiKey "$XQUIK_API_KEY"
```

Never ask the agent to print, paste, store, or summarize API keys. Keep secrets
in OpenClaw config or environment variables.

## Tool Policy

- Use `explore` first to find the correct TweetClaw endpoint and parameters.
- Use `tweetclaw` only for the selected endpoint, with narrow limits.
- Read-only searches and user lookups can run without owner approval when they
  fit the daily research budget.
- Writes always need explicit owner approval before execution: post tweets, post
  tweet replies, direct messages, follows, unfollows, media upload, profile
  changes, monitor creation, webhook creation, extraction jobs, media download,
  and giveaway draws.
- Before approval, show the account, target, exact text or action, media list,
  limit, stop condition, and business reason.
- Do not bulk-DM, bulk-follow, scrape private data, or contact prospects without
  a CRM note and owner-approved outreach plan.

## Buying-Signal Search

Use during lead discovery when the target market has active X/Twitter business
conversation.

Run 2-3 narrow searches:

```text
"{{product}}" ("supplier" OR "manufacturer" OR "dealer") "{{market}}"
"looking for" "{{product}}" "{{market}}"
"{{competitor}}" ("alternative" OR "price" OR "supplier")
"{{industry}}" ("tender" OR "procurement" OR "import") "{{market}}"
```

Filter out memes, job posts, consumer complaints, and unrelated news. Prefer
posts from company accounts, founders, procurement teams, distributors, fleet
operators, dealers, and trade associations.

Capture:

- author username and display name
- tweet URL or tweet ID
- text summary
- product or use case
- market and language
- signal type: procurement, competitor mention, tender, distributor search,
  product complaint, expansion, event, or partnership
- confidence: high, medium, low
- recommended next action

## Prospect Enrichment

When a prospect has an X/Twitter handle:

1. Use user lookup to confirm profile, description, website, follower count, and
   recent activity.
2. Search recent tweets and replies for product interest, market expansion,
   procurement, hiring, fleet growth, distribution needs, and competitor
   mentions.
3. Store verified findings in Supermemory:

```bash
memory:add "[Company] X signal: [finding] Source: [tweet URL]" --type customer_fact
```

4. Update CRM notes with `source=x_twitter_signal` only when the lead is a real
   business prospect.

## Competitor Intelligence

For weekly competitor checks:

- Search competitor handles, brand names, product names, and complaint phrases.
- Capture pricing mentions, launch announcements, distributor requests,
  customer objections, supply complaints, and market-entry signals.
- Store only business-relevant findings:

```bash
memory:add "[Competitor] X/Twitter signal: [finding] Source: [tweet URL]" --type competitor_intel
```

## Monitoring

Use monitors only when the owner asks for recurring alerts.

Before creating a monitor, confirm:

- keyword or account
- event types
- market or language filters
- stop condition
- alert destination

Good monitor examples:

- competitor brand + "price" or "supplier"
- product category + target country
- known prospect account
- trade show hashtag during an event week

Pause or delete noisy monitors after 7 days without useful signals.

## Draft Replies

TweetClaw can help draft or post replies, but the SDR agent must remain
approval-gated.

Draft first:

1. Summarize the tweet and why it matches the ICP.
2. Draft a concise helpful reply with no pricing claim.
3. Ask the owner to approve, edit, or reject.
4. Post only after explicit approval of the final text and target tweet.

Never promise delivery dates, quote prices, make product claims not present in
the product KB, or mention internal margins.

## Output Format

```text
X/Twitter social-intel run:

Query set:
- [query]
- [query]

Findings:
1. [Company or handle] - [market] - Confidence [high/medium/low]
   Signal: [procurement / competitor / tender / distributor / complaint]
   Evidence: [tweet URL or tweet ID]
   CRM action: [create lead / enrich existing lead / store only / skip]
   Next action: [research website / draft email / owner review / monitor]

Stored memory:
- [memory id or summary]

Skipped:
- [reason: consumer post, duplicate, weak fit, no business signal]
```
