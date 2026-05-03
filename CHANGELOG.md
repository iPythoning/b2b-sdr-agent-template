# Changelog

All notable changes to the B2B SDR Agent Template are documented here.

Changes sourced from upstream (openclaw/openclaw) are labeled with the originating commit SHA.

---

## [Unreleased]

## 2026-05-02 — OpenClaw v2026.5.2 upstream sync

### New Features

- **ClawHub: Plugin management with diagnostics and install records**
  ClawHub's plugin management layer expands with diagnostics, install records, and npm-first dependency resolution. Plugin diagnostics surface installation failures and version conflicts before they cause silent runtime errors; install records give ops teams an audit trail of which plugin version was active during any conversation window; npm-first transitions ensure dependency trees resolve predictably across fresh deploys and Docker container restarts. For enterprise deployments running 20+ plugins (custom channel adapters, CRM integrations, webhook handlers), this closes the previous gap where plugin health was invisible between gateway restarts.
  Upstream: v2026.5.2

- **Session listing: Optimized for large stores**
  Session listing operations for large stores are streamlined, and repeated plugin tool descriptor hashing is reduced. At 5,000+ concurrent prospect sessions, dashboard load times and session queries are significantly faster. Previously, listing operations degraded 3–4× at 5K sessions and risked query timeouts at 10K+; v2026.5.2 keeps listing near-baseline across all tested scales.
  Upstream: v2026.5.2

- **Web search: Improved Brave, SearXNG, and Firecrawl**
  Brave Search, SearXNG, and Firecrawl web search integrations receive reliability and relevance upgrades. AI SDR agents that research prospects before outreach inject higher-quality context into first-touch messages.
  Upstream: v2026.5.2

- **Provider streaming: Anthropic, DeepSeek, and OpenAI-compatible TTS fixes**
  Anthropic streaming fixes an edge-case stream interruption during long generation; DeepSeek replay resolves multi-turn conversation misalignment; OpenAI-compatible TTS/Realtime improves voice-call routing for call-center SDR workflows.
  Upstream: v2026.5.2

### Bug Fixes

- **WhatsApp: Improved targeting and segment routing**
  WhatsApp channel routing receives targeted fixes improving message delivery reliability to specific contact segments. Fewer messages routed to wrong conversation threads; more consistent delivery across large contact lists. Works in tandem with v2026.4.29's People Memory for more reliable multi-segment outbound sequences.
  Upstream: v2026.5.2

- **Telegram: Slash-command feedback and session handling**
  Slash-command feedback is more reliable; session handling for high-traffic Telegram groups is more stable.
  Upstream: v2026.5.2

- **Gateway and startup: Leaner plugin loading and runtime config**
  Gateway and agent startup paths are leaner across plugin loading and runtime configs. Filesystem guards and large runtime config handling are optimized.
  Upstream: v2026.5.2

- **Control UI: Session, Cron, and WebSocket resilience**
  Control UI resilience improved for Sessions, Cron, and WebSocket connections.
  Upstream: v2026.5.2

---

## 2026-05-01 — OpenClaw v2026.4.29 upstream sync

### Breaking Changes

- **Tool security: explicit `alsoAllow` required**
  Configured tool sections no longer implicitly widen restrictive security profiles. Any tool-access expansion beyond a restrictive profile now requires an explicit `alsoAllow` entry in configuration. If you have custom tool-profile configurations relying on implicit widening, audit and add explicit entries before upgrading — implicit expansions now fail closed. This is the correct default for enterprise deployments where tool scope must be auditable and traceable.
  Upstream: v2026.4.29

### New Features

- **Memory/wiki: People-aware knowledge base with relationship graphs**
  The Memory system now maintains a structured people wiki alongside conversation memory. Each contact your AI SDR interacts with gets a person card (name, role, company, decision-making authority), canonical aliases deduplicated across channels (the same person on WhatsApp/Telegram/email merges into one record), relationship graphs mapping org structure and procurement chains, and provenance views tracing which conversations produced which facts. For B2B export teams, relationship graphs unlock org-structure reasoning: "Liu Wei is the procurement manager who reports to Director Zhang, who signed the last PO." That's the context that moves deals — previously only experienced sales reps carried it; now the AI does automatically.
  Upstream: v2026.4.29

- **Active Memory: Per-conversation channel filters**
  Optional `allowedChatIds` and `deniedChatIds` per-conversation filters let you wall off memory context by channel or contact group. Keep enterprise account memory separate from SMB prospect pools, or enforce GDPR data-separation between regional deployments, without additional infrastructure.
  Upstream: v2026.4.29

- **Agents/commitments: Opt-in follow-up commitment system with heartbeat delivery**
  When your AI SDR commits to a follow-up during a conversation ("I'll send the spec sheet tomorrow"), the commitment is now automatically detected, persisted, and delivered on schedule via heartbeat. Hidden batched extraction means zero UX friction on the conversation side; per-agent and per-channel scoping keeps WhatsApp and Telegram follow-up queues separate. This transforms the agent from a reactive chat interface into a proactive account manager that keeps its word without human hand-holding.
  Upstream: v2026.4.29

- **Providers/NVIDIA: New bundled inference provider**
  NVIDIA joins as a bundled provider plugin with API-key onboarding and a static model catalog. Enables high-throughput inference for pipelines processing 1,000+ daily conversations, and — combined with v2026.4.27's Docker GPU passthrough — completes the story for fully air-gapped, on-premise AI SDR deployment on NVIDIA hardware. Use the NVIDIA cloud API with just an API key, or route through your own on-premise NVIDIA GPUs via Docker.
  Upstream: v2026.4.29

- **Docker: `OPENCLAW_SKIP_ONBOARDING` for automated installs**
  New environment variable bypasses the interactive onboarding wizard, making Docker-based enterprise deployments fully scriptable for CI/CD pipelines and infrastructure-as-code workflows. Set `OPENCLAW_SKIP_ONBOARDING=1` in your Compose or Kubernetes manifest to deploy without any interactive prompts.
  Upstream: v2026.4.29

