# Changelog

All notable changes to the B2B SDR Agent Template are documented here.

Changes sourced from upstream (openclaw/openclaw) are labeled with the originating commit SHA.

---

## [Unreleased]

## 2026-04-13 — OpenClaw v2026.4.12 upstream sync

### Security (Upgrade Recommended)

- **Empty approver list authorization bypass fixed**
  Authorization checks now require at least one configured approver; a check that silently passed on an empty approver list has been patched.
  Upstream: v2026.4.12

- **busybox/toybox removed from safe interpreter bins**
  Both `busybox` and `toybox` are removed from the safe binary allowlist. Sandboxed exec sessions that relied on these for shell escapes are now correctly blocked.
  Upstream: v2026.4.12

- **Shell-wrapper detection broadened; env-argv injection blocked**
  Shell wrappers are detected more broadly; `env`-based argv injection into exec sessions is explicitly denied.
  Upstream: v2026.4.12

### New Features

- **LM Studio provider — self-hosted models with runtime discovery** *(RELEVANT — data-residency)*
  A bundled LM Studio provider enables fully local, self-hosted OpenAI-compatible models with guided setup, runtime model discovery, stream preloading, and memory-search embeddings. Configure via `models.providers.lm-studio.*`.
  B2B SDR relevance: teams with data-residency requirements (EU manufacturing, government export, China mainland) can now run the SDR agent entirely on-premise — no cloud API calls required for conversation handling or lead context recall.
  Upstream: v2026.4.12

- **Active Memory plugin — stabilized** *(high SDR relevance)*
  The Active Memory plugin introduced in v2026.4.10 is now stabilized with improved QMD recall defaults, better telemetry, and Unicode support for wiki slugs and contradiction clustering. See v2026.4.10 entry for full details.
  Upstream: v2026.4.12

- **macOS/Talk — local MLX speech provider** *(Experimental)*
  Experimental local MLX speech provider for Talk Mode on Apple Silicon with explicit provider selection, local utterance playback, interruption handling, and system-voice fallback.
  Upstream: v2026.4.12

### Channel Improvements

- **WhatsApp: media fallback + drop-proof orphaned messages**
  When `mediaUrl` is empty but `mediaUrls` is populated, OpenClaw now falls back to the first entry. Orphaned messages sent while the previous message was being processed are now carried forward into the next processing cycle instead of being silently dropped.
  B2B SDR relevance: product catalog attachments and voice messages sent mid-sequence no longer go missing on WhatsApp.
  Upstream: v2026.4.12

- **Telegram: approval callbacks deadlock fixed**
  Approval button callbacks now route to a dedicated processing lane, preventing deadlocks during high-volume SDR sequences.
  Upstream: v2026.4.12

- **Discord: stale heartbeat timers cleared**
  Stale heartbeat timers are now cleared before reconnect, preventing process crashes in long-running gateway deployments.
  Upstream: v2026.4.12

- **Matrix: mention gating + display name acceptance**
  `requireMention` now correctly gates messages while accepting visible display names from non-OpenClaw clients.
  Upstream: v2026.4.12

### Fixed

- **Dreaming reliability**
  Waiting-entry recency ordering stabilized; transient narrative cleanup hardened with retry logic; own narrative transcript re-ingestion fixed.
  Upstream: v2026.4.12

- **WebSocket keepalive tick broadcast**
  Tick broadcasts are no longer marked as discardable, preventing client disconnects during long agent runs on slow/backpressured connections.
  Upstream: v2026.4.12

---

## 2026-04-12 — OpenClaw v2026.4.11 upstream sync

### New Features

- **Microsoft Teams — delegated OAuth + reactions** *(RELEVANT)*
  Teams now supports delegated OAuth for sending reactions and messages on behalf of the assigned rep's identity. Adds reaction listing, Graph pagination, and reaction support across DMs and channels.
  B2B SDR relevance: the agent can now react/pin key lead-update messages in Teams channels and send as the rep, not as the generic bot identity.
  Upstream: v2026.4.11

- **Plugin manifest activation + setup descriptors**
  Plugin manifests declare `activation` and `setup` descriptors so plugins self-describe required auth steps, pairing flows, and config fields. Removes the need for core special-cases per plugin, simplifying third-party SDR plugin deployment.
  Upstream: v2026.4.11

