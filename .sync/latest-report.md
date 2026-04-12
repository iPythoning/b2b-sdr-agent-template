# Release Sync Report — 2026-04-12

**Previous release**: v2026.4.10
**New release**: v2026.4.11
**Published**: 2026-04-12T00:18:03Z

## Categories

| Change | Category |
|--------|----------|
| Microsoft Teams delegated OAuth + Graph pagination | RELEVANT |
| Feishu comment sessions + reactions + typing feedback | RELEVANT |
| Plugin activation/setup auth descriptors | RELEVANT |
| Webchat rich output bubbles + `[embed]` tag | RELEVANT |
| Memory Palace + ChatGPT import ingestion | WATCH |
| video_generate URL-only + reference audio | WATCH |
| Ollama model caching | WATCH |
| GPT-5.4 vs Opus 4.6 parity gate | WATCH |
| OpenAI-compatible endpoint debug logging | SKIP |
| 18 fixes (Codex OAuth, WhatsApp config, Telegram topic) | RELEVANT (active channels) |

## Template Changes

- `CHANGELOG.md.local`: added "Adapted from openclaw v2026.4.11" section
- `workspace/AGENTS.md`: added Feishu to channel orchestration matrix + Feishu-specific notes section

## Blog Posts

| Lang | Title | URL | Status |
|------|-------|-----|--------|
| EN | OpenClaw v2026.4.11: Teams OAuth, Feishu & Memory Import | https://pulseagent.io/en/blog/openclaw-v2026-4-11-teams-oauth-feishu-memory-import | published |
| ZH | OpenClaw v2026.4.11：Teams 委托认证、飞书升级与 ChatGPT 记忆导入 | https://pulseagent.io/en/blog/openclaw-v2026-4-11-teams-feishu-memory-zh | published |

## WeChat

**Status**: FAILED — `WeChat API error: 40125 invalid appsecret` (server-side credential issue, not content-related)
**Action required**: Check WeChat Official Account appsecret in PulseAgent platform settings and re-publish manually.