- **Localization: 6 new locales**
  Persian (Farsi), Dutch, Vietnamese, Italian, Arabic, and Thai join the locale registry. B2B export teams can now operate natively in buyer languages across GCC/MENA (Arabic), Southeast Asia (Vietnamese, Thai), EU (Dutch, Italian), and Central Asia (Persian) markets without additional localization work on your end.
  Upstream: v2026.4.29

- **Messages/queue: Active-run queueing defaults to `steer` mode**
  Message queue now defaults to `steer` with a 500ms followup fallback debounce, improving responsiveness in high-velocity conversation threads while preventing message storms during rapid back-and-forth exchanges.
  Upstream: v2026.4.29

- **Gateway diagnostics: Startup timeline recording**
  Opt-in startup diagnostics now record a gateway lifecycle timeline covering plugin-load phases and event-loop readiness. Faster operational root-cause analysis when the Gateway is slow to accept connections — essential for debugging cold-start performance in large plugin collections (20+ plugins).
  Upstream: v2026.4.29

### Fixed

- **WhatsApp**: Improved delivery confirmation and liveness checking — fewer silent failures when WhatsApp Web connectivity degrades during high-volume outbound sequences
- **Telegram**: Long-polling client timeout fixes and improved message-edit durability for streaming — more reliable for broadcast sequences and real-time reply flows
- **Slack**: Bot-authored messages with `allowBots=true` now require explicit channel allowlisting (security hardening — prevents unintended bot-to-bot relay in shared workspaces)
- **OpenAI Codex**: Preserved wrapped streams during OAuth bearer injection; restored `openai-codex/gpt-5.4-mini` for ChatGPT/Codex OAuth runs
- **Agents/subagents**: Bounded automatic orphan recovery with persisted tombstones prevents runaway orphaned sub-agent threads from consuming resources
- **Security**: Timing-safe credential byte comparison for password checks; HTML tag stripping during plain-text sanitization
- **Gateway/systemd**: Exit with sysexits 78 for supervised lock conflicts (cleaner process supervision)
  Upstream: v2026.4.29

---

## 2026-04-30 — OpenClaw v2026.4.27 upstream sync

### New Features

- **DeepInfra: New bundled AI provider**
  DeepInfra joins as a bundled provider plugin with model discovery and media generation capabilities. For B2B SDR pipelines, DeepInfra's GPU-cluster inference offers a cost-efficient path to running large models at scale — important for deployments processing thousands of daily conversations where provider API costs are a key unit-economics driver. Access open-weight models (Llama-3, Mistral) alongside proprietary options without additional infrastructure.
  Upstream: v2026.4.27

- **Memory search: Bounded top-K results & streaming support**
  Lead memory retrieval now enforces a configurable maximum result count (bounded top-K), preventing oversized context injection from large lead databases that degraded response quality and inflated token costs. Memory loading also now streams results progressively rather than blocking, reducing perceived latency for agents with rich lead histories (100+ touchpoints) and allowing response generation to begin while memory loads in the background.
  Upstream: v2026.4.27

- **Codex Computer Use: Status/install commands with marketplace discovery**
  Codex Computer Use gains `status` and `install` commands with ClawHub marketplace discovery and fail-closed MCP checks. For advanced SDR automation scenarios, this enables agent-driven tool installation and environment verification — useful for teams running OpenClaw on CI/CD pipelines or remote worker fleets where the full agent stack must be verified before routing production traffic.
  Upstream: v2026.4.27

- **Docker sandbox: GPU passthrough via `sandbox.docker.gpus`**
  Docker-based deployments can now pass GPU resources into the sandbox container via the `sandbox.docker.gpus` configuration key. Enables on-premise LLM inference, TTS/STT models, and media generation to run directly within the OpenClaw sandbox — the key path to fully air-gapped AI SDR deployments for enterprises with strict data residency requirements.
  Upstream: v2026.4.27

- **Operator proxy: Managed outbound routing with strict validation**
  Operator-managed outbound proxy routing with strict validation allows all agent traffic — API calls, webhook deliveries, channel messages — to route through a designated corporate proxy. With `strict: true`, any connection that cannot route through the proxy fails closed. Essential for regulated-market deployments (financial services, healthcare, government) where all outbound traffic must traverse a compliance inspection layer.
  Upstream: v2026.4.27

- **QQBot + Tencent Yuanbao: Expanded channel support**
  Building on v2026.4.26's QQBot group chat debut, this release expands Tencent Yuanbao and QQBot channel support with additional group functionality and stability improvements. China-market B2B teams operating at scale on Tencent's platforms get a more robust and reliable channel layer.
  Upstream: v2026.4.27

### Fixed

- Plugin startup now uses manifest-first metadata, reducing Gateway boot overhead for large plugin collections (20+ plugins)
- Sensitive tokens and API keys now comprehensively redacted across all logging systems — no credential exposure in log aggregation platforms
- Matrix approval scenarios: live metadata and chunked fallback improve E2EE channel reliability
- Plugin SDK testing surfaces reorganized into focused, documented subpaths for improved developer experience
  Upstream: v2026.4.27

---

## 2026-04-28 — OpenClaw v2026.4.26 upstream sync

### New Features

- **QQBot: Full group chat support**
  QQBot gains comprehensive group chat capabilities: conversation history tracking across sessions, @-mention gating so the bot only activates when addressed, configurable activation modes (mention-only, keyword, always-on) per group, per-group ICP and persona configuration, and a FIFO message queue for high-volume environments. C2C streaming is also supported for one-on-one QQ conversations. For B2B export teams selling into China, this brings the AI SDR natively into Q-groups — the primary procurement communication channel for Chinese enterprise buyers.
  Upstream: v2026.4.26

- **Tencent Yuanbao: New external channel plugin**
  A Tencent Yuanbao external channel plugin registers with WebSocket bot functionality, enabling AI SDR presence in China's enterprise AI assistant platform. As Yuanbao adoption grows among Chinese corporations for internal collaboration and vendor communication, this channel puts your agent at the AI-first workflow layer — before prospects open a browser to search for suppliers.
  Upstream: v2026.4.26