- **Dreaming/memory-wiki: ChatGPT import ingestion**
  Existing ChatGPT conversation exports can be ingested into the memory wiki. New "Imported Insights" and "Memory Palace" diary subtabs allow direct inspection of imported source chats, compiled wiki pages, and full source pages.
  B2B SDR relevance: historical sales conversations from ChatGPT can be migrated into the agent's memory without manual re-entry.
  Upstream: v2026.4.11

- **Control UI: rich webchat bubbles + `[embed ...]` tag**
  Assistant media, reply, and voice directives render as structured chat bubbles. New `[embed ...]` rich output tag available with configurable external URL gating.
  Upstream: v2026.4.11

### Channel Improvements

- **Feishu: document comment sessions** *(RELEVANT — China market)*
  Document comment sessions now include richer context parsing, comment reactions, and typing feedback — document-thread conversations behave like live chat.
  B2B SDR relevance: sales proposals shared as Feishu documents can now have inline SDR agent discussion threads, supporting common China B2B sales workflows.
  Upstream: v2026.4.11

- **Microsoft Teams: video generation + typed provider options**
  Video generation tool adds URL-only asset delivery, typed `providerOptions`, reference audio inputs, per-asset role hints, and adaptive aspect-ratio support. Seedance 2.0 references added to the bundled fal provider.
  Upstream: v2026.4.11

### Fixed

- **Ollama: model metadata caching**
  `/api/show` context-window and capability metadata is now cached during model discovery, eliminating repeated API calls on picker refreshes. Cache invalidates on digest changes.
  Upstream: v2026.4.11

- **QA/parity: GPT-5.4 vs Opus 4.6 agentic parity report**
  New parity gate with shared scenario coverage checks, stricter evidence heuristics, and skipped-scenario accounting for maintainer review.
  Upstream: v2026.4.11

---

## 2026-04-11 — OpenClaw v2026.4.10 upstream sync

### New Features

- **Active Memory Plugin** *(Opt-in — high SDR relevance)*
  New optional plugin that runs a dedicated memory sub-agent right before each main reply. It automatically surfaces relevant preferences, past context, and lead details from the agent's memory store without requiring users to manually invoke memory commands. Supports configurable message/recent/full-context modes, live `/verbose` inspection, and opt-in transcript persistence for debugging. Docs: https://docs.openclaw.ai/concepts/active-memory
  B2B SDR relevance: eliminates the need to manually say "remember this" or "search memory" — the agent now proactively pulls in lead history, deal stage, and communication preferences before every reply, dramatically improving continuity across long-running sales threads.
  Upstream: v2026.4.10

- **Codex / GPT-5 family — bundled Codex provider**
  A new bundled `codex` provider handles all `codex/gpt-*` model routes with Codex-managed auth, native thread management, model discovery, and automatic conversation compaction. The existing `openai/gpt-*` path continues to use the standard OpenAI provider. If you were routing GPT-5 traffic through the `openai` provider manually, switch model IDs to `codex/gpt-5` for optimal performance and managed auth.
  Upstream: v2026.4.10

- **Microsoft Teams — message actions**
  Five new Teams actions are now available: `pin`, `unpin`, `read` (mark as read), `react` (add emoji reaction), and `listReactions`. Enables richer bi-directional engagement in Teams-based sales workflows.
  B2B SDR relevance: pin confirmed order summaries or SLA commitments directly in Teams threads; use reactions to acknowledge messages without breaking conversation flow.
  Upstream: v2026.4.10

- **CLI: `openclaw exec-policy` command**
  New local command for managing exec approval policy. Subcommands: `show` (view current policy), `preset` (apply a named policy preset), `set` (granular key-value overrides). Includes rollback safety and sync conflict detection to prevent policy drift between config and the local approvals file.
  Upstream: v2026.4.10

- **Gateway: `commands.list` RPC**
  Remote gateway clients can now discover all runtime-native, text, skill, and plugin commands via a single RPC call. Returns surface-aware names and serialized argument metadata. Useful for building external dashboards or automation that needs to enumerate available agent capabilities dynamically.
  Upstream: v2026.4.10

