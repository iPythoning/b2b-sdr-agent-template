# Upstream OpenClaw Policy

> Frozen 2026-05-22. Next review: when introducing source-level openclaw components.

## Current state

PulseAgent (the operator) does not depend on any `openclaw` npm or pip
package. Backend (FastAPI / SQLAlchemy), frontend (React / Vite), and
`whatsapp-relay` (direct `@whiskeysockets/baileys` integration) are all
**PA-owned code**. Customer deployments share no source-level coupling
with upstream `openclaw/openclaw`.

```
PA repo ── owned ──────────────────────────────────┐
  backend/ (FastAPI)                                │
  frontend/ (React)                                 │  zero dep
  whatsapp-relay/ (direct Baileys integration)      │
                                                    ▼
                                      openclaw/openclaw (upstream)
                                      used only for: marketing, SEO
```

## OpenClaw Release Routine scope

The hourly routine driven by `b2b-sdr-agent-template/.sync/` **only**
updates:

- `README.md` / `README.zh-CN.md`
- `CHANGELOG.md`
- pulseagent.io blog posts (SEO)
- WeChat OA broadcasts

**Strictly forbidden**: any change to customer-running code, Dockerfile,
docker-compose.yml, nginx.conf, scripts/, entrypoint.sh, backend/app/,
frontend/src/, or whatsapp-relay/relay.js.

If the routine ever crosses that line, revert immediately and fix the
routine.

## When cherry-pick rules become needed

Only when PA introduces a source-level openclaw component (Hermes runtime,
openclaw-helm, openclaw skills SDK, etc.) does this file get a
cherry-pick section.

Trigger conditions (any of them):

- Adding an `openclaw` / `hermes` / `clawhub` package to PA dependencies
- Copying any file from `openclaw/openclaw` repo into this repo
- Pulling openclaw via `git subtree` / `git submodule`

Until one of those happens, no rules apply.

## Path D (WhatsApp history sync)

PA's `whatsapp-relay/relay.js` uses its own Baileys integration. Path D
changes go straight into PA repo via PR — no cherry-pick flow.

Backend persistence uses the `whatsapp_history_imports` table (independent
model), not `gateway_messages` (queue-state table).

## Checklist when someone says "should we cherry-pick this from upstream?"

1. Which file does the change land in?
2. Is that file PA-owned, or an upstream mirror?
3. PA-owned → change directly, no cherry-pick.
4. Upstream mirror (no such case today) → consult future cherry-pick rules
   added to this file when source-level coupling first appears.