- **Control UI/Talk: Google Live browser realtime voice sessions**
  A generic browser realtime transport contract enables Google Live browser Talk sessions with constrained ephemeral tokens and Gateway relay support for backend-only realtime voice plugins. No server-side WebRTC infrastructure required; the Gateway relays audio to your backend voice model while short-lived tokens prevent credential leakage. Complements the v2026.4.24 Google Meet plugin for full voice-AI coverage across calls and browsers.
  Upstream: v2026.4.26

- **CLI: `openclaw migrate` — scriptable enterprise migrations**
  A new `openclaw migrate` command makes configuration and data migrations safe, auditable, and CI/CD-friendly: `--plan` previews every migration step and impact, `--dry-run --json` produces machine-readable output for approval workflows, `--backup` creates an automatic pre-migration state snapshot, and onboarding detection skips inapplicable migrations on fresh installs. Enterprise teams managing dev/staging/production environments now have a reliable, zero-downtime upgrade primitive.
  Upstream: v2026.4.26

- **Providers: Cerebras bundled plugin**
  Cerebras joins as a bundled provider plugin with full onboarding flow, a static model catalog, and documentation. WSE-3-based inference delivers sub-second latency for large context windows — beneficial for high-volume SDR pipelines (1,000+ conversations/day) where response time directly affects conversation quality and lead qualification pace.
  Upstream: v2026.4.26

- **Memory: Asymmetric embedding endpoints & Ollama query prefixes**
  OpenAI-compatible memory now supports separate endpoints and input-type configuration for query vs. document embeddings, enabling asymmetric embedding models (Cohere, Jina, Voyage) to use their full retrieval capabilities. Ollama memory adds model-specific retrieval query prefixes for instruction-tuned embedding models. Both improvements increase lead-to-memory match rates without new infrastructure or API keys.
  Upstream: v2026.4.26

- **Startup optimization: Deferred initialization & schema memoization**
  QMD, CLI handlers, and plugin HTTP routes now initialize lazily at startup. Plugin schema compilation is memoized across the session. Enterprise deployments with 20+ plugins see meaningfully faster cold-start times.
  Upstream: v2026.4.26

### Fixed

- WhatsApp proxy support — deploy behind corporate proxies in regulated-market enterprise environments
- Discord model-picker persistence — channel model selection now survives agent restarts
- Mattermost DM routing — direct messages now route correctly to the assigned agent
- LSP process cleanup — language server processes no longer linger after agent shutdown, preventing memory leaks in long-running deployments
- Plugin discovery with symlinks — monorepo-style symlinked plugin installs now discovered reliably
- Windows path normalization — ESM loader path handling fixed for Windows-hosted deployments
- Docker CA certificate bundle — automatic TLS CA installation in Docker images fixes verification failures in enterprise network environments
- Matrix E2EE improvements — end-to-end encryption reliability in Matrix channel
  Upstream: v2026.4.26

---

## 2026-04-27 — OpenClaw v2026.4.25 upstream sync

### New Features

- **Full TTS/Voice upgrade: `/tts latest`, session controls & 6 new providers**
  Voice replies receive a comprehensive overhaul: `/tts latest` pins the most capable model for a provider, session-scoped auto-TTS toggles remember your preference across turns, and per-agent/per-account TTS persona overrides let different agents speak with different voices. Six new providers land: Azure Speech, Xiaomi, Local CLI, Inworld, Volcengine, and ElevenLabs v3 (with expanded voice library and improved prosody). For SDR teams running voice follow-up sequences or real-time call assistance, this means global-quality voice across every market.
  Upstream: v2026.4.25

- **Plugin registry: cold-persisted startup and install paths**
  Plugin startup and install paths move to the cold persisted registry, eliminating broad manifest scans at every launch. Plugin update, repair, provider discovery, and install metadata are now fully deterministic. High-volume deployments that load dozens of plugins see meaningfully faster cold-start times.
  Upstream: v2026.4.25

- **OpenTelemetry observability: model calls, token usage, tool loops & process spans**
  OTel coverage expands across model calls, token usage, tool loops, harness runs, and process execution — all with bounded low-cardinality attributes for efficient backend indexing. SDR pipeline SLAs (response time, tool-call depth, token spend) are now traceable in Grafana, Datadog, or any OTel-compatible backend without custom instrumentation.
  Upstream: v2026.4.25

- **Browser automation: iframe-aware snapshots & CDP readiness**
  Role snapshots are now iframe-aware, capturing the full accessibility tree inside embedded frames — critical for CRM portals and SaaS lead tools that render key UI inside iframes. Chrome Discovery Protocol (CDP) readiness checks are adjusted for reliability, and tab URL safety prevents accidental navigation away from active automation targets.
  Upstream: v2026.4.25

- **Control UI: PWA and Web Push support**
  The OpenClaw control interface can now be installed as a Progressive Web App with Web Push notifications, giving sales teams instant alerts for inbound lead messages without keeping a browser tab open.
  Upstream: v2026.4.25

- **Installation hardening across Windows, macOS, Linux & Docker**
  Install and update flows receive cross-platform reliability improvements. Bundled plugin skill copy now runs consistently across OS environments, reducing first-run failures for teams self-hosting on diverse infrastructure.
  Upstream: v2026.4.25

### Fixed

- 200+ bug fixes spanning TTS providers, plugin diagnostics, browser automation, channel integrations (Discord, Telegram), cron job scheduling, and media handling.
  Upstream: v2026.4.25

---

## 2026-04-25 — OpenClaw v2026.4.24 upstream sync

> **Breaking change for plugin authors:** The Pi-only `api.registerEmbeddedExtensionFactory(...)` compatibility path has been removed. Custom tool-result transforms must now use `api.registerAgentToolResultMiddleware(...)` with a `contracts.agentToolResultMiddleware` declaration that names the targeted harnesses. Update any custom plugins before upgrading.

### New Features

- **Google Meet bundled participant plugin**
  OpenClaw ships a first-class Google Meet plugin: personal Google auth, explicit meeting URL joins, Chrome and Twilio realtime transports, `chrome-node` support for Parallels/VM environments, and `recover_current_tab`/`recover-tab` for re-attaching to open meetings. SDR teams can now have the AI present in every discovery call and demo — answering product questions, logging objections, and drafting follow-up notes while the conversation is live.
  Upstream: v2026.4.24

