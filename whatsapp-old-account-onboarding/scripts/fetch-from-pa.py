#!/usr/bin/env python3
"""
Fetch WhatsApp history from PulseAgent (Path D).

This is the client side of Path D: instead of extracting from a phone
backup, we pull the .txt files PA already accumulated via the Baileys
Multi-Device sync that ran when the customer scanned a fresh QR.

Output is byte-compatible with v0.4 device-backup extractors, so the
downstream pipeline (parser → profile extractor → miner → upload) is
identical regardless of source.

Usage:
    # Config lives in ~/.pa-config.json or pa-config.json (same as
    # memos-upsert.py / bulk-embed.py)
    python fetch-from-pa.py --owner-name "Sarah Fan" --output ./exports

    # Override via CLI:
    python fetch-from-pa.py \
        --endpoint https://pa.example.com \
        --token "<user-bearer-token>" \
        --owner-name "Sarah Fan" \
        --output ./exports

Path D prerequisite checklist (in order):
  1. PA whatsapp-relay running with SYNC_HISTORY=1
  2. On the customer's iPhone WhatsApp:
       Settings → Chats → Device History → "All chat history"
  3. POST /qr-refresh on the relay (or use bootstrap.sh's Path D branch)
  4. Customer scans the fresh QR
  5. WAIT — Multi-Device sync can take 30 min to 6 hours depending on
     account size. Watch /v1/relay/heartbeat for completion signals.
  6. Run this script to fetch the accumulated .txt files.

If Path D produced no rows, the endpoint returns 404 — this script
exits with code 2 in that case so wrapper scripts can fall back to
Path B/C (device backup extraction).
"""
from __future__ import annotations

import argparse
import io
import json
import os
import sys
import zipfile
from pathlib import Path
from urllib import error, request


def load_config(args: argparse.Namespace) -> dict[str, str]:
    cfg: dict[str, str] = {}
    for path in (Path.cwd() / "pa-config.json", Path.home() / ".pa-config.json"):
        if path.is_file():
            cfg.update(json.loads(path.read_text(encoding="utf-8")))
            break
    for key in ("endpoint", "token"):
        env = os.environ.get(f"PA_{key.upper()}")
        if env:
            cfg[key] = env
        cli = getattr(args, key, None)
        if cli:
            cfg[key] = cli
    return cfg


def fetch(cfg: dict[str, str], owner_name: str) -> bytes:
    base = cfg["endpoint"].rstrip("/")
    # match the FastAPI prefix used in whatsapp_admin.py + main.py router
    # registration (settings.API_PREFIX, default /api/v1)
    url = f"{base}/api/v1/whatsapp/export-history?owner_name={request.quote(owner_name)}"
    req = request.Request(
        url,
        method="GET",
        headers={"Authorization": f"Bearer {cfg['token']}"},
    )
    try:
        with request.urlopen(req, timeout=120) as resp:
            return resp.read()
    except error.HTTPError as e:
        body = e.read().decode("utf-8", errors="replace")[:200]
        if e.code == 404:
            print("[info] PA has no imported history for this tenant yet.")
            print("       Either Path D wasn't run, or sync is still in progress.")
            sys.exit(2)
        sys.exit(f"HTTP {e.code}: {body}")


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--endpoint", help="PA host (overrides config file)")
    ap.add_argument("--token", help="PA user Bearer token (overrides config file)")
    ap.add_argument("--owner-name", required=True,
                    help="Display name to write as 'me' in exported .txt files. "
                         "MUST match downstream whatsapp-export-parser.py --owner-name.")
    ap.add_argument("--output", type=Path, required=True)
    args = ap.parse_args()

    cfg = load_config(args)
    missing = [k for k in ("endpoint", "token") if k not in cfg]
    if missing:
        sys.exit(f"Missing config: {missing}. See script docstring.")

    args.output.mkdir(parents=True, exist_ok=True)

    print(f"[info] Fetching from {cfg['endpoint']} ...")
    zip_bytes = fetch(cfg, args.owner_name)
    print(f"[info] Received {len(zip_bytes) // 1024} KiB ZIP")

    written = 0
    with zipfile.ZipFile(io.BytesIO(zip_bytes)) as zf:
        for name in zf.namelist():
            data = zf.read(name)
            out_path = args.output / name
            out_path.write_bytes(data)
            written += 1

    print(f"[ok]  Wrote {written} chat files to {args.output}")
    print("Next: run scripts/whatsapp-export-parser.py with the same --owner-name")
    print(f"      python scripts/whatsapp-export-parser.py --input {args.output} \\")
    print(f"          --output ./parsed --owner-name '{args.owner_name}' --salt <salt>")


if __name__ == "__main__":
    main()