- **Per-provider private network opt-in**
  Add `models.providers.*.request.allowPrivateNetwork: true` to trusted self-hosted OpenAI-compatible endpoints. Keeps private-network access scoped to model request surfaces only — does not affect browser or fetch tools.
  Upstream: v2026.4.10

- **macOS/Talk — local MLX speech provider** *(Experimental)*
  Experimental local MLX speech backend for Talk Mode on Apple Silicon. Requires explicit provider selection. Falls back to system voices if MLX is unavailable.
  Upstream: v2026.4.10

### Fixed

- **Security: 126 fixes** covering security boundary enforcement across multiple channels, browser/sandbox hardening, OpenAI/Codex provider stability, WhatsApp media handling, Microsoft Teams restoration, gateway stability, conversation binding normalization, iMessage self-chat distinction, Matrix account scoping, Telegram security validation, agent timeout extensions, Windows execution settling, cron scheduling corrections, session model preservation, and numerous other platform and core system refinements.
  Upstream: v2026.4.10

- **Docs i18n: translation pipeline hardened**
  Chunked raw doc translation, rejects truncated tagged outputs, avoids ambiguous body-only wrapper unwrapping, and recovers from terminated translation sessions without changing the default model path.
  Upstream: v2026.4.10

---

## 2026-04-09 — OpenClaw v2026.4.9 upstream sync

### Security (Critical — Upgrade Recommended)

- **Workspace `.env` runtime-control env vars blocked** *(BREAKING)*
  Runtime-control variables, browser-control override flags, and skip-server env vars in untrusted workspace `.env` files are now rejected at startup. If your deployment uses `.env` to override OpenClaw runtime behavior (e.g. `OPENCLAW_GATEWAY_PORT`, `OPENCLAW_SKIP_*`, `OPENCLAW_BROWSER_*`), those overrides are silently ignored in v2026.4.9. Move them into `openclaw.json` under the appropriate config keys or set them as real system environment variables before the daemon starts.
  Upstream: v2026.4.9

- **SSRF bypass via interaction-driven navigation fixed**
  Blocked-destination safety checks are now re-run after click, evaluate, and hook-triggered navigations in the browser tool. Previously, an agent or adversarial page could bypass the SSRF quarantine by triggering a main-frame navigation through a simulated click.
  Upstream: v2026.4.9

- **Remote node exec events marked untrusted**
  `exec.started`, `exec.finished`, and `exec.denied` summaries from remote nodes are now flagged as untrusted system events. Command/output/reason text from remote nodes is sanitized, preventing injection of trusted-System content via crafted exec summaries.
  Upstream: v2026.4.9

- **Plugin onboarding auth-choice collision prevention**
  Untrusted workspace plugins can no longer register provider auth-choice IDs that collide with bundled provider IDs during non-interactive onboarding.
  Upstream: v2026.4.9

- **`basic-ftp` CRLF injection patched**
  Forced `basic-ftp` to `5.2.1` which includes the upstream CRLF command-injection fix. Also bumped Hono and `@hono/node-server` in production dependency paths.
  Upstream: v2026.4.9

### New Features

- **Memory & Dreaming — REM backfill lane**
  New `rem-harness --path` flag enables historical daily-note replay into the Dreams stack without a second memory stack. Includes live short-term promotion so old diary entries can be back-filled into the agent's grounded long-term memory.
  B2B SDR relevance: long-running SDR agents accumulating months of interaction history can now backfill older notes into Dreams for persistent lead context without restarting from scratch.
  Upstream: v2026.4.9

- **Structured diary view**
  Diary now shows a timeline with backfill/reset controls, traceable dreaming summaries, and a grounded Scene lane with promotion hints. Useful for auditing what your agent "remembers" about a lead over time.
  Upstream: v2026.4.9

- **Provider auth aliases (`providerAuthAliases`)**
  Provider manifests now support `providerAuthAliases`, enabling provider variants to share environment variables, auth profiles, config-backed authentication, and API-key onboarding — without core-specific integration per variant. Reduces duplication when configuring multiple OpenAI-compatible or Anthropic-compatible endpoints.
  Upstream: v2026.4.9