- **Realtime voice AI during live calls and meetings**
  Talk, Voice Call, and Google Meet now share an `openclaw_agent_consult` realtime tool: the AI can pull in your full OpenClaw agent (tools, memory, CRM data) mid-call to answer a hard question without putting the prospect on hold. Gateway VoiceClaw adds a new Gemini Live WebSocket backend with owner-auth gating. Paired with `voicecall setup` and dry-run `voicecall smoke` commands for one-step provider readiness checks.
  Upstream: v2026.4.24

- **DeepSeek V4 Flash confirmed as onboarding default**
  V4 Flash is now set as the default model for new users in the bundled catalog. For existing deployments, `deepseek-v4-flash` and `deepseek-v4-pro` remain available as explicit selections in `openclaw.json`. A previous thinking/replay bug where follow-up tool-call turns lost `reasoning_content` placeholders is fixed — V4 reasoning chains are now reliable across multi-turn SDR workflows.
  Upstream: v2026.4.24

- **Browser automation: coordinate clicks, longer action budgets, per-profile headless**
  `openclaw browser click-coords` adds viewport-coordinate clicks for managed and existing-session automation. `browser.actionTimeoutMs` (default 60 s) prevents healthy long-running browser waits from failing at transport boundaries. `browser.profiles.<name>.headless` lets you run one profile headless for background research while keeping another visible for demos. `~` now expands correctly in `browser.executablePath`.
  Upstream: v2026.4.24

- **WeCom channel source pinned for Chinese-market reliability**
  The official external WeCom channel source is now pinned to an exact npm release with dist-integrity checking, guarding against unpinned upstream drift. For B2B export teams relying on WeCom for enterprise customer conversations, this means predictable, auditable plugin versions across every deployment.
  Upstream: v2026.4.24

- **Gemini Live realtime voice provider**
  New backend for Voice Call and Google Meet audio bridges: bidirectional audio, function-call support, and Gemini TTS enhancement with configurable `audioProfile` and `speakerName` for consistent voice branding across calls.
  Upstream: v2026.4.24

- **Google Meet conference records: artifacts, attendance, and history**
  Meeting records now support artifact and attendance workflows — markdown/file output, latest-record lookup, and `--all-conference-records` for scanning meeting history. Post-call follow-up notes can be auto-generated and linked to the CRM record.
  Upstream: v2026.4.24

- **OpenRouter TTS provider**
  New OpenRouter text-to-speech provider using an OpenAI-compatible `/audio/speech` endpoint with `OPENROUTER_API_KEY`. Expands voice note and telephony output options for SDR voice follow-up sequences.
  Upstream: v2026.4.24

- **OTEL observability: run, model-call, and tool spans**
  Structured OpenTelemetry spans now cover runs, model calls, and tool executions — with timing, redacted error metadata, and opt-in content capture via `diagnostics.otel.captureContent`. Enables monitoring SDR pipeline SLAs in Grafana, Datadog, or any OTEL backend.
  Upstream: v2026.4.24

- **Context injection control for fully owned agent prompts**
  `agents.defaults.contextInjection: "never"` disables workspace bootstrap file injection for agents that own their full prompt lifecycle. Useful for specialized sub-agents (qualifier, closer) that should not inherit the parent's workspace context files.
  Upstream: v2026.4.24

- **Bonjour LAN Gateway discovery as default-enabled bundled plugin**
  LAN Gateway advertising moved to a default-enabled bundled plugin with its own `@homebridge/ciao` dependency. Users who don't need Bonjour can disable it without affecting wide-area discovery.
  Upstream: v2026.4.24

- **Plugin Compatibility Registry**
  Central registry added for SDK/config/setup/runtime deprecation records with dated migration metadata. Easier to audit which plugins need updates before a platform upgrade.
  Upstream: v2026.4.24

### Fixed

- **Critical: Heartbeat prompt injection into normal runs**
  The heartbeat system was injecting its prompt into non-heartbeat runs, causing ordinary SDR replies to be suppressed as `HEARTBEAT_OK`. This is fixed. Heartbeat prompts, `HEARTBEAT_OK` acknowledgments, and runtime context turns are now hidden from visible history.
  Upstream: v2026.4.24

- **MCP session management: one-shot runtimes and idle eviction**
  One-shot embedded bundled MCP runtimes now retire at run end. New `mcp.sessionIdleTtlMs` idle eviction cleans up leaked sessions. Startup skipped when runtime tool allowlist cannot reach bundle-MCP tools.
  Upstream: v2026.4.24

- **Browser profile startup: stale Chromium lock recovery and launch deduplication**
  Stale `Singleton*` locks left by crashes are now cleared and retried. Concurrent lazy-start calls per profile are deduplicated, preventing duplicate Chrome launches and `PortInUseError`.
  Upstream: v2026.4.24

- **Scheduler delay overflow**
  Oversized scheduler delays clamped through a shared safe-timer helper, preventing Node.js timeout cap overflows that could cause scheduled SDR tasks (cron jobs) to fire immediately or never.
  Upstream: v2026.4.24

- **WhatsApp: media delivery in tool-result replies, voice note transcription, group system prompts**
  Media generated by tool-result replies is now delivered correctly. Voice notes are transcribed before agent dispatch while keeping transcripts out of command authorization. Setting `systemPrompt: ""` on a specific `groups.<id>` now correctly suppresses the wildcard prompt.
  Upstream: v2026.4.24

- **Telegram: polling persistence across restarts, model display names, forum-topic config**
  Accepted update offsets are persisted before handlers complete, preventing replay on restart. Configured model display names now show in provider buttons. Generated schema metadata is included in packaged manifests for forum-topic/group config.
  Upstream: v2026.4.24

- **Slack: thread ordering, broadcast events, approval buttons, file downloads**
  Multi-part block deliveries stay in the first reply thread when `replyToMode` is `first`. `thread_broadcast` events are now processed as user messages reaching agents. Native button clicks are resolved through Gateway preserving retry buttons. Non-image file downloads return local paths with file IDs.
  Upstream: v2026.4.24

