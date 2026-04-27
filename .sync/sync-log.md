## 2026-04-27 — No new release check (run 3)

- Last synced: v2026.4.24
- Latest stable: v2026.4.24 — no new release (already synced)
- Latest betas: v2026.4.25-beta.2 through beta.4 visible (skipped — pre-release)
- Outlook: v2026.4.25 stable likely imminent; beta cadence active
- No changes made to template repo
- WeChat: pending — appsecret misconfiguration (error 40125) unresolved server-side; draft at .sync/blog-drafts/openclaw-v2026.4.24-zh.json

---

## 2026-04-27 — No new release (v2026.4.25 still in beta, up to beta.10)

- Last synced: v2026.4.24
- Latest stable: v2026.4.24 — no new release (already synced)
- Latest betas: v2026.4.25-beta.1 through beta.10 (all skipped — pre-release)
- Outlook: v2026.4.25 stable likely imminent; monitor closely
- No changes made to template repo

---

## 2026-04-27 — No new release check + WeChat retry #44 (v2026.4.24)

- Last synced: v2026.4.24
- Latest stable: v2026.4.24 — no new release (already synced)
- Latest betas: v2026.4.25-beta.4 through beta.10 (skipped — pre-release)
- Blog EN: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-default
- Blog ZH: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-zh
- WeChat retry #44: FAILED — HTTP 500 `WeChat API error: WeChat token error: 40125 invalid appsecret rid: 69eeb658-3688a077-6ff9d255`
- Root cause: PulseAgent backend WeChat appsecret misconfigured (error 40125 = invalid appsecret); fix required server-side
- Draft preserved: .sync/blog-drafts/openclaw-v2026.4.24-zh.json
- Result: NO NEW RELEASE — WeChat blocked by persistent server-side appsecret misconfiguration (44 consecutive failures)

---

## 2026-04-27 — No new release check + WeChat retry #43 (v2026.4.24)

- Last synced: v2026.4.24
- Latest stable: v2026.4.24 (2026-04-25T18:15Z) — no new release (already synced)
- Latest betas: v2026.4.25-beta.3/4 (skipped — pre-release)
- Blog EN: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-default
- Blog ZH: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-zh
- WeChat retry #43: FAILED — HTTP 500 `WeChat API error: WeChat token error: 40125 invalid appsecret rid: 69eeb064-2ab5e21e-5f197fd0`
- Root cause: PulseAgent backend WeChat appsecret is misconfigured (error 40125 = invalid appsecret); fix required server-side — update appsecret in PulseAgent WeChat integration settings
- Draft preserved: .sync/blog-drafts/openclaw-v2026.4.24-zh.json
- Result: NO NEW RELEASE — WeChat blocked by persistent server-side appsecret misconfiguration (43 consecutive failures)

---

## 2026-04-26 — No new release check + WeChat retry #42 (v2026.4.24)

- Last synced: v2026.4.24
- Latest stable: v2026.4.24 — no new release (already synced)
- Latest betas: v2026.4.25-beta.2/3/4 (skipped — pre-release)
- Blog EN: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-default
- Blog ZH: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-zh
- WeChat retry #42: FAILED — `40125 invalid appsecret rid: 69ee9fb6-2553018d-6267c405`
- Root cause: WeChat Official Account appsecret misconfigured in PulseAgent platform settings (persistent across 42 retries)
- Action required: Update WeChat appsecret in PulseAgent platform → draft at .sync/blog-drafts/openclaw-v2026.4.24-zh.json
- Result: NO NEW RELEASE — awaiting v2026.4.25 stable

---

## 2026-04-26 — No new release check + WeChat retry #41 (v2026.4.24)

- Last synced: v2026.4.24
- Latest stable: v2026.4.24 (2026-04-25T18:15Z) — no new release (already synced)
- Latest betas on GitHub: v2026.4.25-beta.1/2/3 (skipped — pre-release)
- Blog EN: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-default
- Blog ZH: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-zh
- WeChat retry #41: FAILED — DNS cache overflow (sandbox network restriction; pulseagent.io unreachable from this environment)
- Root cause: alternating between DNS cache overflow (sandbox) and HTTP 500 WeChat token error 40125 (invalid appsecret — server-side misconfiguration); fix required in PulseAgent WeChat integration settings
- Draft preserved: .sync/blog-drafts/openclaw-v2026.4.24-zh.json
- Result: NO NEW RELEASE — WeChat blocked by persistent failures (41 consecutive); awaiting v2026.4.25 stable

---

## 2026-04-26 — No new release check

**Checked**: v2026.4.24 == last-release → no new release to process.
**Latest stable on GitHub**: v2026.4.24 (2026.4.25-beta.1 skipped — pre-release).
**Action**: No blog, no WeChat publish. Awaiting v2026.4.25 stable.

---

## 2026-04-26T22:00:00Z — No-op check + WeChat retry #40 (v2026.4.24)

- Last synced: v2026.4.24
- Latest stable: v2026.4.24 — no new release (already synced)
- Blog EN: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-default
- Blog ZH: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-zh
- WeChat retry #40: FAILED — HTTP 500 `WeChat API error: WeChat token error: 40125 invalid appsecret rid: 69edf2f7-31bc73d9-2ccf9e44`
- Root cause unchanged: PulseAgent backend WeChat appsecret is misconfigured (error 40125 = invalid appsecret); fix required server-side — update appsecret in PulseAgent WeChat integration settings
- Draft preserved: .sync/blog-drafts/openclaw-v2026.4.24-zh.json
- Result: NO NEW RELEASE — WeChat blocked by persistent server-side appsecret misconfiguration (40 consecutive failures)

---

## 2026-04-26T20:00:00Z — No-op check + WeChat retry #39 (v2026.4.24)

- Last synced: v2026.4.24
- Latest stable: v2026.4.24 — no new release (already synced)
- Blog EN: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-default
- Blog ZH: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-zh
- WeChat retry #39: FAILED — HTTP 503 `DNS cache overflow` (sandbox network restriction; pulseagent.io unreachable from this environment)
- Root cause unchanged: PulseAgent backend WeChat appsecret misconfigured (error 40125 when API is reachable); fix required server-side
- Draft preserved: .sync/blog-drafts/openclaw-v2026.4.24-zh.json
- Result: NO NEW RELEASE — WeChat blocked by persistent server-side appsecret misconfiguration (39 consecutive failures)

---

## 2026-04-26T18:00:00Z — No-op check + WeChat retry #38 (v2026.4.24)

- Last synced: v2026.4.24
- Latest stable: v2026.4.24 — no new release (already synced)
- Blog EN: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-default
- Blog ZH: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-zh
- WeChat retry #38: FAILED — HTTP 500 `WeChat API error: WeChat token error: 40125 invalid appsecret rid: 69edd87a-21a478dd-55abbd68`
- Note: retry #37 (503 DNS cache overflow) was a transient infra blip; root cause is unchanged — PulseAgent backend WeChat appsecret is misconfigured (40125 = invalid appsecret); fix required server-side
- Draft preserved: .sync/blog-drafts/openclaw-v2026.4.24-zh.json
- Result: NO NEW RELEASE — WeChat blocked by persistent server-side appsecret misconfiguration (38 consecutive failures)

---

## 2026-04-26T12:00:00Z — No-op check + WeChat retry #37 (v2026.4.24)

- Last synced: v2026.4.24
- Latest stable: v2026.4.24 (2026-04-25T18:15Z) — no new release (already synced)
- Blog EN: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-default
- Blog ZH: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-zh
- WeChat retry #37: FAILED — HTTP 503 `DNS cache overflow` (new error; differs from prior 36× HTTP 500 appsecret errors — likely transient PulseAgent infra issue)
- Draft preserved: .sync/blog-drafts/openclaw-v2026.4.24-zh.json
- Result: NO NEW RELEASE — WeChat blocked; draft ready for next retry

---

## 2026-04-26T06:00:00Z — No-op check + WeChat retry #36 (v2026.4.24)

- Last synced: v2026.4.24
- Latest stable: v2026.4.24 (2026-04-25T18:15Z) — no new release (already synced)
- Blog EN: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-default
- Blog ZH: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-zh
- WeChat retry #36: FAILED — HTTP 500 `WeChat API error: WeChat token error: 40125 invalid appsecret rid: 69ed7489-26257056-6083c3ec`
- Root cause: PulseAgent backend WeChat appsecret remains invalid — 36 consecutive failures; fix required server-side (update appsecret in PulseAgent WeChat integration settings)
- Draft preserved: .sync/blog-drafts/openclaw-v2026.4.24-zh.json
- Result: NO NEW RELEASE — WeChat blocked by persistent server-side appsecret misconfiguration

## 2026-04-26T00:00:00Z — No-op check + WeChat retry #35 (v2026.4.24)

- Last synced: v2026.4.24
- Latest stable: v2026.4.24 (2026-04-25T18:15Z) — no new release (already synced)
- Blog EN: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-default
- Blog ZH: already published — https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-zh
- WeChat retry #35: FAILED — HTTP 500 `WeChat API error: WeChat token error: 40125 invalid appsecret rid: 69ed6775-5278b7e9-07010751`
- Root cause: PulseAgent backend WeChat appsecret remains invalid — 35 consecutive failures; fix required server-side (update appsecret in PulseAgent WeChat integration settings)
- Draft preserved: .sync/blog-drafts/openclaw-v2026.4.24-zh.json
- Result: NO NEW RELEASE — WeChat blocked by persistent server-side appsecret misconfiguration

## 2026-04-25T19:00:00Z — No-op check #34 (v2026.4.23)