### Fixed

#### Session & Routing
- **Telegram/Discord route preservation on multi-session announce**
  `sessions_send` follow-up messages no longer hijack delivery from established Telegram or Discord external routes. Previously, inter-session announce traffic could re-route a reply that should have gone to a customer's Telegram thread back through an internal channel.
  Upstream: v2026.4.9

- **`/reset` and `/new` clear auto-fallback model overrides**
  Auto-pinned model overrides from fallback chains are cleared on `/reset` and `/new`. Explicit user model selections are preserved. Legacy sessions created before override-source tracking are also retroactively handled.
  Upstream: v2026.4.9

- **Session history guard on fast session switches**
  Stale session-history reloads during rapid session switches are now guarded, preventing a mismatch between the selected session and the rendered transcript.
  Upstream: v2026.4.9

#### Channels
- **Slack: bearer auth preserved across same-origin `files.slack.com` redirects**
  `url_private_download` image attachments now load correctly. The fix preserves bearer auth on same-origin Slack CDN redirects while still stripping it on cross-origin hops (security behavior maintained).
  Upstream: v2026.4.9

- **Slack: ACP block replies treated as delivered output**
  Slack ACP block replies no longer trigger a second fallback-text send. Previously, the agent would send duplicate plain-text replies after Slack already rendered the block.
  Upstream: v2026.4.9

- **Slack: partial-streaming final-answer suppression fixed**
  Stale preview text from a failed stream finalization no longer suppresses the final answer in Slack channels.
  Upstream: v2026.4.9

- **Chat control token leakage suppressed**
  Internal `ANNOUNCE_SKIP` / `REPLY_SKIP` tokens no longer appear in user-facing Slack, Telegram, or Discord messages, either live or in history sanitization.
  Upstream: v2026.4.9

- **Auto-reply: `NO_REPLY` sentinel stripping**
  Leading `NO_REPLY` tokens are stripped before reply normalization and ACP-visible streaming. Substantive `NO_REPLY …` text (e.g. where the phrase appears in a customer message) is preserved.
  Upstream: v2026.4.9

- **Matrix: wait for sync readiness before startup success**
  The gateway now waits for Matrix sync to be ready before marking startup as complete. Matrix background handler failures are contained; fatal Matrix sync stops route through channel-level restart handling instead of crashing the gateway.
  Upstream: v2026.4.9

- **Matrix doctor: legacy DM policy migration**
  `openclaw doctor --fix` migrates `channels.matrix.dm.policy: "trusted"` to compatible `allowlist`-based DM policies, preserving explicit `allowFrom` boundaries. Empty legacy configs default to `pairing`.
  Upstream: v2026.4.9

#### Providers & Models
- **OpenAI: reasoning effort defaults to `high`**
  When no `reasoning_effort` is specified, OpenAI Responses, WebSocket, and compatible completions transports now default to `high`. Per-run explicit reasoning levels are still honored. Monitor token usage if you rely on the previous behavior (which was no reasoning effort sent).
  Upstream: v2026.4.9

- **Ollama: thinking output when `/think` is active**
  Ollama models using the native `api: "ollama"` path now display thinking output when `/think` is set to a non-off level. Useful for local model deployments with reasoning models.
  Upstream: v2026.4.9

- **OpenRouter: provider-qualified model refs preserved**
  Model IDs containing slashes (e.g. `anthropic/claude-3-5-sonnet`) are now submitted with the `openrouter/` prefix intact so they remain allowlist-compatible.
  Upstream: v2026.4.9

- **Z.ai error classification**
  Z.ai vendor codes `1311` (billing) and `1113` (auth) — including long wrapped `1311` payloads — are now correctly classified instead of falling through to generic failover handling.
  Upstream: v2026.4.9

#### Agent Runtime
- **Agent timeout inherits `agents.defaults.timeoutSeconds`**
  LLM idle timeout now inherits `agents.defaults.timeoutSeconds` when configured. The unconfigured idle watchdog is disabled for cron runs. Idle-timeout errors now point at `agents.defaults.llm.idleTimeoutSeconds` for accurate config guidance. This matters for long-running SDR cron agents that were hitting spurious idle timeouts.
  Upstream: v2026.4.9