- **MCP Gateway security: owner-only tool policy on 127.0.0.1/mcp**
  `tools/list` and `tools/call` now enforce owner-only tool policy and run before-tool-call hooks, preventing non-owner bearer tokens from accessing owner-only tools.
  Upstream: v2026.4.24

- **DeepSeek V4 thinking replay on follow-up tool-call turns**
  Missing `reasoning_content` placeholders added for replayed assistant tool-call turns when V4 thinking is enabled. Multi-turn SDR workflows using DeepSeek reasoning no longer lose context between turns.
  Upstream: v2026.4.24

- **Agent failover: abort signals and non-retryable 429 responses**
  Embedded run abort signals are forwarded into provider streams with implicit watchdog caps. Non-retryable 429 responses no longer spin the retry loop.
  Upstream: v2026.4.24

- **Session store rotation: crash-safe sessions.json rewrite**
  Oversized `sessions.json` is copied to a rotation backup before atomic rewrite, preventing crash-induced session mapping loss.
  Upstream: v2026.4.24

- **Matrix cross-signing: full identity trust required**
  Full cross-signing identity trust is now required for self-device verification. `openclaw matrix verify self` added for CLI-initiated verification.
  Upstream: v2026.4.24

## 2026-04-24 — OpenClaw v2026.4.23 upstream sync

### New Features

- **OpenAI image generation + reference-image editing via Codex OAuth**
  OpenAI provider now supports image generation and reference-image editing through Codex OAuth. SDR teams can generate on-brand product visuals and edit reference images directly within agent workflows — no separate image tool or API key juggling required.
  Upstream: v2026.4.23

- **OpenRouter image generation + reference-image editing**
  Same image generation and reference-image editing capability extended to OpenRouter models, with provider-supported quality and output format hints. Unlocks a broader model roster for visual content in outreach sequences.
  Upstream: v2026.4.23

- **Subagent forked context for native sessions**
  Agents can now launch subagents with forked context in native sessions, with prompt guidance and inline documentation. Enables multi-step SDR workflows where a qualifier subagent hands off context to a closer subagent — each with its own memory slice — without sharing a single conversation thread.
  Upstream: v2026.4.23

- **Per-call `timeoutMs` for image, video, music, and TTS generation**
  Individual tool calls for generative media (image, video, music, TTS) can now carry an explicit `timeoutMs`. SDR pipelines that generate voice previews or product images mid-conversation can set tight SLA budgets per call without a global timeout affecting all tools.
  Upstream: v2026.4.23

- **Configurable local embedding context size (default 4096)**
  Local embedding providers now accept a configurable context size, defaulting to 4096 tokens. Teams running OpenClaw on constrained VPS or edge hosts can reduce memory pressure without switching to a cloud embedding provider.
  Upstream: v2026.4.23

- **GPT-5.5 catalog metadata via Pi 0.70.0**
  Dependencies updated to Pi 0.70.0, adding GPT-5.5 model catalog metadata. GPT-5.5 is now selectable as an agent model without manual catalog patching.
  Upstream: v2026.4.23

### Fixed

- **89 distinct fixes across all major subsystems** including:
  - Codex harness routing and context-engine assembly
  - WhatsApp, Telegram, Discord, and Slack integration stability
  - Transcript replay and media handling
  - Security hardening across authentication, permissions, and data handling
  - Plugin startup and dependency resolution
  - Gateway session management and WebChat error surfacing
  - Memory indexing and local embedding provider declaration
  - Provider routing for OpenAI, OpenRouter, and Google services
  Upstream: v2026.4.23

## 2026-04-24 — DeepSeek V4 (Flash + Pro) catalog support

### New Features

- **DeepSeek V4 catalog entries**: `deepseek-v4-flash` and `deepseek-v4-pro` added to `providers.deepseek.models[]` in `openclaw.json`. Both reachable via OpenClaw's existing `openai-completions` passthrough — no SDK or plugin changes required. 1M-token context window, 8K/64K max output tokens respectively.
- **Legacy aliases preserved**: `deepseek-chat` and `deepseek-reasoner` references continue to work via DeepSeek's own server-side aliases until **2026-07-24** (the DeepSeek-announced deprecation date). No forced migration; `agents.defaults.model` is intentionally not touched by this change.
- **Thinking mode opt-in**: V4 models default to reasoning-on behavior. To get the old `deepseek-chat` fast path (non-thinking, pure `content` output), add `params: { "thinking": { "type": "disabled" } }` under `agents.defaults.models["deepseek/deepseek-v4-flash"]`. Set `{"type": "enabled"}` for Pro-grade reasoning on multi-turn tasks.
- **Rollback**: single-file snapshot `openclaw.json.bak-2026-04-24` is created automatically by the deploy step; restore and `systemctl --user restart openclaw-gateway` to revert in under a minute.

## 2026-04-23 — OpenClaw v2026.4.22 upstream sync

### New Features

- **Voice Call streaming transcription across Deepgram, ElevenLabs, and Mistral**
  Incoming and outgoing voice calls can now be transcribed in real-time using any of three providers. For B2B SDR teams running voice follow-up alongside WhatsApp/Telegram, every call is automatically transcribed and available for AI summarization, CRM logging, and objection tracking — with no manual note-taking required.
  Upstream: v2026.4.22

- **Per-group and per-direct systemPrompt forwarding for WhatsApp**
  Each WhatsApp group or direct conversation can now carry its own `systemPrompt` config, forwarded through the channel layer. SDR agents can maintain distinct personas for each prospect segment — different tone for cold leads vs. warm pipeline, different product focus for each vertical — without running separate instances.
  Upstream: v2026.4.22

- **Mailbox-style session filtering with labels and search**
  Sessions can now be organized with labels and filtered via a search interface. Useful for managing high-volume SDR inboxes: label leads by stage (cold / warm / proposal-sent), filter by account, and surface active threads instantly.
  Upstream: v2026.4.22

