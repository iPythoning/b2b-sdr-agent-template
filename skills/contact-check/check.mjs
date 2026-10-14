#!/usr/bin/env node
// contact-check: ask Precleared whether a cold email to one address is allowed.
//
// Usage:
//   node check.mjs --email buyer@company.de --source published [--pitch "..."] \
//     [--country DE] [--sender GB|US] [--existing-customer] [--dry-run]
//
// Prints one JSON object. Exit codes, so scripts can gate on the result:
//   0  ok_to_email (send, with a footer that meets footer_text), or the check is switched off
//   2  do not send: consent_needed, blocked or unknown
//   3  check unavailable: network error, daily limit, bad key or an unexpected response (try again later)
//   1  usage error
//
// Env: PRECLEARED_SENDER_COUNTRY (GB or US). The check is off until this is set.
//      PRECLEARED_API_KEY (optional, free key at https://precleared.dev/get-key).

import { realpathSync } from "node:fs";
import { pathToFileURL } from "node:url";

const API_URL = process.env.PRECLEARED_API_URL || "https://precleared.dev/api/v1/check";
const SOURCES = ["published", "bought", "scraped", "given", "unknown"];
const SENDERS = ["GB", "US"];
const VERDICTS = ["ok_to_email", "consent_needed", "blocked", "unknown"];
const TIMEOUT_MS = 30000;

export function parseArgs(argv) {
  const opts = { existingCustomer: false, dryRun: false };
  for (let i = 0; i < argv.length; i++) {
    const arg = argv[i];
    const next = () => {
      const value = argv[++i];
      if (value === undefined || value.startsWith("--")) throw new Error(`Missing value for ${arg}`);
      return value;
    };
    if (arg === "--email") opts.email = next();
    else if (arg === "--source") opts.source = next();
    else if (arg === "--pitch") opts.pitch = next();
    else if (arg === "--country") opts.country = next();
    else if (arg === "--sender") opts.sender = next();
    else if (arg === "--existing-customer") opts.existingCustomer = true;
    else if (arg === "--dry-run") opts.dryRun = true;
    else throw new Error(`Unknown option: ${arg}`);
  }
  return opts;
}

export function senderFrom(opts, env = process.env) {
  return (opts.sender || env.PRECLEARED_SENDER_COUNTRY || "").trim().toUpperCase();
}

export function buildPayload(opts, sender) {
  const email = (opts.email || "").trim();
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) throw new Error("--email must be a full email address");
  const source = (opts.source || "").trim().toLowerCase();
  if (!SOURCES.includes(source)) throw new Error(`--source must be one of: ${SOURCES.join(", ")}`);
  if (!SENDERS.includes(sender)) throw new Error("--sender (or PRECLEARED_SENDER_COUNTRY) must be GB or US");
  const payload = {
    recipient_email: email,
    sender_country: sender,
    address_source: source,
    existing_customer: Boolean(opts.existingCustomer),
  };
  if (opts.pitch) payload.pitch = opts.pitch.trim().slice(0, 200);
  if (opts.country) {
    const country = opts.country.trim().toUpperCase();
    if (!/^[A-Z]{2}$/.test(country)) throw new Error("--country must be a two-letter code, e.g. DE");
    payload.recipient_country = country;
  }
  return payload;
}

const isObject = (value) => Boolean(value) && typeof value === "object" && !Array.isArray(value);
const text = (value) => (typeof value === "string" && value.trim() ? value.trim() : null);

export function summarise(status, body) {
  // Only a JSON object with a known verdict counts as an answer. Anything else means the check
  // could not be made (exit 3), so a stray response is never read as a verdict.
  if (status === 200 && isObject(body) && VERDICTS.includes(body.verdict)) {
    const first = Array.isArray(body.reasons) ? body.reasons[0] : null;
    const reason = isObject(first) ? first : {};
    return {
      exitCode: body.verdict === "ok_to_email" ? 0 : 2,
      result: {
        verdict: body.verdict,
        send: body.verdict === "ok_to_email",
        rule: text(reason.text) || text(reason.note),
        source: text(reason.source_title),
        footer_text: text(body.footer_text),
        next_step: text(body.next_step),
        receipt_id: isObject(body.receipt) ? text(body.receipt.id) : null,
      },
    };
  }
  const error = isObject(body) ? body : {};
  return {
    exitCode: 3,
    result: {
      verdict: null,
      send: false,
      error: text(error.error) || (status === 200 ? "unexpected_response" : `http_${status}`),
      message: text(error.message) || "Precleared could not answer. Do not send; try again later.",
      get_key_url: text(error.get_key_url),
    },
  };
}

async function main() {
  let payload;
  let opts;
  let sender;
  try {
    opts = parseArgs(process.argv.slice(2));
    sender = senderFrom(opts);
    payload = buildPayload(opts, sender || "GB");
  } catch (err) {
    console.log(JSON.stringify({ error: "usage", message: err.message }));
    return 1;
  }
  if (!sender) {
    console.log(
      JSON.stringify({
        skipped: true,
        send: true,
        message: "contact-check is off. Set PRECLEARED_SENDER_COUNTRY to GB or US in .secrets/env to turn it on.",
      }),
    );
    return 0;
  }
  if (opts.dryRun) {
    console.log(JSON.stringify({ dry_run: true, url: API_URL, payload }));
    return 0;
  }

  const headers = { "Content-Type": "application/json", "User-Agent": "b2b-sdr-agent-template" };
  if (process.env.PRECLEARED_API_KEY) headers.Authorization = `Bearer ${process.env.PRECLEARED_API_KEY}`;

  let status = 0;
  let body = null;
  try {
    const res = await fetch(API_URL, {
      method: "POST",
      headers,
      body: JSON.stringify(payload),
      signal: AbortSignal.timeout(TIMEOUT_MS),
    });
    status = res.status;
    body = await res.json().catch(() => null);
  } catch (err) {
    body = { error: "unreachable", message: `Precleared unreachable: ${err.message}` };
  }

  const { exitCode, result } = summarise(status, body);
  console.log(JSON.stringify(result));
  return exitCode;
}

const invokedDirectly =
  Boolean(process.argv[1]) && import.meta.url === pathToFileURL(realpathSync(process.argv[1])).href;

if (invokedDirectly) {
  main().then((code) => {
    process.exitCode = code;
  });
}