- Last synced: v2026.4.23
- Latest stable: v2026.4.23 (2026-04-24T15:19:55Z) — no new release
- Betas found: v2026.4.24-beta.1 (skipped — pre-release)
- Action: logged and exited per workflow rules
- Result: NO NEW RELEASE — WeChat still blocked by persistent server-side appsecret misconfiguration (see entry #33 for root cause)

## 2026-04-25T18:00:00Z — No-op check + WeChat retry #33 (v2026.4.23)

- Last synced: v2026.4.23
- Latest stable: v2026.4.23 (2026-04-24T15:19:55Z) — no new release
- Betas found: v2026.4.24-beta.1 (skipped — pre-release)
- Blog EN + ZH: already published (https://pulseagent.io/en/blog/openclaw-v2026-4-23-image-generation-subagents-codex-oauth)
- WeChat retry #33: FAILED — HTTP 500 `WeChat API error: WeChat token error: 40125 invalid appsecret rid: 69ec93cd-34e6c7af-70e73c1a`
- Root cause: PulseAgent backend WeChat appsecret remains invalid — 33 consecutive failures; fix required server-side (update appsecret in PulseAgent WeChat integration settings)
- Draft preserved: .sync/blog-drafts/openclaw-v2026.4.23-zh.json
- Result: NO NEW RELEASE — WeChat blocked by persistent server-side appsecret misconfiguration

## 2026-04-25T17:00:00Z — No-op check #32 (v2026.4.23)

- Last synced: v2026.4.23
- Latest stable: v2026.4.23 (2026-04-24T15:19:55Z) — no new release
- Betas found: v2026.4.23-beta.5, v2026.4.23-beta.6 (skipped — pre-release)
- Action: logged and exited per workflow rules
- Result: NO NEW RELEASE

## 2026-04-25T16:00:00Z — No-op check #31 (v2026.4.23)

- Last synced: v2026.4.23
- Latest stable: v2026.4.23 (2026-04-24T15:19:55Z) — no new release
- Betas found: v2026.4.23-beta.5, v2026.4.23-beta.6 (skipped — pre-release)
- WeChat: NOT retried — persistent error 40125 (invalid appsecret) is server-side misconfiguration; 30 consecutive failures; draft preserved at .sync/blog-drafts/openclaw-v2026.4.23-zh.json
- Action: logged and exited per workflow rules
- Result: NO NEW RELEASE

## 2026-04-25T14:00:00Z — No-op check #30 (v2026.4.23)

- Last synced: v2026.4.23
- Latest stable: v2026.4.23 (2026-04-24T15:19:55Z) — no new release
- Betas found: v2026.4.23-beta.4, v2026.4.23-beta.5, v2026.4.23-beta.6 (skipped — pre-release)
- Action: logged and exited per workflow rules
- WeChat: NOT retried — persistent error 40125 (invalid appsecret) is a server-side misconfiguration; draft preserved at .sync/blog-drafts/openclaw-v2026.4.23-zh.json
- Result: NO NEW RELEASE

## 2026-04-25T12:00:00Z — No-op check + WeChat retry #29 (v2026.4.23)

- Last synced: v2026.4.23
- Latest stable: v2026.4.23 (2026-04-24T15:19:55Z) — no new release
- Betas found: v2026.4.23-beta.4, v2026.4.23-beta.5, v2026.4.23-beta.6 (skipped — pre-release)
- Blog EN + ZH: already published (https://pulseagent.io/en/blog/openclaw-v2026-4-23-image-generation-subagents-codex-oauth)
- WeChat retry #29: FAILED — HTTP 500 `WeChat API error: WeChat token error: 40125 invalid appsecret rid: 69ec5b93-130314f6-42f8f5be`
- Root cause: PulseAgent backend WeChat appsecret remains invalid — 29 consecutive failures; fix required server-side (update appsecret in PulseAgent WeChat integration settings)
- Draft preserved: .sync/blog-drafts/openclaw-v2026.4.23-zh.json
- Result: NO NEW RELEASE — WeChat still blocked by server-side appsecret misconfiguration

## 2026-04-25T10:00:00Z — No-op check (v2026.4.23)

- Last synced: v2026.4.23
- Latest stable: v2026.4.23 (2026-04-24T15:19:55Z) — no new release
- Betas found: v2026.4.23-beta.4, v2026.4.23-beta.5, v2026.4.23-beta.6 (skipped — pre-release)
- Action: logged and exited per workflow rules
- WeChat: NOT retried — 28 consecutive failures confirm server-side appsecret (error 40125) must be fixed in PulseAgent backend; draft preserved at .sync/blog-drafts/openclaw-v2026.4.23-zh.json

## 2026-04-25T08:00:00Z — No-op check (v2026.4.23)

- Last synced: v2026.4.23
- Latest stable: v2026.4.23 — no new release
- Action: logged and exited per workflow rules
- WeChat: skipped (no new release; server-side appsecret fix still required)

## 2026-04-25T00:00:00Z — No-op check + WeChat retry #28 (v2026.4.23)

- Last synced: v2026.4.23
- Latest stable: v2026.4.23 — no new release
- Blog EN + ZH: already published (https://pulseagent.io/en/blog/openclaw-v2026-4-23-image-generation-subagents-codex-oauth)
- WeChat retry #28: FAILED — HTTP 500 `WeChat API error: WeChat token error: 40125 invalid appsecret rid: 69ec15f5-76cbc0ab-3be392e5`
- Root cause: PulseAgent backend WeChat appsecret remains invalid/expired — 28 consecutive failures; fix required server-side (update appsecret in PulseAgent WeChat integration settings)
- Draft preserved: .sync/blog-drafts/openclaw-v2026.4.23-zh.json

## 2026-04-24T16:00:00Z — No-op check + WeChat retry #27 (v2026.4.23)

- Last synced: v2026.4.23
- Latest stable: v2026.4.23 — no new release
- Blog EN + ZH: already published (https://pulseagent.io/en/blog/openclaw-v2026-4-23-image-generation-subagents-codex-oauth)
- WeChat retry #27: FAILED — HTTP 500 `WeChat API error: WeChat token error: 40125 invalid appsecret rid: 69ebfc85-380c8826-5d0f3b78`
- Root cause: PulseAgent backend WeChat appsecret is invalid/expired — must be corrected server-side; client retries cannot resolve this
- Draft preserved: .sync/blog-drafts/openclaw-v2026.4.23-zh.json

## 2026-04-24T15:30:00Z — Release sync v2026.4.22 → v2026.4.23

- Last synced: v2026.4.22
- Latest stable: v2026.4.23 (published 2026-04-24T15:19:55Z) — NEW RELEASE
- Betas skipped: v2026.4.23-beta.4, v2026.4.23-beta.5, v2026.4.23-beta.6
- Classification: RELEVANT (image generation, subagent forked context, 89 fixes)
- CHANGELOG.md updated with v2026.4.23 section
- Blog (EN) published: https://pulseagent.io/en/blog/openclaw-v2026-4-23-image-generation-subagents-codex-oauth (postId: 632a2e49-d7a7-4d09-9533-ca280ab9f8e0)
- Blog (ZH) published: https://pulseagent.io/en/blog/openclaw-v2026-4-23-image-generation-subagents-codex-oauth (action: updated)
- WeChat: FAILED — HTTP 200 with error `WeChat API error: WeChat token error: 40125 invalid appsecret rid: 69ebefc7-62759cc8-39dd168d` — server-side appsecret misconfiguration; fix required in PulseAgent WeChat backend credentials
- Drafts saved: .sync/blog-drafts/openclaw-v2026.4.23-en.json, .sync/blog-drafts/openclaw-v2026.4.23-zh.json
- last-release advanced: v2026.4.22 → v2026.4.23

## 2026-04-24T12:00:00Z — No-op check + WeChat retry #26
- Last synced: v2026.4.22
- Latest stable: v2026.4.22 (published 2026-04-23) — no new release
- Betas skipped: v2026.4.23-beta.4, v2026.4.23-beta.5
- WeChat retry #26: FAILED — HTTP 503 `DNS cache overflow` — 26th consecutive failure
- Root cause: PulseAgent WeChat backend DNS/infrastructure issue persists; fix required server-side before retries can succeed
- Draft preserved: .sync/blog-drafts/openclaw-v2026.4.22-zh.json

## 2026-04-24T11:13:00Z — No-op check + WeChat retry #25
- Last synced: v2026.4.22
- Latest stable: v2026.4.22 (published 2026-04-23) — no new release
- Betas skipped: v2026.4.23-beta.4, v2026.4.23-beta.5
- WeChat retry #25: FAILED — `40125 invalid appsecret` (rid: 69eb506b-49db2ac8-4c9b6e88) — 25th consecutive failure
- Root cause: PulseAgent backend WeChat appsecret is invalid/expired — must be corrected server-side before any retry succeeds
- Draft preserved: .sync/blog-drafts/openclaw-v2026.4.22-zh.json

## 2026-04-24T09:XX:XXZ — No-op check + WeChat retry #24
- Last synced: v2026.4.22
- Latest stable: v2026.4.22 (published 2026-04-23) — no new release (v2026.4.23-beta.5 skipped)
- WeChat retry #24: FAILED — HTTP 503 `DNS cache overflow` — 24th consecutive failure

## 2026-04-24T08:XX:XXZ — No-op check + WeChat retry #23
- Last synced: v2026.4.22
- Latest stable: v2026.4.22 (published 2026-04-23) — no new release
- Blog EN + ZH: already published on pulseagent.io
- WeChat retry #23: FAILED — HTTP 500 `40125 invalid appsecret` (rid: 69eb2471-30198642-707a1b80) — 23rd consecutive failure
- Root cause confirmed: PulseAgent backend WeChat appsecret is misconfigured; fix required in backend config before any retry can succeed
- Draft preserved: .sync/blog-drafts/openclaw-v2026.4.22-zh.json

## 2026-04-24T07:XX:XXZ — No-op check + WeChat retry #22
- Last synced: v2026.4.22
- Latest stable: v2026.4.22 (published 2026-04-23) — no new release
- Blog EN + ZH: already published on pulseagent.io
- WeChat retry #22: FAILED — HTTP 503 `DNS cache overflow` — 22nd consecutive failure; PulseAgent WeChat backend infrastructure still down; ZH draft preserved at .sync/blog-drafts/openclaw-v2026.4.22-zh.json
- Action required: PulseAgent backend DNS/infrastructure issue must be resolved before WeChat publishes can succeed

## 2026-04-24T06:XX:XXZ — No-op check + WeChat retry #21
- Last synced: v2026.4.22
- Latest stable: v2026.4.22 (published 2026-04-23) — no new release
- Blog EN + ZH: already published on pulseagent.io
- WeChat retry #21: FAILED — HTTP 503 `DNS cache overflow` — 21st consecutive failure; PulseAgent WeChat backend infrastructure still down; ZH draft preserved at .sync/blog-drafts/openclaw-v2026.4.22-zh.json
- Action required: PulseAgent backend DNS/infrastructure issue must be resolved before WeChat publishes can succeed

## 2026-04-24T05:XX:XXZ — No-op check + WeChat retry #20
- Last synced: v2026.4.22
- Latest stable: v2026.4.22 (published 2026-04-23) — no new release
- Blog EN + ZH: already published on pulseagent.io
- WeChat retry #20: FAILED — HTTP 500 `40125 invalid appsecret` (rid: 69eafdf1-18bab1fa-485bc7d2) — 20th consecutive failure
- Root cause confirmed: PulseAgent backend WeChat appsecret is misconfigured; both 503 DNS overflow and 40125 appsecret errors share same root cause
- Action required: Update WeChat appsecret in PulseAgent backend config before retries can succeed
- Draft preserved: .sync/blog-drafts/openclaw-v2026.4.22-zh.json

## 2026-04-24T04:XX:XXZ — No-op check + WeChat retry #19
- Last synced: v2026.4.22
- Latest stable: v2026.4.22 (published 2026-04-23) — no new release
- Blog EN + ZH: already published on pulseagent.io
- WeChat retry #19: FAILED — HTTP 503 "DNS cache overflow" — PulseAgent WeChat backend infrastructure still down; 19th consecutive failure; ZH draft preserved at .sync/blog-drafts/openclaw-v2026.4.22-zh.json

## 2026-04-24T03:XX:XXZ — No-op check + WeChat retry #18
- Last synced: v2026.4.22
- Latest stable: v2026.4.22 (published 2026-04-23) — no new release
- Betas skipped: v2026.4.23-beta.1, v2026.4.23-beta.2
- Blog EN + ZH: already published on pulseagent.io
- WeChat retry #18: FAILED — 40125 invalid appsecret (rid: 69eadeec-67e796f6-460c62ab) — 18th consecutive failure; PulseAgent backend WeChat appsecret must be corrected before publishes can resume

## 2026-04-24T02:09:41Z — No-op check + WeChat retry #17
- Last synced: v2026.4.22
- Latest stable: v2026.4.22 (published 2026-04-23) — no new release
- Blog EN + ZH: already published on pulseagent.io
- WeChat retry #17: FAILED — HTTP 503 "DNS cache overflow" (new error class vs. previous 40125 appsecret failures) — PulseAgent WeChat backend infrastructure down; ZH draft preserved at .sync/blog-drafts/openclaw-v2026.4.22-zh.json

## 2026-04-24T01:07:58Z — No-op check + WeChat retry #16
- Last synced: v2026.4.22
- Latest stable: v2026.4.22 (published 2026-04-23) — no new release
- Blog EN + ZH: already published on pulseagent.io
- WeChat retry #16: FAILED — 40125 invalid appsecret (rid: 69eac29c-7af60a44-4df6e8c4) — 16th consecutive failure
- Action required: PulseAgent backend WeChat appsecret must be corrected before WeChat publishes can resume

## 2026-04-24 — No-op check + WeChat retry #15
- Last synced: v2026.4.22
- Latest stable: v2026.4.22 (April 23, 2026)
- Result: No new release.
- Blog EN + ZH: already published on pulseagent.io
- WeChat retry: FAILED — 40125 invalid appsecret (rid: 69eab494-1040e2f8-5e8f4cda) — 15th consecutive failure; credential refresh required on PulseAgent platform side

## 2026-04-23 — WeChat retry for v2026.4.22: FAILED (40125 invalid appsecret — rid: 69eaa822-5aa7596a-0e5bd95d)
- Blog EN: already published → https://pulseagent.io/en/blog/openclaw-v2026-4-22-voice-calls-whatsapp-systemprompt-bedrock-opus
- Blog ZH: already published → https://pulseagent.io/en/blog/openclaw-v2026-4-22-voice-calls-whatsapp-systemprompt-bedrock-opus-zh
- WeChat: BLOCKED — PulseAgent backend WeChat appsecret must be corrected before publishes can resume
- ZH draft preserved at: .sync/blog-drafts/openclaw-v2026.4.22-zh.json

## 2026-04-23 — OpenClaw v2026.4.22 synced

- Previous release: v2026.4.21
- New release: v2026.4.22 (published 2026-04-23T13:56 UTC)
- CHANGELOG.md: updated with 13 categorized entries (11 new features, 1 changed, 2 fixed)
- Blog EN: published → https://pulseagent.io/en/blog/openclaw-v2026-4-22-voice-calls-whatsapp-systemprompt-bedrock-opus (postId: bea00657-90c4-43f8-a012-c75a58e58d2e)
- Blog ZH: published → https://pulseagent.io/en/blog/openclaw-v2026-4-22-voice-calls-whatsapp-systemprompt-bedrock-opus-zh (postId: f446e5fd-205a-47e7-8432-a2f83e96dfd9)
- WeChat: FAILED — 40125 invalid appsecret (WeChat Official Account credentials need refresh in PulseAgent backend)
- Drafts saved: .sync/blog-drafts/openclaw-v2026.4.22-en.json, openclaw-v2026.4.22-zh.json

### Key changes in v2026.4.22 (B2B SDR relevance)
- RELEVANT: Voice Call streaming transcription (Deepgram / ElevenLabs / Mistral)
- RELEVANT: Per-group WhatsApp systemPrompt config forwarding
- RELEVANT: Mailbox-style session filtering with labels and search
- RELEVANT: Bundled Tencent Cloud plugin + TokenHub (China market)
- RELEVANT: Claude Opus 4.7 via Amazon Bedrock Mantle
- RELEVANT: OpenAI Responses native web_search tool
- RELEVANT: Auto-install missing plugins on first setup
- WATCH: /models add command, medium thinking level default
- SKIP: Azure OpenAI image endpoint, OAuth model merging fix

## 2026-04-23 — No New Release (check run #66)
- Latest stable release: v2026.4.21
- Last synced release:   v2026.4.21
- Result: NO NEW RELEASE — no action taken

## 2026-04-23 — No New Release (check run #65)
- Latest stable release: v2026.4.21
- Last synced release:   v2026.4.21
- Result: NO NEW RELEASE — no action taken
- WeChat status: 40125 invalid appsecret persists (18th consecutive failure); no retry attempted — platform appsecret must be corrected on PulseAgent side before WeChat publishes can resume; ZH draft at `.sync/blog-drafts/openclaw-v2026.4.21-zh.json`

## 2026-04-23 — No New Release (check run #64)
- Latest stable release: v2026.4.21
- Last synced release:   v2026.4.21
- Result: NO NEW RELEASE — no action taken
- WeChat status: 40125 invalid appsecret persists (17th consecutive failure); no retry attempted — platform appsecret must be corrected on PulseAgent side before WeChat publishes can resume; ZH draft at `.sync/blog-drafts/openclaw-v2026.4.21-zh.json`

## 2026-04-23 — No New Release (check run #63)
- Latest stable release: v2026.4.21
- Last synced release:   v2026.4.21
- Result: NO NEW RELEASE — no action taken
- WeChat status: 40125 invalid appsecret persists (16th consecutive failure); no retry attempted — platform appsecret must be corrected on PulseAgent side before WeChat publishes can resume; ZH draft at `.sync/blog-drafts/openclaw-v2026.4.21-zh.json`

## 2026-04-23 — No New Release (check run #62)
- Latest stable release: v2026.4.21
- Last synced release:   v2026.4.21
- Result: NO NEW RELEASE — no action taken

## 2026-04-23 — No New Release (check run #61)
- Latest stable release: v2026.4.21
- Last synced release:   v2026.4.21
- Result: NO NEW RELEASE — no action taken
- WeChat status: 40125 invalid appsecret persists (15th consecutive failure); no retry attempted — platform appsecret must be corrected on PulseAgent side before WeChat publishes can resume; ZH draft at `.sync/blog-drafts/openclaw-v2026.4.21-zh.json`

## 2026-04-23 — No New Release (check run #60)
- Latest stable release: v2026.4.21
- Last synced release:   v2026.4.21
- Result: NO NEW RELEASE — no action taken

## 2026-04-23 — No New Release (check run #59)
- Latest stable release: v2026.4.21
- Last synced release:   v2026.4.21
- Result: NO NEW RELEASE — no action taken
- WeChat status: 40125 invalid appsecret persists (14th consecutive failure); no retry attempted — platform appsecret must be corrected on PulseAgent side before WeChat publishes can resume; ZH draft at `.sync/blog-drafts/openclaw-v2026.4.21-zh.json`

## 2026-04-23 — No New Release (check run #58)
- Latest stable release: v2026.4.21
- Last synced release:   v2026.4.21
- Result: NO NEW RELEASE — no action taken
- WeChat status: 40125 invalid appsecret persists (13th consecutive failure); no retry attempted — platform appsecret must be corrected on PulseAgent side before WeChat publishes can resume; ZH draft at `.sync/blog-drafts/openclaw-v2026.4.21-zh.json`

## 2026-04-23 — No New Release (check run #57)
- Latest stable release: v2026.4.21
- Last synced release:   v2026.4.21
- Result: NO NEW RELEASE — no action taken
- WeChat status: 40125 invalid appsecret persists (12th consecutive failure); platform appsecret must be corrected before WeChat publishes can resume; ZH draft at `.sync/blog-drafts/openclaw-v2026.4.21-zh.json`

## 2026-04-23 — No New Release (check run #56)
- Latest stable release: v2026.4.21
- Last synced release:   v2026.4.21
- Result: NO NEW RELEASE — no action taken
- WeChat retry (v2026.4.21): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69e96637-24090cc4-5058e6ce) — **11th consecutive 40125 failure; WeChat publish blocked until PulseAgent platform WeChat appsecret is corrected** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.21-zh.json`

## 2026-04-22 — No New Release (check run #55)
- Latest stable release: v2026.4.21
- Last synced release:   v2026.4.21
- Result: NO NEW RELEASE — no action taken
- WeChat retry skipped: 10 consecutive 40125 failures confirm platform appsecret misconfiguration — action required on PulseAgent side before retrying

## 2026-04-22 — No New Release (check run #54)
- Latest stable release: v2026.4.21
- Last synced release:   v2026.4.21
- Result: NO NEW RELEASE — no action taken
- WeChat retry skipped: 9 consecutive 40125 failures confirm platform appsecret misconfiguration — action required on PulseAgent side before retrying

## 2026-04-22 — No New Release (check run #53)
- Latest stable release: v2026.4.21
- Last synced release:   v2026.4.21
- Result: NO NEW RELEASE — no action taken
- WeChat retry skipped: 8 consecutive 40125 failures indicate a platform appsecret misconfiguration — retrying is futile until PulseAgent corrects the WeChat appsecret

## 2026-04-22 — No New Release (check run #52)
- Latest stable release: v2026.4.21
- Last synced release:   v2026.4.21 (blogs published by prior session)
- Result: NO NEW RELEASE — retried WeChat only
- WeChat retry (v2026.4.21): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69e8929e-43760d05-6c85653b) — **8th consecutive 40125 failure; action required: PulseAgent platform WeChat appsecret must be corrected** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.21-zh.json`

## 2026-04-22 — No New Release (check run #51)
- Latest stable release: v2026.4.21
- Last synced release:   v2026.4.21 (blogs published by prior session)
- Result: NO NEW RELEASE — retried WeChat only
- WeChat retry (v2026.4.21): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69e86738-758b8f2e-1f80507e) — **7th consecutive 40125 failure; action required: PulseAgent platform WeChat appsecret must be corrected** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.21-zh.json`

## 2026-04-22 — New Release Synced: v2026.4.21 (check run #50)
- Previous release: v2026.4.20
- New stable release: v2026.4.21 (published 2026-04-22T04:18:58Z)
- Skipped pre-releases: v2026.4.20-beta.2, v2026.4.20-beta.1
- Changes: gpt-image-2 default image gen (2K/4K hints), owner-command security fix, Slack thread routing fix, plugin doctor dependency repair, browser invalid-ref fast rejection, node-domexception deprecation fix
- CHANGELOG.md: updated
- EN blog: https://pulseagent.io/en/blog/openclaw-v2026-4-21-release (postId: 34c2e713-86b8-4be3-bed8-eac586e58638)
- ZH blog: https://pulseagent.io/blog/openclaw-v2026-4-21-release-zh (postId: 18d3c6da-e936-4925-ae21-7d5b57272ca8)
- WeChat: FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69e85ad3-6d9abc5c-2100aed9) — **6th consecutive 40125 failure; WeChat publish blocked until PulseAgent platform WeChat appsecret is corrected** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.21-zh.json`

## 2026-04-22 — No New Release (check run #49)
- Latest stable release: v2026.4.20
- Last synced release:   v2026.4.20 (blogs published by prior session)
- Skipped: v2026.4.20-beta.2, v2026.4.20-beta.1, v2026.4.19-beta.2, v2026.4.19-beta.1 (all pre-release)
- Result: NO NEW RELEASE — retrying WeChat only
- WeChat retry (v2026.4.20): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69e84c67-3b1bf615-186d6b34) — **5th consecutive 40125 failure; WeChat publish blocked until PulseAgent platform WeChat appsecret is corrected** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.20-zh.json`

## 2026-04-22 — No New Release (check run #48)
- Latest stable release: v2026.4.20
- Last synced release:   v2026.4.20 (blogs published by prior session)
- Skipped: v2026.4.20-beta.2 (pre-release), v2026.4.20-beta.1 (pre-release), v2026.4.19-beta.2 (pre-release), v2026.4.19-beta.1 (pre-release)
- Result: NO NEW RELEASE — retrying WeChat only
- WeChat retry (v2026.4.20): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69e83d42-68b6a5e5-35ceb2cf) — **4th consecutive 40125 failure; PulseAgent platform WeChat appsecret must be updated before this can succeed** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.20-zh.json`

## 2026-04-22 — WeChat Retry (run #47)
- Latest stable release: v2026.4.20
- Last synced release:   v2026.4.20 (blogs published by prior session)
- Result: NO NEW RELEASE — retrying WeChat only
- WeChat retry (v2026.4.20): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69e82e64-1c9a2fd9-57dfa3f9) — **persistent credential issue (3rd consecutive 40125 failure for v2026.4.20); action required: update WeChat appsecret in PulseAgent platform settings** — ZH draft available at `.sync/blog-drafts/openclaw-v2026.4.20-zh.json`

## 2026-04-22 — WeChat Retry (run #46)
- Last synced release:   v2026.4.20 (blogs published by prior session)
- Result: NO NEW RELEASE — retrying WeChat only
- WeChat retry (v2026.4.20): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69e81f37-3f1cd117-60f9796f) — **persistent credential issue (2nd consecutive 40125 failure for v2026.4.20); action required: update WeChat appsecret in PulseAgent platform settings** — ZH draft available at `.sync/blog-drafts/openclaw-v2026.4.20-zh.json`