- **xAI image generation, text-to-speech, and speech-to-text via grok-imagine-image**
  xAI models (including `grok-imagine-image`) are now first-class providers for image generation, TTS, and STT. Adds a new vendor option for generating product visuals, voice demos, and audio content in SDR outreach flows.
  Upstream: v2026.4.22

- **Local embedded mode: terminal chats without Gateway**
  A new embedded mode allows the agent to run inline in a terminal session without requiring a full Gateway deployment, while plugin approval gates are preserved. Useful for quick local testing of SDR agent configurations before production rollout.
  Upstream: v2026.4.22

- **Auto-install missing provider and channel plugins on first setup**
  Required plugins are detected and installed automatically during initial configuration. Reduces setup friction for new deployments — no more manual plugin discovery after `install.sh`.
  Upstream: v2026.4.22

- **Browser-local personal identity for operators with avatar support**
  Operators can configure a browser-local identity with avatar. Enables multiple SDR operators to maintain distinct visible identities within the same deployment.
  Upstream: v2026.4.22

- **Bundled Tencent Cloud provider plugin with TokenHub integration**
  Tencent Cloud (Hunyuan models + COS storage) ships as a bundled plugin with TokenHub credential management. For businesses targeting the Chinese market, this enables a fully domestic AI stack alongside WeChat and other Tencent services.
  Upstream: v2026.4.22

- **Claude Opus 4.7 support via Amazon Bedrock Mantle**
  The latest Claude Opus 4.7 model is now accessible through the Amazon Bedrock Mantle provider. Upgrade SDR conversation quality with the most capable Claude model for nuanced negotiation and complex objection handling.
  Upstream: v2026.4.22

- **Enhanced OpenAI Responses with native web_search tool**
  OpenAI Responses API now automatically activates the native `web_search` tool. SDR agents can enrich prospect conversations with real-time market data, news, and company intelligence without additional tool configuration.
  Upstream: v2026.4.22

- **`/models add <provider> <modelId>` command for in-chat model registration**
  New models can be registered directly from a chat session without editing config files. Useful for trying new model versions during live SDR deployments.
  Upstream: v2026.4.22

### Changed

- **Reasoning models default to "medium" thinking level**
  The implicit thinking level for reasoning models is raised from low to medium, producing more thorough responses for complex sales scenarios without requiring explicit configuration.
  Upstream: v2026.4.22

### Fixed

- **Token usage now reported correctly for OpenAI-compatible local backends**
  Local LLM setups (Ollama, LM Studio, etc.) now report accurate token counts, enabling reliable cost/usage tracking in mixed-model deployments.
  Upstream: v2026.4.22

- **Telegram forum topic thread caching stabilized**
  Forum topic thread mappings are now cached with bounded expiry, preventing stale topic IDs from misdirecting messages in active Telegram forum groups.
  Upstream: v2026.4.22

## 2026-04-22 — OpenClaw v2026.4.21 upstream sync

### Security (Upgrade Recommended)

- **Owner-enforced commands require verified owner identity**
  Owner-enforced commands now require verified owner identity before execution, closing a privilege-escalation path where non-owner operators could invoke owner-reserved commands under certain conditions. For multi-operator deployments (sales manager + SDR reps), operator-tier agents can no longer trigger owner-tier commands.
  Upstream: v2026.4.21

### Changed

- **Image generation defaults to gpt-image-2 with 2K/4K resolution hints**
  The bundled image-generation provider now uses `gpt-image-2` by default and advertises 2K and 4K size hints. For SDR agents generating product catalog images, quote visuals, or marketing assets, this is a direct quality upgrade with no prompt changes required.
  Upstream: v2026.4.21

### Fixes

- **Plugin doctor repairs bundled runtime dependencies for packaged installs**
  `openclaw doctor` can now repair bundled plugin runtime dependencies from doctor paths for packaged installs, resolving a class of silent plugin failures where missing post-install dependencies produced no clear error.
  Upstream: v2026.4.21

- **Slack thread routing restored for concurrent outbound sends**
  Thread aliases are now preserved in runtime outbound Slack sends so programmatic messages land in the correct thread rather than the channel root or an unintended thread. Restores predictable behavior for Slack-based lead follow-up and CRM notification flows.
  Upstream: v2026.4.21

- **Browser automation: invalid accessibility refs rejected immediately**
  Invalid accessibility refs are now rejected immediately rather than waiting for a full timeout, reducing latency for failing browser automation tasks such as web form submissions and lead enrichment scraping.
  Upstream: v2026.4.21

- **Image generation fallback: failed candidates logged at warn level**
  Failed provider/model candidates during automatic image-generation fallback are now logged at warn level before the fallback fires, making fallback behavior visible in production logs.
  Upstream: v2026.4.21

- **node-domexception deprecation warning resolved**
  The `node-domexception` alias is mirrored into root `package.json` overrides, silencing deprecation warnings in Node.js 18+ environments. No functional impact.
  Upstream: v2026.4.21

## 2026-04-21 — OpenClaw v2026.4.20 upstream sync

### Security (Upgrade Recommended)

- **Workspace `.env` hardened — all `OPENCLAW_*` keys blocked from untrusted files**
  All `OPENCLAW_*` env keys are now blocked from untrusted workspace `.env` files, extending the runtime-control isolation from v2026.4.9. Also newly blocked: `MINIMAX_API_HOST` injection and interpreter-startup keys like `NODE_OPTIONS` for stdio MCP servers. If your deploy scripts inject these keys via workspace `.env`, move them to system environment or `openclaw.json` before upgrading.
  Upstream: v2026.4.20

- **Config mutation guard extended — AI cannot rewrite operator-trusted paths**
  `config.patch` and `config.apply` tool calls from model-driven agents can no longer overwrite operator-trusted config paths. Closes a privilege-escalation vector where a compromised agent could modify gateway security settings mid-session.
  Upstream: v2026.4.20

- **Non-admin paired-device sessions scoped to own pairing actions only**
  Paired devices without admin rights can no longer approve or reject other devices' pairing requests. Relevant for multi-operator deployments where paired mobile devices share a gateway.
  Upstream: v2026.4.20