- **Reply preflight uses active runtime snapshot**
  Queued reply runs now use the active runtime snapshot; `SecretRef`s are resolved before preflight helpers run. Gateway OAuth reauth failures are surfaced to users with exact `openclaw doctor` reauth commands.
  Upstream: v2026.4.9

---

## 2026-04-08 — OpenClaw v2026.4.8 upstream sync

### Security (Critical — Upgrade Recommended)

- **Cross-origin redirect secret leakage fixed**
  307/308 redirects now drop request bodies and headers by default. Previously, auth tokens and API keys could leak to redirect targets via SSRF-guarded fetches. No config change required — protection is automatic after upgrade.
  Upstream: v2026.4.8

- **`/allowlist` commands require owner on channel resolution**
  In v2026.4.7 the owner check was enforced before channel resolution; now it's enforced before *and* during. Closes a narrow window where allowlist mutations could bypass the guard during fast concurrent requests.
  Upstream: v2026.4.8

- **Base64 byte limits before decode**
  Teams, Signal, QQ, and image-tool payloads now enforce byte-size caps before base64 decoding, preventing memory exhaustion from oversized payloads.
  Upstream: v2026.4.8

- **Untrusted event marking**
  Background summaries, ACP relay payloads, and wake-hook events are now tagged as untrusted system events and excluded from elevated execution contexts.
  Upstream: v2026.4.8

- **Windows cmd.exe approval gating strengthened**
  Env-assignment carriers inside cmd.exe wrappers are now caught by the approval gate even when ambient execution defaults are elevated.
  Upstream: v2026.4.8

### Fixed

#### Channels
- **Telegram/Setup**: Module import failures on packaged installs resolved — setup contracts load from bundled sidecars instead of missing dist files. Multi-account setups no longer break after `npm install -g`.
- **Slack**: WebSocket Socket Mode connections now respect HTTP(S) proxy settings and `NO_PROXY` exclusions — required for corporate proxy deployments.
- **Slack/Actions**: Bot token resolution fixed for `SecretRef`-backed tokens after config re-reads (e.g., `openclaw gateway restart`).
- **Discord/Events**: Cover image accepts URLs or local PNG/JPG/GIF paths with proper validation.
- **Matrix**: Multi-paragraph and loose-list rendering repaired — content no longer detaches from list items in formatted messages.
- **Telegram/Doctor**: Access-control fallback during multi-account normalization restored; inherited allowlists are no longer lost after `openclaw doctor`.
- **BlueBubbles**: Explicit private-network opt-out now respected for loopback and private server URLs.

#### Agent Runtime
- **Claude thinking blocks preserved** for Opus 4.5+, Sonnet 4.5+, and Claude 4-family models. Interleaved thinking was being stripped before forwarding — this caused reasoning regressions on complex SDR tasks with those models.
- **Context overflow recovery** now combines oversized and aggregate tool-result recovery in a single pass with a total-context backstop (prevents runaway token accumulation on long SDR conversation threads).
- **Claude CLI**: Nested API errors from structured output now surface properly instead of showing opaque CLI failure messages.

#### Infrastructure & Gateway
- **Gateway sessions — compaction checkpoints**: Pre-compaction state is now checkpointed with UI branch/restore — you can revert to the conversation state before compaction if a summary loses context.
- **Compaction provider**: Pluggable via `agents.defaults.compaction.provider` — swap in a different model for compaction without changing your main session model.
- **HTTP clients**: In-flight chat-completions aborted when client disconnects (prevents orphaned API calls on mobile reconnects).
- **Model selection**: Explicitly selected session models now resolve separately from runtime fallback chains — no more unexpected model switching mid-session.
- **Cron jobs**: `jobId` now loaded from on-disk store when missing, fixing "unknown cron job id" errors on gateway restart.