## 2026-04-22 — No New Release (check run #45)
- Latest stable release: v2026.4.20
- Last synced release:   v2026.4.20
- Skipped: v2026.4.20-beta.2 (pre-release), v2026.4.20-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.

## 2026-04-21 — No New Release (check run #44)
- Latest stable release: v2026.4.20
- Last synced release:   v2026.4.20
- Skipped: v2026.4.20-beta.2 (pre-release), v2026.4.20-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.

## 2026-04-21 — No New Release (check run #43)
- Latest stable release: v2026.4.20
- Last synced release:   v2026.4.20
- Skipped: v2026.4.20-beta.2 (pre-release), v2026.4.20-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.

## 2026-04-21T19:20:00Z — Synced v2026.4.15 → v2026.4.20
- Previous release:  v2026.4.15
- New stable release: v2026.4.20 (published 2026-04-21T19:19 UTC by @steipete)
- Skipped betas: v2026.4.20-beta.2, v2026.4.20-beta.1, v2026.4.19-beta.2, v2026.4.19-beta.1
- Categorization: SECURITY (env injection + config mutation), RELEVANT (default prompts, session cap, auto-reply policy, Telegram fixes, web search plugins), WATCH (tiered pricing, cron split), SKIP (Matrix, Codex specifics)
- Template files updated: CHANGELOG.md, deploy/UPGRADE.md, workspace/TOOLS.md
- Blog EN: https://pulseagent.io/en/blog/openclaw-v2026420-security-hardening-smarter-agents (postId: e467f5b3-9ed6-457f-a1f0-e2a1da996487)
- Blog ZH: https://pulseagent.io/blog/openclaw-v2026420-anquan-jiagu-zhihui-daili (postId: 076cd870-d471-452d-99f6-7189eafbad87)
- WeChat: FAILED — WeChat API error 40125 (invalid appsecret on pulseagent.io server — infrastructure config issue)
- Result: SYNCED

## 2026-04-21 — No New Release (check run #42)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Skipped: v2026.4.19-beta.2 (pre-release), v2026.4.19-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.


## 2026-04-21 — No New Release (check run #41)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Skipped: v2026.4.19-beta.2 (pre-release), v2026.4.19-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.


## 2026-04-21 — No New Release (check run #40)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Skipped: v2026.4.19-beta.2 (pre-release), v2026.4.19-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.


## 2026-04-21 — No New Release (check run #39)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Skipped: v2026.4.19-beta.2 (pre-release), v2026.4.19-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.

## 2026-04-21 — No New Release (check run #38)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Skipped: v2026.4.19-beta.2 (pre-release), v2026.4.19-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.

## 2026-04-21 — No New Release (check run #37)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Skipped: v2026.4.19-beta.2 (pre-release), v2026.4.19-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.

## 2026-04-21 — No New Release (check run #36)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

