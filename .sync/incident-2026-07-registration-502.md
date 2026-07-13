# Incident — pulseagent.io Registration Failing (Backend 502)

**Status:** OPEN — origin backend outage (not fixable from this repo)
**Reported:** user report "pulseagent.io 又无法注册了" (registration broken again)
**Diagnosed:** 2026-07-10 ~06:26 UTC (per HTTP `Date` headers on probes)
**Scope:** All `/app/api/*` routes — registration, login, session, config

## Symptom

Users cannot sign up. The signup page loads, then its first API call
(`GET /app/api/auth/registration-config`) fails and the form can't submit.
Login is broken by the same cause.

## Probe results

| Layer | URL | Result |
|-------|-----|--------|
| Marketing site | `https://pulseagent.io` | 200 OK |
| App shell (SPA) | `/app/login?lang=en`, `/app/register?lang=en` | 200 OK (static, served by Cloudflare) |
| Registration config | `/app/api/auth/registration-config` | **502** |
| Register | `/app/api/auth/register` | **502** |
| Login | `/app/api/auth/login` | **502** |
| Session | `/app/api/auth/me` | **502** |

Consistent across 3 retries; all `/app/api/*` endpoints affected.

## Root cause

Cloudflare is healthy and serving the static frontend, but the **origin
backend behind it is unreachable/erroring**. The 502 responses carry
`server: cloudflare`, `content-type: text/plain`, `content-length: 16`
(body: `error code: 502`) — Cloudflare's own bad-gateway page, i.e. the
API origin is down or crash-looping. This is a full backend/API outage,
not a registration-specific bug and not a frontend/DNS problem.

The SPA (`/app/assets/index-*.js`) hardcodes API base `Bn = "/app/api"`,
so every authenticated call — `register`, `login`, `me`,
`registration-config`, magic-link, password reset — is down while the
origin is 502ing.

## Update — escalation timeline (probe observations)

- **~08:00 UTC** — `/app/api/*` returns **502** (origin bad gateway); marketing site + SPA shell healthy (200).
- **~09:00–13:00 UTC** — `/app/api/*` returns **504** (origin timeout); frontend still 200.
- **~15:20 UTC** — **522** (Cloudflare→origin connection timed out) now on **all** paths including the homepage (`https://pulseagent.io`), ~20s timeouts. Outage widened from API-only to the whole origin — the origin is now fully unreachable from Cloudflare, not just erroring on API routes.

- **~19:35 UTC** — **partial shift**: marketing homepage recovered (**200**, ~0.8s), but `/app/api/*` now **hangs** — requests return 0 bytes and hit the client's 30s timeout (curl exit 28), no Cloudflare error page. The frontend/origin is serving again while the **API backend accepts connections but never responds** (wedged/hung process, distinct from "origin down"). Registration still broken.

No recovery observed. Progression 502 → 504 → 522 (full-site) → home 200 + API hang. The frontend origin came back but the API service is not responding; remediation still targets the API backend (restart the hung API process/workers, not just the web tier).

## Fix (out of repo)

The pulseagent.io API backend is **not** part of this template repository
(`b2b-sdr-agent-template` ships docs, skills, deploy scripts, and the
`.sync/` content pipeline only). Remediation happens on the backend host:

1. Check the API origin process/container health and logs.
2. Restart / redeploy the API service; confirm it passes its own health check.
3. Verify `GET /app/api/auth/registration-config` returns 200 and the
   signup form submits end-to-end.

## Verification command

```sh
for p in registration-config register login me; do
  printf '%s -> ' "$p"
  curl -s -o /dev/null -w '%{http_code}\n' \
    "https://pulseagent.io/app/api/auth/$p"
done
# All 200 (or 4xx on bad input) = recovered. 502 = still down.
```