#### Providers
- **xAI/Grok**: `api.grok.x.ai` recognized as native endpoint; legacy `x_search` auth path maintained.
- **Mistral**: `reasoning_effort` sent for Mistral Small 4 with thinking-level mapping.
- **Ollama**: Vision capability auto-detected from API responses; streaming routed to correct endpoint (was defaulting to first configured instance).
- **Google Gemma**: Explicit thinking-off semantics preserved while reasoning support enabled in compatibility wrappers.
- **OpenAI TTS / Groq**: Groq endpoints now receive `wav` format; explicit `responseFormat` overrides honored.

#### Tools
- **Web Fetch**: HTTP/2 disabled for undici 8.0 compatibility (`allowH2: false`) — fixes connection errors on servers running Node 22+ with updated undici.
- **Exa Search**: Now shown in onboarding and provider pickers — was hidden from setup UI despite being a supported provider.
- **Memory Vector Recall**: Explicit warning when `sqlite-vec` is unavailable or writes are degraded (instead of silent fallback).
- **Memory Dreaming**: Config reads/writes now target the selected memory slot plugin instead of always targeting `memory-core`.

#### UI
- **Control UI light mode**: Scrollbar thumbs now visible in WebKit on light backgrounds.
- **iOS/Apple Watch**: Approval recovery works while iPhone is locked/backgrounded.
- **DNS pinning**: Skipped when trusted env-proxy mode is active — allows proxy-only sandboxes to resolve hosts through trusted proxies.

## 2026-04-08 — v3.6.0