## 2026-04-20 — No New Release (check run #35)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Skipped: v2026.4.19-beta.2 (pre-release), v2026.4.19-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.

## 2026-04-20 — No New Release (check run #34)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Skipped: v2026.4.19-beta.2 (pre-release), v2026.4.19-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.

## 2026-04-20 — No New Release (check run #33)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Skipped: v2026.4.19-beta.2 (pre-release), v2026.4.19-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.

## 2026-04-20 — No New Release (check run #32)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Skipped: v2026.4.19-beta.2 (pre-release), v2026.4.19-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.

## 2026-04-20 — No New Release (check run #31)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Skipped: v2026.4.19-beta.2 (pre-release), v2026.4.19-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.

## 2026-04-19 — No New Release (check run #30)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Skipped: v2026.4.19-beta.2 (pre-release), v2026.4.19-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.

## 2026-04-19 — No New Release (check run #29)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Skipped: v2026.4.19-beta.2 (pre-release), v2026.4.19-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.

## 2026-04-19 — No New Release (check run #28)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Skipped: v2026.4.19-beta.2 (pre-release), v2026.4.19-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-19 — No New Release (check run #27)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Skipped: v2026.4.19-beta.2 (pre-release), v2026.4.19-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-19 — No New Release (check run #26)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Skipped: v2026.4.19-beta.2 (pre-release), v2026.4.19-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-19 — No New Release (check run #25)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-19 — No New Release (check run #24)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-19 — No New Release (check run #23)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Skipped: v2026.4.19-beta.1 (pre-release)
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-19 — No New Release (check run #22)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

## 2026-04-18 — No New Release (check run #21)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-18 — No New Release (check run #20)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-18 — No New Release (check run #19)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

## 2026-04-18 — No New Release (check run #18)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

## 2026-04-18 — No New Release (check run #17)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

## 2026-04-18 — No New Release (check run #16)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-18 — No New Release (WeChat retry run #14)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.
- WeChat retry for v2026.4.15: FAILED — error 40125 invalid appsecret (rid: 69e30b42-5e7eaae3-413dd629)
- **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings** (persistent since original v2026.4.15 sync)

---

## 2026-04-18 — No New Release (check run #15)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-18 — No New Release (check run #13)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-17 — No New Release (check run #12)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-17 — No New Release (check run #11)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-17 — No New Release (check run #10)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-17 — No New Release (check run #9)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-17 — No New Release (check run #8)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-17 — No New Release (check run #7)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-17 — No New Release (check run #6)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-17 — No New Release (check run #5)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.

## 2026-04-17 — No New Release (WeChat retry run #4)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.
- WeChat retry for v2026.4.15: FAILED — error 40125 invalid appsecret (rid: 69e1a441-1b80079a-1cb3be27)
- **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings** (persistent since original v2026.4.15 sync — requires server-side credential rotation)

---

## 2026-04-17 — No New Release (WeChat retry run #3)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.
- WeChat retry for v2026.4.15: FAILED — error 40125 invalid appsecret (rid: 69e19b9d-7ab11bfd-2b9624d3)
- **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings** (persistent since original v2026.4.15 sync — requires server-side credential rotation)

---

## 2026-04-17 — No New Release (WeChat retry run #2)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.
- WeChat retry for v2026.4.15: FAILED — error 40125 invalid appsecret (rid: 69e1883b-0c795b00-6026d943)
- **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-17 — No New Release (WeChat retry run #1)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.
- WeChat retry for v2026.4.15: FAILED — Cloudflare 403 error 1010 (session IP blocked by pulseagent.io WAF)
- **ACTION REQUIRED: publish WeChat manually or use a whitelisted IP/proxy**

---

## 2026-04-16 — No New Release (WeChat retry run)
- Latest stable release: v2026.4.15
- Last synced release:   v2026.4.15
- Result: NO NEW RELEASE — exiting.
- WeChat retry for v2026.4.15: FAILED — error 40125 invalid appsecret (rid: 69e16c9a-7031a341-45e62913)
- **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-16 — OpenClaw v2026.4.15 sync

### Release
- v2026.4.14 → v2026.4.15
- Published: 2026-04-16T21:50:22Z

### Categorization
- RELEVANT: Anthropic/models → Claude Opus 4.7 as default
- RELEVANT: Agents/context+Memory → trimmed default prompt budgets
- WATCH:    Google/TTS → Gemini text-to-speech added
- SKIP:     BlueBubbles/inbound, CLI/update internals, Gateway/tools, OpenAI Codex routing

### Template changes
- `workspace/TOOLS.md`: upgrade banner → v2026.4.15, Anthropic row updated (Opus 4.7), Opus 4.7 + Gemini TTS notes added
- `CHANGELOG.md`: v2026.4.15 entry added

### Blog
- EN published: https://pulseagent.io/en/blog/openclaw-v2026415-claude-opus-47-google-tts (postId: 306f98a1-e2ee-49e0-ac64-57ed4364495d)
- ZH published: https://pulseagent.io/blog/openclaw-v2026415-claude-opus-47-google-tts (postId: 5126383e-8e0c-44e2-bce9-18f14d43afe2)
- Drafts: .sync/blog-drafts/openclaw-v2026.4.15-en.json, openclaw-v2026.4.15-zh.json

### WeChat
- STATUS: FAILED — WeChat token error 40125 (invalid appsecret on PulseAgent backend — requires server-side fix)

## 2026-04-16T21:16:56Z — No New Release (run #175)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Latest prerelease:     v2026.4.15-beta.2 (skipped — beta)
- Result: NO NEW RELEASE — exiting.

---

## 2026-04-16 — No New Release (run #174)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Latest prerelease:     v2026.4.15-beta.1 (skipped — beta)
- Result: NO NEW RELEASE — exiting. Blogs already published (runs #144, #146)
- Blog EN: https://pulseagent.io/en/blog/openclaw-v2026-4-14-gpt5-active-memory-teams
- Blog ZH: https://pulseagent.io/blog/openclaw-v2026-4-14-gpt5-active-memory-teams-zh
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-16 — No New Release (run #173)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Latest prerelease:     v2026.4.15-beta.1 (skipped — beta)
- Result: NO NEW RELEASE — exiting. Blogs already published (runs #144, #146)
- Blog EN: https://pulseagent.io/en/blog/openclaw-v2026-4-14-gpt5-active-memory-teams
- Blog ZH: https://pulseagent.io/blog/openclaw-v2026-4-14-gpt5-active-memory-teams-zh
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-16 — No New Release (run #172)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Latest prerelease:     v2026.4.15-beta.1 (skipped — beta)
- Result: NO NEW RELEASE — exiting. Blogs already published (runs #144, #146)
- Blog EN: https://pulseagent.io/en/blog/openclaw-v2026-4-14-gpt5-active-memory-teams
- Blog ZH: https://pulseagent.io/blog/openclaw-v2026-4-14-gpt5-active-memory-teams-zh
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-16 — No New Release (run #171)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Latest prerelease:     v2026.4.15-beta.1 (skipped — beta)
- Result: NO NEW RELEASE — exiting. Blogs already published (runs #144, #146)
- Blog EN: https://pulseagent.io/en/blog/openclaw-v2026-4-14-gpt5-active-memory-teams
- Blog ZH: https://pulseagent.io/blog/openclaw-v2026-4-14-gpt5-active-memory-teams-zh
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-16 — No New Release (run #170)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Latest prerelease:     v2026.4.15-beta.1 (skipped — beta)
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- Blog EN: https://pulseagent.io/en/blog/openclaw-v2026-4-14-gpt5-active-memory-teams
- Blog ZH: https://pulseagent.io/blog/openclaw-v2026-4-14-gpt5-active-memory-teams-zh
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-16 — No New Release (run #168)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Latest prerelease:     v2026.4.15-beta.1 (skipped — beta)
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- Blog EN: https://pulseagent.io/en/blog/openclaw-v2026-4-14-gpt5-active-memory-teams
- Blog ZH: https://pulseagent.io/blog/openclaw-v2026-4-14-gpt5-active-memory-teams-zh
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-16 — No New Release (run #167)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Latest prerelease:     v2026.4.15-beta.1 (skipped — beta)
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- Blog EN: https://pulseagent.io/en/blog/openclaw-v2026-4-14-gpt5-active-memory-teams
- Blog ZH: https://pulseagent.io/blog/openclaw-v2026-4-14-gpt5-active-memory-teams-zh
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-16 — No New Release (run #166)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Latest prerelease:     v2026.4.15-beta.1 (skipped — beta)
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- Blog EN: https://pulseagent.io/en/blog/openclaw-v2026-4-14-gpt5-active-memory-teams
- Blog ZH: https://pulseagent.io/blog/openclaw-v2026-4-14-gpt5-active-memory-teams-zh
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-15 — No New Release (run #165)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Latest prerelease:     v2026.4.15-beta.1 (skipped — beta)
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- Blog EN: https://pulseagent.io/en/blog/openclaw-v2026-4-14-gpt5-active-memory-teams
- Blog ZH: https://pulseagent.io/blog/openclaw-v2026-4-14-gpt5-active-memory-teams-zh
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-15 — No New Release (run #164)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Latest prerelease:     v2026.4.15-beta.1 (skipped — beta)
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- Blog EN: https://pulseagent.io/en/blog/openclaw-v2026-4-14-gpt5-active-memory-teams
- Blog ZH: https://pulseagent.io/blog/openclaw-v2026-4-14-gpt5-active-memory-teams-zh
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-15 — No New Release (run #163)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Latest prerelease:     v2026.4.15-beta.1 (skipped — beta)
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- Blog EN: https://pulseagent.io/en/blog/openclaw-v2026-4-14-gpt5-active-memory-teams
- Blog ZH: https://pulseagent.io/blog/openclaw-v2026-4-14-gpt5-active-memory-teams-zh
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-15 — No New Release (run #162)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Latest prerelease:     v2026.4.15-beta.1 (skipped — beta)
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- Blog EN: https://pulseagent.io/en/blog/openclaw-v2026-4-14-gpt5-active-memory-teams
- Blog ZH: https://pulseagent.io/blog/openclaw-v2026-4-14-gpt5-active-memory-teams-zh
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-15 — No New Release (run #161)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Latest prerelease:     v2026.4.15-beta.1 (skipped — beta)
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-15 — No New Release + WeChat Retry (run #160)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- Blog EN: https://pulseagent.io/en/blog/openclaw-v2026-4-14-gpt5-active-memory-teams
- Blog ZH: https://pulseagent.io/blog/openclaw-v2026-4-14-gpt5-active-memory-teams-zh
- WeChat retry (v2026.4.14): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69df2b89-708ba2fa-0c7aa713) — persistent since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-15 — No New Release (run #159)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-15 — No New Release (run #158)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-15 — No New Release (run #157)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-15 — No New Release (run #156)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-15 — No New Release (run #155)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-14 — No New Release + WeChat Retry (run #154)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- WeChat retry (v2026.4.14): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69dec813-3f47ae13-6e22f679) — persistent since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-14 — No New Release (run #153)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-14 — No New Release (run #152)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-14 — No New Release (run #151)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- WeChat: SKIPPED — persistent `40125 invalid appsecret` since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-14 — No New Release + WeChat Retry (run #150)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- WeChat retry (v2026.4.14): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69de8f79-7db20883-4367e72f) — persistent since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-14 — No New Release (run #149)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- WeChat: SKIPPED — persistent `40125 invalid appsecret` error since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-14 — No New Release (run #148)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- WeChat: SKIPPED — persistent `40125 invalid appsecret` error since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-14 — No New Release + WeChat Retry (run #147)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Result: NO NEW RELEASE — blogs already published (runs #144, #146)
- WeChat retry (v2026.4.14): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69de6772-3acd2c29-6490a357) — **persistent since run #83; ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings** — ZH draft saved at `.sync/blog-drafts/openclaw-v2026.4.14-zh.md`; ZH blog live at https://pulseagent.io/blog/openclaw-v2026-4-14-gpt5-active-memory-teams-zh

---

## 2026-04-14 — New Release v2026.4.14 (run #146)
- Previous tracked release on main: v2026.4.9 (local main was stale; origin/main was at v2026.4.14 via detached-HEAD runs #83–#145)
- New stable release: v2026.4.14 (published 2026-04-14T13:03:29Z)
- Intermediate stable releases covered: v2026.4.10, v2026.4.11, v2026.4.12, v2026.4.14
- Action: blogs published (additional), sync state on main updated
- Blog EN: PUBLISHED ✅ — https://pulseagent.io/en/blog/openclaw-v2026-4-14-gpt5-active-memory-teams (postId: 8617d012-9aac-47ec-8d2b-5235951a52d8)
- Blog ZH: PUBLISHED ✅ — https://pulseagent.io/blog/openclaw-v2026-4-14-gpt5-active-memory-teams-zh (postId: deeb0736-8a5a-461c-87b7-db91e309ac17)
- WeChat: FAILED ❌ — `40125 invalid appsecret` (rid: 69de5aa5-401df22a-4a4db499) — persistent since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-14 — No New Release (run #145)
- Latest stable release: v2026.4.14
- Last synced release:   v2026.4.14
- Result: NO NEW RELEASE — exiting (v2026.4.14 already fully synced in run #144)
- WeChat: NOT RETRIED — `40125 invalid appsecret` persists; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-14 — New Release v2026.4.14 (run #144)
- Previous tracked release: v2026.4.12
- New stable release: v2026.4.14 (published 2026-04-14T13:03:29Z, 44 contributors)
- Action: CHANGELOG updated, blogs published, sync state updated
- CHANGELOG: updated with GPT-5.4-Pro, Telegram topics, security fixes (XSS/SSRF), WhatsApp/Teams/Feishu/Discord/TTS, memory + cron improvements
- Blog EN: PUBLISHED ✅ — https://pulseagent.io/en/blog/openclaw-v2026-4-14-gpt5-telegram-topics-security (postId: b958cdee-3c2e-409a-92b8-33930dc3cefc)
- Blog ZH: PUBLISHED ✅ — https://pulseagent.io/en/blog/openclaw-v2026-4-14-gpt5-telegram-topics-security-zh (postId: 0b46b01f-27b5-432e-9c4b-3063ee66d6dd)
- WeChat: FAILED ❌ — `40125 invalid appsecret` (rid: 69de3d7c-366b9e3e-2109a06e) — persistent since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-14 — CHANGELOG catchup (run #143)
- Latest stable release: v2026.4.12 (already tracked)
- Action: Added missing CHANGELOG entries for v2026.4.11 + v2026.4.12
- Blogs (already published): EN https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio | ZH https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh
- WeChat: FAILED ❌ — `40125 invalid appsecret` (rid: 69de324d-62cbc7ee-0531662c) — persistent since run #83; **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-14 — No New Release (run #141)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- Next pre-release seen: v2026.4.14-beta.1 (skipped — prerelease)
- WeChat: **NOT RETRIED** — `40125 invalid appsecret` persists across runs #114–#140. No action until appsecret is refreshed in PulseAgent platform settings.

---

## 2026-04-14 — No New Release (run #140)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat: **NOT RETRIED** — `40125 invalid appsecret` has persisted for 25+ consecutive runs (#114–#139). Retrying is futile until appsecret is refreshed in PulseAgent platform settings.
- Next pre-release: v2026.4.14-beta.1 (skipped — prerelease)

---

## 2026-04-14 — No New Release (run #139)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced)
- Next beta: v2026.4.14-beta.1 (prerelease, skipped per rules)

## 2026-04-14 — No New Release (run #138)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat: **NOT RETRIED** — error `40125 invalid appsecret` has persisted across 24 consecutive attempts (runs #114–#137). Retrying is futile until appsecret is refreshed. **ACTION REQUIRED: update WeChat appsecret in PulseAgent platform settings.**
- Next pre-release: v2026.4.14-beta.1 (skipped — prerelease)

---

## 2026-04-14 — No New Release + WeChat Retry (run #137)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69ddd92e-4683d762-235de8c4) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; 24th consecutive failure for v2026.4.12 (runs #114–#137); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-14 — No New Release + WeChat Retry (run #136)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69ddccc1-276d8aae-2f0f2b96) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; 23rd consecutive failure for v2026.4.12 (runs #114–#136); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-14 — No New Release + WeChat Retry (run #135)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114); next pre-release v2026.4.14-beta.1 skipped
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69ddc0a7-59a3f7c2-4ecc33ff) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; 22nd consecutive failure for v2026.4.12 (runs #114–#135); appsecret credential is invalid — Cloudflare WAF cleared; ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-14 — No New Release + WeChat Retry (run #134)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69ddc050-016f3e97-4fc5364f) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; 21st consecutive failure for v2026.4.12 (runs #114–#134); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-14 — No New Release + WeChat Retry (run #133)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69ddb4c4-14134790-7c5345ee) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; 20th consecutive failure for v2026.4.12 (runs #114–#133); NOTE: Cloudflare WAF now cleared — API reaches WeChat, the appsecret credential itself is invalid; ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-14 — No New Release + WeChat Retry (run #132)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69ddb3e2-509ec1da-444beb84) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; 19th consecutive failure for v2026.4.12 (runs #114–#132); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-14 — No New Release + WeChat Retry (run #131)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69dda3d7-701ad236-5107ed54) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; 18th consecutive failure for v2026.4.12 (runs #114–#131); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-14 — No New Release + WeChat Retry (run #130)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat retry (v2026.4.12): FAILED ❌ — `HTTP 403 / Cloudflare error 1010` (ASN/IP ban — agent server IP blocked by Cloudflare WAF on pulseagent.io) — **ACTION REQUIRED: whitelist agent server IP in Cloudflare dashboard for pulseagent.io; 17th consecutive failure for v2026.4.12 (runs #114–#130); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-14 — No New Release + WeChat Retry (run #129)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat retry (v2026.4.12): FAILED ❌ — `HTTP 403 / Cloudflare error 1010` (ASN/IP ban — agent server IP blocked by Cloudflare WAF on pulseagent.io) — **ACTION REQUIRED: whitelist agent server IP in Cloudflare dashboard for pulseagent.io; 16th consecutive failure for v2026.4.12 (runs #114–#129); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-13 — No New Release + WeChat Retry (run #128)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69dd7a36-6b1244c5-4f0bc499) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; 15th consecutive failure for v2026.4.12 (runs #114–#128); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-13 — No New Release + WeChat Retry (run #127)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69dd6ede-4e232a19-0e6910f0) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; 14th consecutive failure for v2026.4.12 (runs #114–#127); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-13 — No New Release + WeChat Retry (run #126)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69dd5e55-4ac66d9e-0dfec4c8) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; 13th consecutive failure for v2026.4.12 (runs #114–#126); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-13 — No New Release + WeChat Retry (run #125)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69dd4d88-2db328ea-6ba7a72e) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; 12th consecutive failure for v2026.4.12 (runs #114–#125); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-13 — No New Release + WeChat Retry (run #124)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat retry (v2026.4.12): FAILED ❌ — `HTTP 403 / Cloudflare error 1010` (ASN/IP ban — new error type, distinct from previous 40125 invalid appsecret) — **ACTION REQUIRED: (1) refresh WeChat appsecret in PulseAgent platform settings AND (2) check Cloudflare access rules — server IP may be blocked; 11th consecutive failure for v2026.4.12 (runs #114–#124); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-13 — No New Release + WeChat Retry (run #123)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69dd2361-041ae7eb-668454b0) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; 10th consecutive failure for v2026.4.12 (runs #114–#123); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-13 — No New Release + WeChat Retry (run #122)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69dd15ec-6ff9119d-7efb0ee3) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; 9th consecutive failure for v2026.4.12 (runs #114–#122); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-13 — No New Release + WeChat Retry (run #121)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69dd0f25-090ab04b-127ab941) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; 8th consecutive failure for v2026.4.12 (runs #114–#121); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-13 — No New Release + WeChat Retry (run #120)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69dd01dd-2250813f-4fdeb3c4) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; 7th consecutive failure for v2026.4.12 (runs #114–#120); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-13 — No New Release + WeChat Retry (run #119)
- Latest stable release: v2026.4.12
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114)
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69dceddd-1733d5a0-7b0966f4) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; 6th consecutive failure for v2026.4.12 (runs #114–#119); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-13 — No New Release + WeChat Retry (run #118)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114; v2026.4.12-beta.1 is prerelease — skipped)
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69dce02d-6b13cb04-10f2a2ee) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; 5th consecutive failure for v2026.4.12 (runs #114–#118); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-13 — No New Release + WeChat Retry (run #117)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114; v2026.4.12-beta.1 is prerelease — skipped)
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69dcd26f-570e4136-6093f049) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; 4th consecutive failure for v2026.4.12 (runs #114–#117); ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-13 — No New Release + WeChat Retry (run #116)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114; v2026.4.12-beta.1 is prerelease — skipped)
- WeChat retry (v2026.4.12): FAILED ❌ — `HTTP 403 / Cloudflare error 1010` (IP/browser-signature block on API endpoint) — **ACTION REQUIRED: check PulseAgent API gateway / Cloudflare rules; ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md`; blog live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh**

---

## 2026-04-13 — No New Release + WeChat Retry (run #115)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.12
- Result: NO NEW RELEASE — exiting (v2026.4.12 already synced in run #114; v2026.4.12-beta.1 is prerelease — skipped)
- WeChat retry (v2026.4.12): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69dcbb7d-6ba3dba7-6922f1e4) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.12-zh.md` — blog already live at https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh

---

## 2026-04-13 — FULL SYNC: v2026.4.11 → v2026.4.12 (run #114)
- Previous tracked release: v2026.4.11
- Latest stable release:    v2026.4.12 (published 2026-04-13)
- Result: NEW RELEASE ✅
- Template: ANTI-AMNESIA.md bumped to v2.1 — Active Memory plugin (L1.5 callout)
- Blog EN: published ✅ — https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio (postId: 81294ca7-eecc-43a1-b8b9-b2747feec59b)
- Blog ZH: published ✅ — https://pulseagent.io/en/blog/openclaw-v2026-4-12-active-memory-lm-studio-zh (postId: a10240b7-2c23-4935-afb3-94feab707939)
- WeChat: FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69dcb239-099a15e8-56a22213) — **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings**
- Key changes: Active Memory plugin, LM Studio provider, Codex provider, 3 security CVEs (interpreter injection / approval auth bypass / shell-wrapper injection), WhatsApp media fallback, drop-proof orphaned messages, WebSocket keepalive

---

## 2026-04-13 — No New Release (run #113)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- Note: `v2026.4.12-beta.1` exists but is prerelease — skipped per rules
- WeChat: skipped (no new content)

---

## 2026-04-13 — No New Release (run #112)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- Note: `v2026.4.12-beta.1` exists but is prerelease — skipped per rules
- WeChat: skipped (no new content to push; credential issue from run #111 still pending resolution)

---

## 2026-04-13 — No New Release (run #111)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- Note: `v2026.4.12-beta.1` exists (published 2026-04-12) but is prerelease — skipped per rules
- WeChat retry (v2026.4.11): FAILED ❌ — `WeChat API error: 40125 invalid appsecret` (rid: 69dc8016-574973bb-0f791ee2) — 27th consecutive failure (runs #83–#111); **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; no further retries until credential is updated** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.json`

---

## 2026-04-13 — FULL SYNC: v2026.4.9 → v2026.4.11 (run #110)
- Previous tracked release: v2026.4.9 (local main was behind origin/main due to prior detached-HEAD runs)
- Latest stable release: v2026.4.11 (published 2026-04-12, two new releases: v2026.4.10 + v2026.4.11)
- Skipped: v2026.4.12-beta.1 (prerelease)
- **Categorization**: BREAKING=none | RELEVANT=Active Memory plugin, MS Teams full integration, WhatsApp reconnect fix, gateway thread routing, security hardening | WATCH=GPT-5.4 parity gate | SKIP=QQBot, Matrix, macOS MLX speech
- **Template changes**: IDENTITY.md (added Teams channel), MEMORY.md (L0 Active Memory plugin docs), HEARTBEAT.md (step 13 Teams mention check, renumbered WhatsApp step to 14)
- **Blog EN**: published ✅ https://pulseagent.io/en/blog/openclaw-v2026-4-11-active-memory-teams-whatsapp (postId: 73903e44-174a-489e-a86c-e6808e2810cc)
- **Blog ZH**: published ✅ https://pulseagent.io/blog/openclaw-v2026-4-11-active-memory-teams-whatsapp (postId: 8d62451d-88c7-4829-a420-6c6089825f38)
- **WeChat**: FAILED ❌ — 40125 invalid appsecret (rid: 69dc746c-1cc6bce4-7b77cf59). **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.json`

---

## 2026-04-13 — No New Release (run #109)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- Note: `v2026.4.12-beta.1` exists (published 2026-04-12) but is prerelease — skipped per rules
- WeChat: skipping retry — 26+ consecutive `40125 invalid appsecret` failures (runs #83–#108); **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; no further retries until credential is updated** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-13 — No New Release (run #108)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- Note: `v2026.4.12-beta.1` exists (published 2026-04-12) but is prerelease — skipped per rules
- WeChat: skipping retry — 24+ consecutive `40125 invalid appsecret` failures (runs #83–#107); **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; no further retries until credential is updated** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-13 — No New Release (run #107)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- Note: `v2026.4.12-beta.1` exists (published 2026-04-12) but is prerelease — skipped per rules
- WeChat: skipping retry — 23+ consecutive `40125 invalid appsecret` failures (runs #83–#106); **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; no further retries until credential is updated** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-13 — No New Release (run #106)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- Note: `v2026.4.12-beta.1` exists (published 2026-04-12) but is prerelease — skipped per rules
- WeChat: skipping retry — 22+ consecutive `40125 invalid appsecret` failures (runs #83–#105); **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; no further retries until credential is updated** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-12 — No New Release (run #105)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- WeChat: skipping retry — 16+ consecutive `40125 invalid appsecret` failures (runs #83–#104); **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; no further retries until credential is updated** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-12 — No New Release (run #104)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- WeChat retry (v2026.4.11): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69dc1b9e-2d9c20c0-68491720) — **16th consecutive failure (runs #83–#104); appsecret is definitively stale — ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; no further retries until credential is updated** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-12 — No New Release (run #103)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- WeChat: skipping retry — 15+ consecutive `40125 invalid appsecret` failures (runs #83–#102); **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; no further retries until credential is updated** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-12 — No New Release (run #102)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- WeChat retry (v2026.4.11): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69dc01fe-23104bef-6feda17e) — **15th consecutive failure (runs #83–#102); appsecret is definitively stale — ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; no further retries until credential is updated** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-12 — No New Release (run #101)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- WeChat: skipping retry — 14+ consecutive `40125 invalid appsecret` failures (runs #83–#100); **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; no further retries until credential is updated** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-12 — No New Release (run #100)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- WeChat: skipping retry — 14+ consecutive `40125 invalid appsecret` failures (runs #83–#99); **ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; no further retries until credential is updated** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-12 — No New Release (run #99)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- WeChat retry (v2026.4.11): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69dbd432-261e5c5f-47e42786) — **14th consecutive 40125 failure (runs #83–#99); appsecret is definitively stale — ACTION REQUIRED: refresh WeChat appsecret in PulseAgent platform settings; no further retries until credential is updated** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-12 — No New Release (run #98)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- WeChat retry (v2026.4.11): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69dbc6ad-77e4094b-6280281f) — **13th consecutive 40125 failure (runs #83–#98); appsecret is definitively stale — no further retries until appsecret is refreshed in PulseAgent platform settings** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-12 — No New Release (run #97)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- WeChat: skipping retry — 12+ consecutive `40125 invalid appsecret` failures (runs #83–#96); **no further retries until appsecret is refreshed in PulseAgent platform settings** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-12 — No New Release (run #96)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- WeChat: skipping retry — 11 consecutive `40125 invalid appsecret` failures (runs #83–#94); **no further retries until appsecret is refreshed in PulseAgent platform settings** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-12 — No New Release (run #95)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- WeChat: skipping retry — 11 consecutive `40125 invalid appsecret` failures (runs #83–#94); **no further retries until appsecret is refreshed in PulseAgent platform settings** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-12 — No New Release (run #94)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- WeChat retry (v2026.4.11): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69db8a9c-64b905ed-67c543b7) — **11th consecutive 40125 failure (runs #83–#94); credential is definitively stale — no further retries until appsecret is refreshed in PulseAgent platform settings** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-12 — No New Release (run #93)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- WeChat retry (v2026.4.11): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69db7e1b-1bf2ad46-2217f084) — **10th consecutive 40125 failure (runs #83–#93); action required: update WeChat appsecret in PulseAgent platform settings — no further retries until credential is fixed** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-12 — No New Release (run #92)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- WeChat retry (v2026.4.11): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69db70b7-46891988-7ae25fc3) — **9th consecutive 40125 failure (runs #83–#92); action required: update WeChat appsecret in PulseAgent platform settings before any further retries** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---


## 2026-04-12 — No New Release (run #91)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting
- WeChat retry (v2026.4.11): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69db5fc5-212d81c3-797ae1c2) — **8th consecutive 40125 failure (runs #83–#91); action required: update WeChat appsecret in PulseAgent platform settings before any further retries** — ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-12 — No New Release (run #90)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Checked: v2026.4.11-beta.1 (skipped — pre-release)
- Result: NO NEW RELEASE — exiting
- WeChat note: 7+ consecutive `40125 invalid appsecret` failures (runs #83–#89); no retry attempted — **action required: update WeChat appsecret in PulseAgent platform settings**

---

## 2026-04-12 — No New Release (run #89)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Checked: v2026.4.11-beta.1 (skipped — pre-release)
- Result: NO NEW RELEASE — exiting
- WeChat note: 6 consecutive `40125 invalid appsecret` failures recorded (runs #83–#88); no retry attempted — **action required: update WeChat appsecret in PulseAgent platform settings before next run**

---

## 2026-04-12 — WeChat Retry (run #88)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11 (blogs published by prior session)
- Result: NO NEW RELEASE — retrying WeChat only
- WeChat retry (v2026.4.11): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69db3e39-0724e34a-00823a13) — **5th consecutive 40125 failure; action required: update WeChat appsecret in PulseAgent platform settings** — ZH draft available at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-12 — No New Release (run #87)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11
- Result: NO NEW RELEASE — exiting

## 2026-04-12 — v2026.4.11 WeChat Retry (run #86)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11 (blogs published by prior session)
- Result: NO NEW RELEASE — retrying WeChat only
- WeChat retry (v2026.4.11): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69db1e0b-4148cbaf-6e507096) — **persistent credential issue (4th consecutive 40125 failure); action required: update WeChat appsecret in PulseAgent platform settings** — ZH draft available at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-12 — v2026.4.11 WeChat Retry (run #85)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11 (blogs published by prior session)
- Result: NO NEW RELEASE — retrying WeChat only
- WeChat retry (v2026.4.11): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69db0c53-40d297ba-42f0dcee) — **persistent credential issue; action required: update WeChat appsecret in PulseAgent platform settings** — ZH draft available at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`

---

## 2026-04-12 — v2026.4.11 WeChat Retry (run #84)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11 (blogs published by prior session)
- Result: NO NEW RELEASE — retrying WeChat only
- WeChat retry (v2026.4.11): FAILED — `WeChat API error: 40125 invalid appsecret` (rid: 69db02f2-01cc4026-3a56834f) — **persistent credential issue; action required: update WeChat appsecret in PulseAgent platform settings, then re-run or publish draft manually from `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`**

---

## 2026-04-12 — v2026.4.11 WeChat Retry (run #83)
- Latest stable release: v2026.4.11
- Last synced release:   v2026.4.11 (blogs published by prior session)
- Result: NO NEW RELEASE — retrying WeChat only
- WeChat retry (v2026.4.11): FAILED — HTTP 403 Cloudflare error 1010 (WAF/IP block on pulseagent.io API server — same as run #77) — **action required: whitelist server egress IP in Cloudflare dashboard, or publish WeChat article manually using the ZH draft at `.sync/blog-drafts/openclaw-v2026.4.11-zh.md`**

---

## 2026-04-11 — Release Check + WeChat Retry (run #82)
- Latest stable release: v2026.4.10
- Last synced release:   v2026.4.10
- Checked: v2026.4.11-beta.1 (skipped — pre-release)
- Result: NO NEW RELEASE — exiting
- WeChat retry (v2026.4.10): FAILED — 40125 invalid appsecret (rid: 69dad5c6-6c7b4ae8-2115b72e) — **action required: fix WeChat appsecret in PulseAgent dashboard** (same error as run #73 and run #77)

---

## 2026-04-11 — Release Check (run #81)
- Latest stable release: v2026.4.10
- Last synced release:   v2026.4.10
- Checked: v2026.4.11-beta.1 (skipped — pre-release)
- Result: NO NEW RELEASE — exiting

---

## 2026-04-11 — Release Check (run #80)
- Latest stable release: v2026.4.10
- Last synced release:   v2026.4.10
- Checked: v2026.4.11-beta.1 (skipped — pre-release)
- Result: NO NEW RELEASE — exiting

---

## 2026-04-11 — Release Check (run #79)
- Latest stable release: v2026.4.10
- Last synced release:   v2026.4.10
- Checked: v2026.4.11-beta.1 (skipped — pre-release)
- Result: NO NEW RELEASE — exiting

---

## 2026-04-11 — Release Check (run #78)
- Latest stable release: v2026.4.10
- Last synced release:   v2026.4.10
- Checked: v2026.4.11-beta.1 (skipped — pre-release)
- Result: NO NEW RELEASE — exiting

---

## 2026-04-11 — Release Check + WeChat Retry (run #77)
- Latest stable release: v2026.4.10
- Last synced release:   v2026.4.10
- Checked: v2026.4.11-beta.1 (skipped — pre-release)
- Result: NO NEW RELEASE — exiting
- WeChat retry (v2026.4.10): FAILED — HTTP 403 / Cloudflare error code 1010 (WAF block — IP or bot signature blocked; prior runs failed with 40125 appsecret — now a different layer; **action required: whitelist server IP in Cloudflare or publish WeChat article manually**)

---

## 2026-04-11 — Release Check (run #76)
- Latest stable release: v2026.4.10
- Last synced release:   v2026.4.10
- Checked: v2026.4.11-beta.1 (skipped — pre-release)
- Result: NO NEW RELEASE — exiting

---

## 2026-04-11 — Release Check (run #75)
- Latest stable release: v2026.4.10
- Last synced release:   v2026.4.10
- Checked: 2026.4.11-beta.1 (skipped — pre-release)
- Result: NO NEW RELEASE — exiting

---

## 2026-04-11 — v2026.4.10 Full Sync (recovery publish)
- Previous published release: v2026.4.5
- Release: v2026.4.10 (2026-04-11T02:43:25Z)
- Note: Drafts were generated in a prior session but blog API calls never completed; last-release was prematurely advanced. This run re-publishes the drafts.
- Classification: RELEVANT (Active Memory plugin, Codex provider, Teams actions, exec-policy CLI, 126 security fixes)
- Blog published:
  - EN: https://pulseagent.io/en/blog/openclaw-v2026-4-10-active-memory-codex-teams (postId: 81c3726f-1271-4a6b-8c81-178506cd210e, action: updated)
  - ZH: https://pulseagent.io/blog/openclaw-v2026-4-10-active-memory-codex-teams (postId: 82384a46-6c35-40f0-b7ce-062f3d6abe5b, action: updated)
- WeChat: FAILED — WeChat API error 40125 (invalid appsecret) — server-side config issue, retry manually after refreshing appsecret in WeChat Official Account dashboard
- Release pointer confirmed: v2026.4.10

## 2026-04-11 — Release Check (run #74)
- Latest stable release: v2026.4.10
- Last synced release:   v2026.4.10
- Result: NO NEW RELEASE — exiting

---

## 2026-04-11 — Release Check + WeChat Retry (run #73)
- Latest stable release: v2026.4.10
- Last synced release:   v2026.4.10
- Result: NO NEW RELEASE — exiting
- WeChat retry (v2026.4.10): FAILED — 40125 invalid appsecret (rid: 69da4a86-3caa82bc-1e4e5958) — **action required: fix WeChat appsecret in PulseAgent dashboard**

---

## 2026-04-11 — Release Check (run #72)
- Latest stable release: v2026.4.10
- Last synced release:   v2026.4.10
- Result: NO NEW RELEASE — exiting

---

## 2026-04-11 — Release Check (run #71)
- Latest stable release: v2026.4.10
- Last synced release:   v2026.4.10
- Result: NO NEW RELEASE — exiting

---

## 2026-04-11 — Release Check (run #70)
- Latest stable release: v2026.4.10
- Last synced release:   v2026.4.10
- Result: NO NEW RELEASE — exiting

---

## 2026-04-11 — Release Check (run #69)
- Latest stable release: v2026.4.10
- Last synced release:   v2026.4.10
- Result: NO NEW RELEASE — exiting

---

## 2026-04-11 — Release Check (run #68)
- Latest stable release: v2026.4.10
- Last synced release:   v2026.4.10
- Result: NO NEW RELEASE — exiting

---

## 2026-04-11 — Release Check + WeChat Retry (run #67)
- Latest stable release: v2026.4.10
- Last synced release:   v2026.4.10
- Result: NO NEW RELEASE — exiting
- WeChat retry (v2026.4.10): FAILED — 40125 invalid appsecret (rid: 69d9e525-5f9fa10c-03c45433) — **action required: fix WeChat appsecret in PulseAgent dashboard**

---

## 2026-04-11 — Release Check (run #66)
- Latest stable release: v2026.4.10
- Last synced release:   v2026.4.10
- Result: NO NEW RELEASE — exiting

---

## 2026-04-11 — Release Check (run #65)
- Latest stable release: v2026.4.10
- Last synced release:   v2026.4.10
- Result: NO NEW RELEASE — exiting

---

## 2026-04-11 — v2026.4.10 Full Sync

- New release: v2026.4.10 (2026-04-11, released 02:43 UTC)
- Previous synced release: v2026.4.9
- Categorization: RELEVANT (no breaking changes — Active Memory plugin, Codex/GPT-5 bundled provider, Teams message actions, exec-policy CLI, gateway commands.list RPC, per-provider allowPrivateNetwork, 126 security fixes)
- Template changes:
  - CHANGELOG.md: added v2026.4.10 section (Active Memory, Codex, Teams actions, exec-policy, gateway RPC, 126 security fixes)
  - workspace/TOOLS.md: updated security banner to v2026.4.10; added Active Memory plugin section; added Codex to provider table; added exec-policy CLI, Teams actions, gateway RPC, allowPrivateNetwork notes
  - deploy/UPGRADE.md: added v2026.4.10 known issues table (no breaking changes)
- Blog published:
  - EN: https://pulseagent.io/en/blog/openclaw-v2026-4-10-active-memory-codex-teams (postId: 81c3726f-1271-4a6b-8c81-178506cd210e, action: created)
  - ZH: https://pulseagent.io/blog/openclaw-v2026-4-10-active-memory-codex-teams (postId: 82384a46-6c35-40f0-b7ce-062f3d6abe5b, action: created)
- WeChat: ERROR — WeChat API error: invalid appsecret (40125, rid: 69d9bec7-4055c94f-379a6bed) — recurring issue, **action required: fix WeChat appsecret in PulseAgent dashboard**
- Release pointer: v2026.4.9 → v2026.4.10

---

## 2026-04-11 — Release Check (run #64)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-11 — Release Check (run #63)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-11 — Release Check (run #62)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #61)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #60)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #59)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #58)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #57)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #56)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #55)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #54)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #53)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #52)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #51)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #50)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #49)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #48)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #47)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #46)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #45)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #44)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #43)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #42)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #41)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #40)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-10 — Release Check (run #39)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-09 — Release Check (run #38)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting
- WeChat retry: FAILED — 40125 invalid appsecret (rid: 69d8305b-27bb1ae5-46f7c8f2) — **action required: fix WeChat appsecret in PulseAgent dashboard**

---

## 2026-04-09 — Release Check (run #37)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-09 — Release Check (run #36)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-09 — Release Check (run #35)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-09 — Release Check (run #34)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-09 — Release Check (run #33)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-09 — Release Check (run #32)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-09 — Release Check (run #31)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-09 — Release Check (run #30)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-09 — Release Check (run #29)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-09 — Release Check (run #28)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-09 — Release Check (run #27)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-09 — Release Check (run #26)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-09 — Release Check (run #25)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-09 — Release Check (run #24)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting

---

## 2026-04-09 — Release Check (run #23)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting
- Note: WeChat error 40125 (invalid appsecret) is a recurring credential issue — fix appsecret in PulseAgent dashboard to restore WeChat publishing

---

## 2026-04-09 — Release Check (run #22)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting
- WeChat status: recurring 40125 invalid appsecret — **action required: fix WeChat appsecret in PulseAgent dashboard**

---

## 2026-04-09 — Release Check (run #21)
- Latest stable release: v2026.4.9
- Last synced release:   v2026.4.9
- Result: NO NEW RELEASE — exiting
- WeChat status: recurring 40125 invalid appsecret — fix credentials in PulseAgent dashboard

---

## 2026-04-09 — v2026.4.9 WeChat Retry (run #20)

- Release already synced: v2026.4.9 (blogs published by prior run)
- EN blog: https://pulseagent.io/en/blog/openclaw-v2026-4-9-security-sessions-memory ✅
- ZH blog: https://pulseagent.io/en/blog/openclaw-v2026-4-9-security-sessions-memory ✅
- WeChat retry: FAILED — 40125 invalid appsecret (rid: 69d728ec-6ccc05f4-4bce607e) — **action required: fix WeChat appsecret in PulseAgent dashboard**

---

## 2026-04-09 — v2026.4.9 Full Sync

- New release: v2026.4.9 (2026-04-09, released 02:25 UTC)
- Previous synced release: v2026.4.8
- Categorization: BREAKING (workspace .env runtime-control vars blocked) + RELEVANT (SSRF browser bypass fix, exec event injection fix, plugin collision fix, basic-ftp CRLF fix, Memory REM backfill, Telegram session routing fix, OpenAI reasoning effort default high, agent cron timeout fix, Slack bearer/ACP/streaming fixes)
- Template changes:
  - CHANGELOG.md: added v2026.4.9 section (security, breaking change, new features, fixes)
  - workspace/TOOLS.md: updated security banner to v2026.4.9; added breaking .env var note; added OpenAI reasoning effort default, Ollama thinking, OpenRouter prefix, agent timeout, provider auth aliases notes; added Telegram session routing fix note
  - deploy/UPGRADE.md: added v2026.4.9 known issues table with breaking change migration
- Blog published:
  - EN: https://pulseagent.io/en/blog/openclaw-v2026-4-9-security-sessions-memory (postId: c3e559d1-7ac2-48e3-8bd9-44c261141a26, action: created)
  - ZH: https://pulseagent.io/en/blog/openclaw-v2026-4-9-security-sessions-memory (postId: c3e559d1-7ac2-48e3-8bd9-44c261141a26, action: updated)
- WeChat: ERROR — WeChat API error: invalid appsecret (40125, rid: 69d71c71-627586a4-4f3ed687) — recurring issue, fix WeChat appsecret in PulseAgent dashboard
- Release pointer: v2026.4.8 → v2026.4.9

## 2026-04-09 — Release Check (run #19)
- Latest stable release: v2026.4.8
- Last synced release:   v2026.4.8
- Result: NO NEW RELEASE — exiting

## 2026-04-09 — Release Check (run #18)
- Latest stable release: v2026.4.8
- Last synced release:   v2026.4.8
- Result: NO NEW RELEASE — exiting

## 2026-04-09 — Release Check (run #17)
- Latest stable release: v2026.4.8
- Last synced release:   v2026.4.8
- Result: NO NEW RELEASE — exiting

## 2026-04-08 — Release Check (run #16)
- Latest stable release: v2026.4.8
- Last synced release:   v2026.4.8
- Result: NO NEW RELEASE — exiting

## 2026-04-08 — Release Check (run #15)
- Latest stable release: v2026.4.8
- Last synced release:   v2026.4.8
- Result: NO NEW RELEASE — exiting

## 2026-04-08 — Release Check (run #14)
- Latest stable release: v2026.4.8
- Last synced release:   v2026.4.8
- Result: NO NEW RELEASE — exiting

## 2026-04-08 — v2026.4.8 Full Sync

- New release: v2026.4.8 (2026-04-08) — drafts existed, unpublished — published now
- Previous synced release: v2026.4.5
- Skipped: v2026.4.7 (superseded same-day by v2026.4.8)
- Categorization: RELEVANT (security: Critical, thinking blocks fix, Telegram fix, Slack proxy)
- Template changes:
  - deploy/config.sh.example: added COMPACTION_PROVIDER option (v2026.4.8+ pluggable compaction)
  - deploy/generate-config.sh: wire COMPACTION_PROVIDER into agents.defaults.compaction.provider
- Blog published:
  - EN: https://pulseagent.io/en/blog/openclaw-v2026-4-8-security-thinking-b2b (postId: 6c62d98d-130c-4ca3-9e92-6418adad3955, action: created)
  - ZH: https://pulseagent.io/blog/openclaw-v2026-4-8-security-thinking-b2b (postId: a2716819-f73c-4da0-aa5f-fb43ddc0cbee, action: created)
- WeChat: ERROR — WeChat API error: invalid appsecret (40125) — publish manually
- Release pointer: v2026.4.5 → v2026.4.8

## 2026-04-08 — Release Check (run #13)
- Latest stable release: v2026.4.8
- Last synced release:   v2026.4.8
- Result: NO NEW RELEASE — exiting

## 2026-04-08 — Release Check (run #12)
- Latest stable release: v2026.4.8
- Last synced release:   v2026.4.8
- Result: NO NEW RELEASE — exiting

## 2026-04-08 — Release Check (run #11)
- Latest stable release: v2026.4.8
- Last synced release:   v2026.4.8
- Result: NO NEW RELEASE — exiting

## 2026-04-08 — Release Check (run #10)
- Latest stable release: v2026.4.8
- Last synced release:   v2026.4.8
- Result: NO NEW RELEASE — exiting

## 2026-04-08 — Release Check (run #9)
- Latest stable release: v2026.4.8
- Last synced release:   v2026.4.8
- Result: NO NEW RELEASE — exiting

## 2026-04-08 — Release Check (run #8)
- Latest stable release: v2026.4.8
- Last synced release:   v2026.4.8
- Result: NO NEW RELEASE — exiting

## 2026-04-08 — v2026.4.8 Blog Publish (run #7 — channel stability focus)
- Latest stable release: v2026.4.8
- Last synced release:   v2026.4.8
- Classification: RELEVANT (7 fixes: Telegram sidecar, 10+ bundled channels, Slack proxy/token, exec reporting, plan tool)
- Blog published:
  - EN: https://pulseagent.io/en/blog/openclaw-v2026-4-8-channel-stability-slack-proxy (postId: 9982df54-732b-4f5a-a51c-19e74bcc281a, action: created)
  - ZH: https://pulseagent.io/en/blog/openclaw-v2026-4-8-channel-stability-slack-proxy (postId: 9982df54-732b-4f5a-a51c-19e74bcc281a, action: updated)
- WeChat: FAILED — 40125 invalid appsecret (rid: 69d65a4a-57b040e6-7184092e) — recurring issue, fix WeChat appsecret in PulseAgent dashboard
- Template: CHANGELOG.md created, workspace/TOOLS.md + deploy/UPGRADE.md updated with Slack proxy notes

## 2026-04-08 — Release Check (run #6)
- Latest stable release: v2026.4.8
- Last synced release:   v2026.4.8
- Result: NO NEW RELEASE — exiting

## 2026-04-08 — Release Check (run #5)
- Latest stable release: v2026.4.8
- Last synced release:   v2026.4.8
- Result: NO NEW RELEASE — exiting

## 2026-04-08 — Release Check (run #4)
- Latest stable release: v2026.4.8
- Last synced release:   v2026.4.8
- Result: NO NEW RELEASE — exiting

## 2026-04-08 — Release Check (run #3)
- Latest stable release: v2026.4.8
- Last synced release:   v2026.4.8
- Result: NO NEW RELEASE — exiting

## 2026-04-08 — Release Check
- Latest stable release: v2026.4.8
- Last synced release:   v2026.4.8
- Result: NO NEW RELEASE — exiting

## 2026-04-08 — v2026.4.8 Blog Re-publish (run #2)
- Previous run published to slug `openclaw-v2026-4-8-security-stability` — this run publishes revised/improved post
- EN blog: https://pulseagent.io/en/blog/openclaw-v2026-4-8-security-claude-thinking (postId: de954cdd-9298-43e3-b4a5-f4cd4589c0f3, action: created)
- ZH blog: https://pulseagent.io/en/blog/openclaw-v2026-4-8-security-claude-thinking (postId: de954cdd-9298-43e3-b4a5-f4cd4589c0f3, action: updated)
- WeChat: FAILED — server-side credential error (40125: invalid appsecret rid: 69d5f478-517f06f1-088a8b0b) — fix WeChat appsecret in PulseAgent dashboard
- workspace/TOOLS.md additions: security upgrade banner, Claude thinking blocks note, compaction provider config, Slack channel section with proxy support
- Template commit: af15f9d

## 2026-04-08 — v2026.4.8 Full Sync
- Previous release: v2026.4.7
- New release: v2026.4.8 (2026-04-08, released 05:14 UTC)
- Classification: RELEVANT (fixes-only — critical security: cross-origin redirect credential leak, base64 limits, exec gating; channel fixes: Telegram multi-account, Slack proxy/bot-token; Claude thinking-block preservation; provider updates)
- Changes adapted:
  - CHANGELOG.md: documented all security fixes, channel fixes, agent runtime improvements, provider updates
  - workspace/TOOLS.md: added xAI/Grok native endpoint note, Mistral reasoning_effort note, memory vector recall warning, Web Fetch HTTP/2 fix, Exa Search visibility note
  - deploy/UPGRADE.md: added v2026.4.8 known issues table (fixes-only, no breaking changes)
- Blog published:
  - EN: https://pulseagent.io/en/blog/openclaw-v2026-4-8-security-stability (postId: 014fef87-3a23-443f-8420-3e87cee0df55, action: created)
  - ZH: https://pulseagent.io/en/blog/openclaw-v2026-4-8-security-stability (postId: 014fef87-3a23-443f-8420-3e87cee0df55, action: updated)
- WeChat: FAILED — server-side credential error (40125: invalid appsecret rid: 69d5e5c8-6cfbaedf-69df929e) — same recurring issue, fix WeChat appsecret in PulseAgent dashboard
- Release pointer advanced: v2026.4.7 → v2026.4.8

## 2026-04-08 — Release Check (run #36)
- Latest stable release: v2026.4.7
- Last synced release:   v2026.4.7
- Result: NO NEW RELEASE — exiting

## 2026-04-08 — v2026.4.7 Full Sync
- Previous release: v2026.4.5
- New release: v2026.4.7 (2026-04-08, released 02:12 UTC)
- Classification: BREAKING (allowlist owner-only, env override blocks, gateway config write block) + RELEVANT (Webhook Ingress Plugin, `openclaw infer` hub, Memory/Wiki stack, Gemma 4, Arcee AI, session compaction checkpoints, Docker auto-bind)
- Changes adapted:
  - CHANGELOG.md: documented breaking changes, webhook plugin, infer hub, memory wiki, new providers, security
  - workspace/TOOLS.md: added Webhook Ingress Plugin section; added Gemma 4 + Arcee AI to provider table
  - deploy/UPGRADE.md: added v2026.4.7 known issues and migration notes
- Blog published:
  - EN: https://pulseagent.io/en/blog/openclaw-v2026-4-7 (postId: 4b5f9f2f-79f3-441c-913e-3696a85e1d80, action: created)
  - ZH: https://pulseagent.io/zh/blog/openclaw-v2026-4-7 (postId: 4b5f9f2f-79f3-441c-913e-3696a85e1d80, action: updated)
- WeChat: FAILED — server-side credential error (40125: invalid appsecret rid: 69d5c858-575e6000-2ac52806) — same issue as prior run, retry manually or fix WeChat appsecret in PulseAgent dashboard
- Release pointer advanced: v2026.4.5 → v2026.4.7

## 2026-04-08 — Release Check (run #35)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting

## 2026-04-08 — Release Check (run #34)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting

## 2026-04-08 — Release Check (run #33)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting

## 2026-04-07 — Release Check (run #32)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting

## 2026-04-07 — Release Check (run #31)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting

## 2026-04-07 — Release Check (run #30)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting

## 2026-04-07 — Release Check (run #29)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting

## 2026-04-07 — Release Check (run #28)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting

## 2026-04-07 — Release Check (run #27)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting

## 2026-04-07 — Release Check (run #26)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting

## 2026-04-07 — Release Check (run #25)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting

# Upstream Sync Log


## 2026-04-07 — Release Check (22nd run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting

## 2026-04-07 — Release Check (21st run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting

## 2026-04-07 — Release Check (20th run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting



## 2026-04-07 — Release Check (19th run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting



## 2026-04-07 — Release Check (18th run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting



## 2026-04-07 — Release Check (17th run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting



## 2026-04-07 — Release Check (16th run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting



## 2026-04-07 — Blog Publish v2026.4.5 (15th run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5 (draft existed, unpublished — published now)
- Result: PUBLISHED (drafts were prepared but never pushed)
- Blog EN: https://pulseagent.io/en/blog/openclaw-v2026-4-5-multilingual-providers-whatsapp (postId: 411c15f4-f6f0-431a-9452-9b6dec1313db, action: updated)
- Blog ZH: https://pulseagent.io/blog/openclaw-v2026-4-5-multilingual-providers-whatsapp (postId: bc1fce13-9804-48b0-b291-ed03c575adea, action: updated)
- WeChat: FAILED — WeChat API token error (40125: invalid appsecret rid: 69d485c4-1f3d7156-358a58cb) — server-side credential issue, retry manually
- Result: NO NEW RELEASE — exiting


## 2026-04-07 — Release Check (14th run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting


## 2026-04-07 — Release Check (13th run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting


## 2026-04-07 — Release Check (12th run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting


## 2026-04-06 — Release Check (11th run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting


## 2026-04-06 — Release Check (10th run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting


## 2026-04-06 — Release Check (9th run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting


## 2026-04-06 — Release Check (8th run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting


## 2026-04-06 — Release Check (7th run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting


## 2026-04-06 — Release Check (6th run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting


## 2026-04-06 — Release Check (5th run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting


## 2026-04-06 — Release Check (4th run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting

## 2026-04-06 — Release Check (3rd run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting

## 2026-04-06 — Release Check (2nd run)
- Latest stable release: v2026.4.5
- Last synced release:   v2026.4.5
- Result: NO NEW RELEASE — exiting

## 2026-04-06 — v2026.4.5 Full Sync
- Previous release: v2026.4.2
- New release: v2026.4.5 (2026-04-06)
- Classification: BREAKING (legacy config aliases removed) + RELEVANT (multilingual UI, 4 new providers, WhatsApp fix, Telegram fixes, security hardening)
- Changes adapted:
  - CHANGELOG.md: documented breaking changes, new providers, WhatsApp/Telegram fixes, security hardening
  - workspace/TOOLS.md: added WhatsApp `blockStreaming` note; expanded AI provider table (Qwen, MiniMax, Fireworks AI, StepFun)
  - deploy/UPGRADE.md: added v2026.4.5 known issues and migration steps for removed legacy config aliases
- Blog published:
  - EN: https://pulseagent.io/en/blog/openclaw-v2026-4-5-multilingual-providers-whatsapp (postId: 411c15f4-f6f0-431a-9452-9b6dec1313db)
  - ZH: https://pulseagent.io/blog/openclaw-v2026-4-5-multilingual-providers-whatsapp (postId: bc1fce13-9804-48b0-b291-ed03c575adea)
- WeChat: submitted (mediaId: _GzDFbp30Jdq7P2SfOYPykCUbu4X23qptvVHwSiBAxZmxDthef7y8xb271sy04a-, publishId: 2247483699)
- Release pointer advanced: v2026.4.2 → v2026.4.5

## 2026-04-06 — Release Check
- Checked latest stable release: v2026.4.2
- Last synced release: v2026.4.2
- Result: NO NEW RELEASE — exiting


## 2026-04-05 — Release Check
- Checked latest stable release: v2026.4.2
- Last synced release: v2026.4.2
- Result: NO NEW RELEASE — exiting

## 2026-04-03 16:41 UTC — Release check
- Checked latest stable release: v2026.4.2
- Last synced release: v2026.4.2
- Result: NO NEW RELEASE — exiting

## 2026-04-03
- New commits: 14 (RELEVANT: 2, WATCH: 3, SKIP: 9)
- Changes adapted:
  - Telegram per-account action discovery fix → added Multi-Account Telegram Setup guide to workspace/TOOLS.md
  - Mistral AI provider transport compat → added AI Model Provider reference table to workspace/TOOLS.md
  - Created CHANGELOG.md
- Blog published: drafts saved to .sync/blog-drafts/ (slug: openclaw-upstream-sync-2026-04-03)
  - NOTE: pulseagent-portal not accessible via current session auth — publish manually
  - Target URLs: https://pulseagent.io/blog/openclaw-upstream-sync-2026-04-03 (en) / https://pulseagent.io/zh/blog/openclaw-upstream-sync-2026-04-03 (zh)
- Sync SHA advanced: 0b4cdfc53e974c67fbe92dc497be57aaf1a44ccb → 6ac5806a3957d0fb31e8542ee4fc04315bfdad5d


## 2026-04-04 — Initial Setup
- Added `upstream` remote: https://github.com/openclaw/openclaw.git
- Baseline commit: `fb4127082aee18d955fb67cf64341de8db2a5d5a`
- Daily sync monitoring activated

## 2026-04-03 — No New Release
- Latest stable release: v2026.4.2 (unchanged)
- No action required

## 2026-04-11 — No New Release
- Latest stable release: v2026.4.10 (unchanged from last sync)
- No action required
## 2026-04-15 — No New Release
- Latest stable release: v2026.4.14 (unchanged from last sync)
- No action required
## 2026-04-16 — No New Release
- Latest stable release: v2026.4.14 (unchanged from last sync)
- No action required

## 2026-04-19T00:05:21Z — No-op check
- Last synced: v2026.4.15
- Latest stable: v2026.4.15
- Result: No new release. Exiting without update.

## 2026-04-19 — No New Release
- Last synced: v2026.4.15
- Latest stable: v2026.4.15 (April 16)
- Betas found: 2026.4.19-beta.1, 2026.4.19-beta.2 (skipped — pre-release)
- Result: No new stable release. Exiting without update.

## 2026-04-19T20:17:47Z — No-op check
- Last synced: v2026.4.15
- Latest stable: v2026.4.15 (April 16, 2026)
- Betas skipped: 2026.4.19-beta.1, 2026.4.19-beta.2
- Result: No new stable release. Exiting without update.

## 2026-04-21T00:00:00Z — No-op check
- Last synced: v2026.4.15
- Latest stable: v2026.4.15 (April 16, 2026)
- Betas skipped: v2026.4.19-beta.1, v2026.4.19-beta.2
- Result: No new stable release. Exiting without update.

## 2026-04-25T00:00:00Z — Sync v2026.4.23 → v2026.4.24

- Last synced: v2026.4.23
- Latest stable: v2026.4.24 (2026-04-25)
- Betas skipped: v2026.4.24-beta.1 through v2026.4.24-beta.5
- Result: **New stable release published**

### Categorization
| Change | Category |
|--------|----------|
| Google Meet bundled participant plugin | RELEVANT |
| Realtime voice AI (`openclaw_agent_consult`) | RELEVANT |
| DeepSeek V4 Flash as onboarding default | RELEVANT |
| WeCom channel source pinned | RELEVANT |
| Browser: coordinate clicks, 60s action budget, per-profile headless | RELEVANT |
| Gemini Live voice provider | RELEVANT |
| Google Meet conference records & artifacts | RELEVANT |
| OTEL observability spans | RELEVANT |
| BREAKING: tool-result middleware API change | RELEVANT (plugin authors) |
| Heartbeat injection fix (critical) | RELEVANT |
| WhatsApp media/voice/group fixes | RELEVANT |
| Telegram polling persistence + schema | RELEVANT |
| Slack thread/broadcast/approval fixes | RELEVANT |
| MCP Gateway owner-only tool policy | RELEVANT |
| DeepSeek V4 thinking-replay fix | RELEVANT |
| Browser profile lock recovery | RELEVANT |
| Scheduler overflow fix | RELEVANT |
| Session store rotation | RELEVANT |
| OpenCode Go catalog + Nix home manager | SKIP |
| Codex harness seams (internal) | WATCH |
| Node-LLAMA-CPP opt-in only | WATCH |

### Template Changes
- `README.md`: Updated "New" banner to v2026.4.24
- `README.zh-CN.md`: Added Chinese "最新" banner for v2026.4.24
- `CHANGELOG.md`: Added full v2026.4.24 entry (breaking change + 12 new features + 13 bug fixes)

### Blog Posts
| Lang | Title | URL | Status |
|------|-------|-----|--------|
| EN | OpenClaw 2026.4.24: Google Meet AI, Realtime Voice & DeepSeek V4 Flash Default | https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-default | published |
| ZH | OpenClaw 2026.4.24：Google Meet AI参会、实时语音与DeepSeek V4 Flash默认模型 | https://pulseagent.io/en/blog/openclaw-v2026-4-24-google-meet-voice-deepseek-zh | published |

### WeChat
**Status**: FAILED — `WeChat API error: 40125 invalid appsecret` (same as previous cycle)
**Action required**: Check WeChat Official Account appsecret in PulseAgent platform settings and re-publish manually via the saved draft at `.sync/blog-drafts/openclaw-v2026.4.24-zh.json`

---

## 2026-04-26 — No new release / WeChat retry

**Checked**: v2026.4.24 == last-release → no new release to process.

**WeChat retry**: Re-attempted publish of saved draft `openclaw-v2026.4.24-zh.json`.
**Result**: FAILED again — `WeChat API error: WeChat token error: 40125 invalid appsecret rid: 69ed8f80-746befb3-1706ae38`

**Root cause**: Invalid/expired WeChat Official Account appsecret configured in PulseAgent platform. This is a server-side configuration issue, not a transient error.

**Required action**: Update the WeChat Official Account appsecret in PulseAgent platform settings, then manually re-publish the saved draft at `.sync/blog-drafts/openclaw-v2026.4.24-zh.json`.