- **WebSocket broadcasts require `operator.read` — unknown events scoped by default**
  Chat, agent, and tool-result WebSocket event frames now require `operator.read` scope. Unknown event types are scoped by default rather than broadcast. Hardens gateway against read-access escalation via WebSocket.
  Upstream: v2026.4.20

- **QQBot SSRF guard — direct-upload media URLs validated**
  SSRF protection added to QQBot's `uploadC2CMedia` and `uploadGroupMedia` direct-upload paths. If you route media through internal hosts via QQBot, ensure those hosts are in your SSRF allowlist.
  Upstream: v2026.4.20

### Changed (Upgrade Recommended)

- **Default system prompts strengthened — better SDR pipeline completion**
  OpenClaw's built-in system prompts now include explicit completion bias, live-state verification checks, and weak-result recovery mechanisms. For B2B SDR agents, this means the agent is less likely to stop mid-pipeline on ambiguous responses, self-verifies before marking a lead stage complete, and retries gracefully when a tool call returns a weak result.
  Upstream: v2026.4.20

- **Session entry cap and age prune enforced by default**
  Session stores now enforce the built-in entry cap and prune oversized stores at load time. Prevents out-of-memory conditions on long-running SDR deployments with hundreds of active conversations. No config change required — defaults are safe. To customize: `session.maxEntries` and `session.maxAgeMs` in `openclaw.json`.
  Upstream: v2026.4.20

- **Auto-reply policy scoped per conversation type — direct chats vs groups**
  The `NO_REPLY` policy is now applied per conversation type: direct chats receive a helpful rewritten reply while group channels stay quiet. For SDR agents, this means the agent correctly handles 1:1 leads on WhatsApp and Telegram while staying silent in broadcast or staff group chats without extra config.
  Upstream: v2026.4.20

- **Cron state split — `jobs-state.json` separate from `jobs.json`**
  Runtime cron execution state is now stored in `jobs-state.json` so `jobs.json` remains stable for git-tracked definitions. If you version-control your cron job definitions, this eliminates noisy state changes in git diffs. Migrated automatically on first run.
  Upstream: v2026.4.20

### Fixes

- **Active memory degrades gracefully on recall failure**
  If memory recall fails (e.g., vector store unavailable, index corrupt), the agent now logs a warning and continues the turn instead of failing. Critical for production SDR deployments that process inbound leads without manual supervision.
  Upstream: v2026.4.20

- **Web search plugin API keys now resolve correctly**
  Plugin-scoped `SecretRef` API keys for Exa, Firecrawl, Gemini, Kimi, Perplexity, Tavily, and Grok are now correctly resolved. If your lead-research or enrichment workflow uses any of these search plugins and keys are stored as `SecretRef`, this fix is required.
  Upstream: v2026.4.20

- **Telegram polling watchdog raised from 90s to 120s**
  The Telegram polling stall threshold is raised from 90 s to 120 s (configurable via `channels.telegram.pollingStallThresholdMs`). Reduces false-positive reconnects under high-message-volume SDR campaigns and slow network conditions.
  Upstream: v2026.4.20

- **Telegram offset confirmation timeout — prevents zombie socket hangs**
  Persisted-offset confirmation now has a client-side timeout, preventing Telegram polling from hanging indefinitely on dropped connections. Affects long-running SDR campaigns on high-volume Telegram channels.
  Upstream: v2026.4.20

- **Model auto-failover session overrides cleared before each turn**
  Transient auto-failover provider/model overrides are now cleared before each turn, so the primary model is retried immediately on the next message rather than sticking to the failover. Ensures your configured primary model (e.g., Claude Opus 4.7) is used for lead qualification, not a fallback.
  Upstream: v2026.4.20

- **`/new` and `/reset` clear auto-sourced overrides, preserve explicit selections**
  Starting a new conversation or resetting now clears auto-sourced model, provider, and auth-profile overrides while preserving any model you've explicitly set. Prevents stale failover state from carrying into fresh SDR sessions.
  Upstream: v2026.4.20

- **Memory dreaming: normalized timestamps and deduplicated session keys**
  Memory sweep timestamps are normalized and narrative session keys are deduplicated via hashing, preventing memory leaks in long-running deployments. Relevant for SDR agents using the active-memory plugin across hundreds of concurrent lead conversations.
  Upstream: v2026.4.20

- **Gateway doctor surfaces pending pairing, scope-upgrade, and stale device-token issues**
  `openclaw doctor` now detects and surfaces pending device pairing requests, scope-upgrade approval drift, and stale device-token problems. Reduces silent gateway auth failures in multi-operator team deployments.
  Upstream: v2026.4.20

- **Slack `SecretRef` outbound reply fix — unresolved secret error resolved**
  Outbound Slack replies were failing with "unresolved SecretRef" for file or exec secret sources. Fixed — Slack channel outbound messaging is restored.
  Upstream: v2026.4.20

- **Gateway cost usage cache bounded with FIFO eviction**
  The cost usage cache now has FIFO eviction to prevent unbounded memory growth. Relevant for high-volume SDR deployments processing many sessions over long uptimes.
  Upstream: v2026.4.20

### Documentation

- Updated `workspace/TOOLS.md`: v2026.4.20 upgrade banner, session entry cap note, Telegram polling note
- Updated `deploy/UPGRADE.md`: v2026.4.20 known-issues table

## 2026-04-16 — OpenClaw v2026.4.15 upstream sync

### Changed (Upgrade Recommended)

- **Default model upgraded to Claude Opus 4.7**
  OpenClaw's default Anthropic model selections, `opus` aliases, and Claude CLI defaults now point to Claude Opus 4.7. If your `openclaw.json` uses `model: opus` or any unversioned alias, it now resolves to Opus 4.7 automatically — no config change required. B2B SDR impact: Opus 4.7 delivers improved multi-step reasoning, stronger objection handling chains, and better long-context coherence across complex pipeline negotiations.
  Upstream: v2026.4.15

### New Features

- **Google Gemini text-to-speech** *(WATCH — new voice channel capability)*
  The bundled `google` plugin now includes Gemini TTS: voice selection, WAV reply output, and PCM telephony output. Relevant for deployments adding voice channels (IVR, WhatsApp voice notes). Not required for standard B2B SDR text workflows.
  Upstream: v2026.4.15