### Added
- **Graphify Knowledge Graph** — Sales intelligence powered by [graphify](https://github.com/safishamsi/graphify)
  Build queryable knowledge graphs from product catalogs, customer conversations, and
  market research. Cherry-picked and adapted for B2B SDR context:
  - Product catalog graph → cross-sell paths, product families, spec relationships
  - Customer intelligence graph → buying patterns, referral paths, stalled lead recovery
  - Market research graph → competitive landscape, expansion opportunities
  - Runtime query via `python3 -m graphify query "topic"` (BFS/DFS traversal)
  - Interactive HTML visualization for owner dashboard
  - New skill: `skills/graphify/SKILL.md`
  - Deploy: auto-installs Python + graphifyy, auto-uploads all local skills
  - Added to `SKILLS_RESEARCH` in skill profiles (`full` profile)

### Changed
- **Operator Bilingual Mode now opt-in** — disabled by default, enable via
  `operator_bilingual: true` in IDENTITY.md. Prevents unexpected self-chat messages
  for operators who don't need Chinese translation.

### Deployment
- `deploy.sh` now auto-uploads all local skills from `skills/` directory
- `deploy.sh` Step 3b: auto-installs Python3 + graphify on target server

---

## 2026-04-08 — OpenClaw v2026.4.7 upstream sync

### Breaking Changes

- **`/allowlist` commands now require owner authorization**
  `/allowlist add` and `/allowlist remove` previously could be issued by any user. They now require owner-level access. Update your admin flows if you delegated allowlist management to non-owner accounts.
  Upstream: v2026.4.7

- **Dangerous environment overrides now blocked at model layer**
  Model-facing tool calls can no longer override Java, Rust, Cargo, Git, Kubernetes, or cloud credential environment variables. If your workflows inject env vars through model instructions, migrate to explicit workspace config or deploy scripts.
  Upstream: v2026.4.7

- **`gateway config.apply` / `config.patch` writes blocked from model**
  AI cannot modify gateway config at runtime via these calls. This prevents prompt-injection-based config changes. Existing automation that patches config via the model layer must migrate to direct API calls with human approval.
  Upstream: v2026.4.7

### Added

- **Webhook Ingress Plugin** — inbound automation drives TaskFlows via shared-secret endpoints
  External systems (CRMs, zapier, n8n, custom webhooks) can now POST to OpenClaw and trigger or advance TaskFlows directly. This is the cleanest way to implement inbound-lead-to-SDR-flow automation: new lead in CRM → webhook → SDR agent starts outreach sequence.

  ```yaml
  # workspace config
  plugins:
    webhook-ingress:
      enabled: true
      secret: "{{WEBHOOK_SECRET}}"    # shared secret for HMAC validation
      endpoint: "/webhooks/crm"       # path exposed by the gateway
  ```

  Sample payload to start a TaskFlow:
  ```json
  {
    "event": "lead.created",
    "flow": "outreach-sequence",
    "data": { "name": "Li Wei", "company": "Shenzhen MFG Co", "phone": "+86..." }
  }
  ```
  Upstream: v2026.4.7

- **`openclaw infer` CLI Hub** — first-class provider-backed inference
  New top-level command for running inference tasks outside of conversation context: model completions, media generation, web lookups, and embeddings. Useful for batch processing leads or generating personalized outreach copy at scale.

  ```bash
  openclaw infer model --prompt "Draft a cold outreach message for Li Wei at Shenzhen MFG" \
    --provider anthropic --model claude-sonnet-4-6
  openclaw infer media image --prompt "Product catalog cover" --provider gemini
  ```
  Upstream: v2026.4.7

- **Memory/Wiki stack restored** — structured claims, evidence fields, freshness-weighted search
  The bundled memory-wiki stack is back with meaningful upgrades: claim/evidence structure, contradiction clustering, and freshness weighting. For SDR use: store verified facts about leads (budget signals, authority contacts, pain points) with evidence links. Freshness weighting ensures recent intel ranks higher than stale data.
  Upstream: v2026.4.7

- **New AI providers: Gemma 4 (Google), Arcee AI**
  Two new bundled providers. Gemma 4 supports `thinkingOff` semantics for faster, non-reasoning responses — good for high-volume first-touch outreach. Arcee AI includes the Trinity catalog, a curated set of task-specialized models. Added to `workspace/TOOLS.md` provider table.
  Upstream: v2026.4.7

- **Session compaction checkpoints + branch/restore UI**
  Sessions UI now shows compaction checkpoints. You can branch from any checkpoint (useful when a long sales conversation goes off-track) or restore pre-compaction state for audit/review. No config needed — automatic.
  Upstream: v2026.4.7

- **Pluggable compaction provider registry**
  Plugins can now replace the built-in context summarization pipeline. Enables custom summarization strategies (e.g., preserve all price quotes verbatim while compacting small talk).
  Upstream: v2026.4.7

### Fixed

- **HTTP requests aborted on client disconnect** — zombie sessions no longer hold resources when a channel disconnects mid-conversation. Improves stability on mobile channels (WhatsApp, Telegram) where connections drop frequently.
  Upstream: v2026.4.7

- **Docker/Podman auto-binding to `0.0.0.0`** — gateway now auto-binds to all interfaces inside containers. No manual `--bind` flag needed. Simplifies `docker run` and Compose deployments.
  Upstream: v2026.4.7

- **Prompt-cache runtime context exposure** — prompt cache statistics now surfaced to context engines. Helps diagnose unexpected API costs or latency spikes by showing cache hit/miss at runtime.
  Upstream: v2026.4.7

- **Ollama vision capability auto-detected** — no longer need to manually declare `vision: true` for Ollama vision models; capability is detected from API responses.
  Upstream: v2026.4.7

### Security

- Media byte limits enforced before base64 decode on Teams, Signal, and QQ Bot channels — prevents memory exhaustion via crafted media payloads.
- File upload URLs validated against HTTPS + Microsoft/SharePoint host allowlists — prevents SSRF via document upload.
- Cross-origin redirect body stripping for POST payloads — prevents credential leakage on redirects.
- Private-network blocking for main-frame document redirects — closes redirect-based SSRF vector.
- Workspace-only filesystem constraint enforced for document uploads.
  Upstream: v2026.4.7

### Documentation
- Updated `workspace/TOOLS.md`: Webhook Ingress Plugin section, expanded AI provider table (Gemma 4, Arcee AI)
- Updated `deploy/UPGRADE.md`: v2026.4.7 security breaking changes and migration notes

---

## 2026-04-06 — OpenClaw v2026.4.5 upstream sync

### Breaking Changes (run `openclaw doctor --fix`)
- **Legacy config aliases removed** — The following keys are no longer recognized at load time:
  - `talk.voiceId` / `talk.apiKey` → use canonical `voice.*` paths
  - `agents.*.sandbox.perSession` → use `sandbox.*` canonical paths
  - `browser.ssrfPolicy.allowPrivateNetwork`
  - `hooks.internal.handlers`
  - Channel/group/room `allow` toggles
  
  Run `openclaw doctor --fix` to auto-migrate. Backward compat shims remain active during the transition period.

### Fixed
- **WhatsApp: `blockStreaming` config option restored**
  The `blockStreaming` option (disables streaming responses on WhatsApp) was inadvertently removed in a prior release. Now restored. No config change needed — existing `blockStreaming: true` configs will work again.
  Upstream: v2026.4.5

- **Telegram: model picker checks and HTML formatting restored**
  Non-default model confirmations now correctly show the model name in HTML-formatted messages. DM voice-note transcription restored. Reaction persistence fixed across gateway restarts.
  Upstream: v2026.4.5

- **Security: plugin allowlists and `/allowlist` access controls hardened**
  Plugin-only tool allowlists are now properly preserved between restarts. `/allowlist add` and `/allowlist remove` now require owner access. Canvas bridge actions require exact normalized URL matches.
  Upstream: v2026.4.5

### Added
- **Multilingual Control UI (12 languages)**
  The OpenClaw control dashboard and mobile UI are now localized for Simplified Chinese, Traditional Chinese, Brazilian Portuguese, German, Spanish, Japanese, Korean, French, Turkish, Indonesian, Polish, and Ukrainian. Operators in China, Japan, Korea, and LATAM can now manage the SDR agent in their native language.
  Upstream: v2026.4.5

- **New AI providers: Qwen, Fireworks AI, StepFun, MiniMax**
  Four new bundled providers are now available as drop-in LLM backends. Qwen and MiniMax are particularly relevant for China-based deployments. Add to `workspace/TOOLS.md` provider table.
  Upstream: v2026.4.5

- **`openclaw status --verbose`** — New diagnostic flag showing prompt cache reuse statistics. Useful for debugging latency or unexpected API costs.
  Upstream: v2026.4.5

- **`openclaw plugins install --force`** — Allows replacing an existing installed plugin without manual removal. Useful for development workflows.
  Upstream: v2026.4.5

### Documentation
- Updated `workspace/TOOLS.md`: WhatsApp `blockStreaming` note, expanded AI provider table (Qwen, Fireworks, StepFun, MiniMax)
- Updated `deploy/UPGRADE.md`: v2026.4.5 breaking changes and migration steps

## 2026-04-05 — v3.4.0

### Added
- **Operator Bilingual Mode** — English for customers, Chinese self-chat sync for operators
  Non-English-speaking operators can now run a global English-facing SDR without needing
  to read English. The agent replies to customers in English and immediately sends a
  Chinese translation to itself via WhatsApp self-chat. Operators read Chinese in their
  "Message to myself" channel; customers only ever see English.

  How it works:
  - Customer sends any language → Agent always replies in English
  - After each English reply → Agent silently sends Chinese translation via self-chat
  - Owner reports (Pipeline daily, quote approvals, notifications) → always Chinese
  - No hardcoded numbers, no extra config — works with `selfChatMode: true` (default)

  Updated files: `workspace/AGENTS.md`, `skills/sdr-humanizer/SKILL.md`

## 2026-04-03

### Fixed
- **Telegram: per-account action configuration now correctly applied during discovery**
  If you run multiple Telegram bots (e.g., one per market), each account's `actions` block
  (reactions, polls, inline buttons) is now independently honored. Previously, only the
  top-level channel config was evaluated regardless of `accountId`.
  Upstream: `fb8048a188e5` — "fix: honor telegram action discovery account config"

- **Mistral AI provider: full transport compatibility**
  OpenClaw now correctly handles Mistral's API quirks when using Mistral as the LLM backend:
  - Uses `max_tokens` instead of `max_completion_tokens`
  - Suppresses unsupported OpenAI-specific params (`store`, `reasoning_effort`)
  - Applies automatically for `provider: mistral` and any custom provider whose `baseUrl`
    points to `api.mistral.ai`
  Upstream: `6ac5806a3957` — "fix(providers): honor mistral transport compat (#60405)"

### Documentation
- Added Multi-Account Telegram Setup guide to `workspace/TOOLS.md`
- Added AI Model Provider reference table (Claude, OpenAI, Mistral, Groq) to `workspace/TOOLS.md`