### Fixes

- **Skill sort order stabilized — reduces prompt-cache misses**
  `available_skills` entries are now sorted alphabetically after all sources merge. Prevents prompt-cache prefix drift when `skills.load.extraDirs` order changes, reducing cold-start API cost for custom-skill deployments.
  Upstream: v2026.4.15

- **Memory context budget trimmed — lighter long-session context**
  Default startup and skills prompt budgets are reduced; `memory_get` excerpts are now capped with explicit continuation metadata. Long SDR sessions (30+ turns) see lighter context payloads without losing memory continuity. Reduces per-conversation API cost on high-volume pipelines.
  Upstream: v2026.4.15

### Documentation

- Updated `workspace/TOOLS.md`: Opus 4.7 default noted in provider table, v2026.4.15 upgrade banner

## 2026-04-14 — OpenClaw v2026.4.14 upstream sync

### Security (Upgrade Recommended)

- **UI Markdown renderer: marked.js → markdown-it (XSS fix)**
  The control UI's Markdown renderer has been replaced with markdown-it, eliminating a class of XSS vulnerabilities triggerable by agent-generated or user-supplied content rendered in the web UI. Any deployment with the UI reachable by untrusted users should treat this as a required upgrade.
  Upstream: v2026.4.14

- **Browser SSRF policy fully enforced**
  Browser navigation, screenshot, and snapshot requests now enforce the outbound SSRF policy, preventing a sandboxed browser tool from probing internal network addresses.
  Upstream: v2026.4.14

- **Attachment path canonicalization**
  Attachment paths are canonicalized before processing, blocking a path-traversal vector in file-handling workflows.
  Upstream: v2026.4.14

- **Gateway tool flag restrictions hardened**
  Tool flag restrictions in the service gateway are now enforced for security settings.
  Upstream: v2026.4.14

- **Slack interaction allowlist enforcement fixed**
  Slack interaction allowlist is now correctly enforced.
  Upstream: v2026.4.14

### New Features

- **GPT-5.4-Pro forward compatibility** *(RELEVANT — OpenAI users)*
  OpenClaw ships pricing, token limits, and visibility metadata for `gpt-5.4-pro` ahead of OpenAI's upstream catalog update (PR #66453). Teams can set `models.providers.openai.model: gpt-5.4-pro` immediately — routing, cost accounting, and context-limit guards are already wired in.
  B2B SDR relevance: gpt-5.4-pro's expanded reasoning translates to better objection handling and more coherent multi-step follow-ups across long sales threads.
  Upstream: v2026.4.14

- **Telegram forum topic names in agent context** *(RELEVANT — Telegram outreach)*
  OpenClaw learns topic names from Telegram forum service messages and surfaces them as human-readable context in agent replies and plugin hook metadata (PR #65973). Previously only a numeric topic ID was available. Templates can now reference `{{telegram.topic_name}}` for stage-aware routing and persona selection.
  B2B SDR relevance: export teams using forum-structured Telegram groups (one topic per deal stage or territory) can now apply stage-appropriate messaging without manual routing rules.
  Upstream: v2026.4.14

### Channel Improvements

- **WhatsApp: media encryption edge cases fixed**
  Media decryption now handles edge cases in encryption key derivation, fixing silent drops of inbound voice notes, images, and documents. Critical for WhatsApp-heavy markets (Brazil, India, Southeast Asia).
  Upstream: v2026.4.14

- **Microsoft Teams: SSO allowlist checks enforced**
  Teams SSO flows now correctly enforce the sender allowlist, blocking unallowlisted OAuth identities from triggering agent processing. Relevant for enterprise Teams deployments restricted to specific internal or partner identities.
  Upstream: v2026.4.14

- **Feishu: sender allowlist canonicalization**
  Feishu sender allowlists are now canonicalized consistently, fixing an edge case where differently-formatted IDs of the same user could bypass or double-trigger the allowlist. Relevant for outreach into Chinese enterprise accounts.
  Upstream: v2026.4.14

- **Telegram: topic name persistence + read-only status bypass fixed**
  Topic names persist correctly across restarts; read-only Telegram status commands now correctly bypass the standard message processing pipeline.
  Upstream: v2026.4.14

- **TTS: voice note reply persistence fixed**
  Voice note replies generated by the TTS module now persist correctly after send, closing a gap in conversation history that disrupted follow-up logic.
  Upstream: v2026.4.14

- **Discord: status command responses fixed**
  The `!status` command in Discord now responds correctly in all gateway configurations.
  Upstream: v2026.4.14

- **Telegram: media download proxy support**
  Telegram media downloads now route through the configured outbound proxy, fixing connectivity in restricted-network deployments.
  Upstream: v2026.4.14

### Memory & Session

- **Active memory: prompt placement corrected + logging improved**
  Memory context is now injected at the correct position in the prompt template, improving recall accuracy. Retrieval logging improved for observability.
  Upstream: v2026.4.14

- **Session memory: workspace scoping fixed**
  Session memory is now correctly scoped to the workspace, preventing cross-workspace memory bleed in multi-tenant deployments.
  Upstream: v2026.4.14

- **Session memory: slug generation timeouts fixed**
  Eliminates a failure mode where memory slugs were not created for long conversation subjects.
  Upstream: v2026.4.14

### Infrastructure

- **Cron scheduler: error backoff + recovery**
  The cron scheduler now applies exponential backoff on errors and recovers cleanly from transient failures. Previously, a single error could stall the entire scheduled-task queue, blocking timed follow-up sequences.
  Upstream: v2026.4.14

- **Ollama: timeout inheritance for streaming + accurate usage reporting**
  Timeout configuration is now correctly inherited for streaming requests; token usage counts are accurate in streaming mode. Relevant for local Ollama deployments used for cost or data-residency reasons.
  Upstream: v2026.4.14

- **Subagent registry distribution in npm builds**
  The subagent registry is now correctly included in npm package builds.
  Upstream: v2026.4.14

- **GitHub Copilot reasoning support added**
  Upstream: v2026.4.14

---

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
