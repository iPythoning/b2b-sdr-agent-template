#!/usr/bin/env node
/**
 * chroma-memory — Per-Turn Conversation Memory (L3 + L4)
 *
 * L3: Store every conversation turn with customer_id isolation
 * L4: Daily CRM snapshot to ChromaDB as fallback
 *
 * Usage:
 *   node chroma.mjs store --customer <id> --turn <n> --user <msg> --agent <msg> [--stage <s>] [--topic <t>]
 *   node chroma.mjs search <query> [--customer <id>] [--limit <n>]
 *   node chroma.mjs recall <customer_id> [--limit <n>]
 *   node chroma.mjs snapshot
 *   node chroma.mjs stats
 */

import { readFileSync, writeFileSync, existsSync, mkdirSync, readdirSync } from 'fs';
import { join } from 'path';
import { createHash } from 'crypto';

const CHROMA_DIR = join(
  process.env.OPENCLAW_HOME || join(process.env.HOME, '.openclaw'),
  'memory', 'chroma'
);

if (!existsSync(CHROMA_DIR)) mkdirSync(CHROMA_DIR, { recursive: true });

// ─── Auto-tagging patterns ─────────────────────────────────
const TAG_PATTERNS = {
  has_quote: /\b(price|cost|quote|quotation|pricing|discount|usd|eur|\$|€|fob|cif|exw)\b/i,
  has_commitment: /\b(i will|we will|i('ll| shall)|promise|commit|send you|get back|tomorrow|by \w+day)\b/i,
  has_objection: /\b(too expensive|too high|not interested|competitor|cheaper|can't afford|don't need|too slow)\b/i,
  has_order: /\b(place.?order|confirm.?order|proceed|purchase|buy|payment|deposit|invoice)\b/i,
  has_sample: /\b(sample|prototype|trial|test unit|demo)\b/i,
};

function autoTag(userMsg, agentMsg) {
  const combined = `${userMsg} ${agentMsg}`;
  const tags = {};
  for (const [tag, pattern] of Object.entries(TAG_PATTERNS)) {
    tags[tag] = pattern.test(combined);
  }
  return tags;
}

// ─── Core Functions ─────────────────────────────────────────

function storeTurn({ customer, turn, user, agent, stage, topic }) {
  const timestamp = new Date().toISOString();
  const tags = autoTag(user, agent);
  const id = createHash('sha256')
    .update(`${customer}_${turn}_${timestamp}`)
    .digest('hex')
    .slice(0, 16);

  const doc = {
    id,
    customer_id: customer,
    turn_number: parseInt(turn),
    timestamp,
    user_message: user,
    agent_response: agent,
    stage: stage || 'unknown',
    topic: topic || 'general',
    ...tags,
    text: `[${customer}] [Turn ${turn}] [${stage || 'unknown'}]\nCustomer: ${user}\nAgent: ${agent}`,
  };

  const customerDir = join(CHROMA_DIR, sanitize(customer));
  if (!existsSync(customerDir)) mkdirSync(customerDir, { recursive: true });
  writeFileSync(join(customerDir, `${id}.json`), JSON.stringify(doc, null, 2));

  const activeTags = Object.entries(tags).filter(([, v]) => v).map(([k]) => k);
  console.log(`Stored turn ${turn} for ${customer} [${activeTags.join(', ') || 'no tags'}]`);
  return id;
}

function search(query, customer, limit = 5) {
  const queryWords = query.toLowerCase().split(/\s+/);
  const results = [];
  const dirs = customer
    ? [join(CHROMA_DIR, sanitize(customer))]
    : readdirSync(CHROMA_DIR, { withFileTypes: true })
        .filter(d => d.isDirectory())
        .map(d => join(CHROMA_DIR, d.name));

  for (const dir of dirs) {
    if (!existsSync(dir)) continue;
    for (const file of readdirSync(dir).filter(f => f.endsWith('.json'))) {
      try {
        const doc = JSON.parse(readFileSync(join(dir, file), 'utf-8'));
        if (doc.type === 'crm_snapshot') continue; // skip snapshots in search
        const textLower = doc.text.toLowerCase();
        const score = queryWords.reduce((s, w) => s + (textLower.includes(w) ? 1 : 0), 0);
        // Boost tagged turns
        if (doc.has_quote) score + 0.5;
        if (doc.has_commitment) score + 0.5;
        if (score > 0) results.push({ ...doc, score });
      } catch { /* skip */ }
    }
  }

  return results.sort((a, b) => b.score - a.score).slice(0, limit);
}

function recall(customer, limit = 10) {
  const dir = join(CHROMA_DIR, sanitize(customer));
  if (!existsSync(dir)) {
    console.log(`No history for ${customer}`);
    return [];
  }

  const docs = [];
  for (const file of readdirSync(dir).filter(f => f.endsWith('.json'))) {
    try {
      const doc = JSON.parse(readFileSync(join(dir, file), 'utf-8'));
      if (doc.type !== 'crm_snapshot') docs.push(doc);
    } catch { /* skip */ }
  }

  return docs
    .sort((a, b) => new Date(b.timestamp) - new Date(a.timestamp))
    .slice(0, limit);
}

function snapshot() {
  // Store a CRM snapshot marker — actual CRM data is read by the agent
  const timestamp = new Date().toISOString();
  const date = timestamp.split('T')[0];
  const id = `snapshot_${date}`;
  const doc = {
    id,
    type: 'crm_snapshot',
    timestamp,
    note: 'Daily CRM pipeline snapshot. Agent reads CRM via gws skill and stores summary here.',
  };

  writeFileSync(join(CHROMA_DIR, `${id}.json`), JSON.stringify(doc, null, 2));
  console.log(`CRM snapshot marker created: ${id}`);
}

function stats() {
  let totalTurns = 0;
  let totalSnapshots = 0;
  const customerCounts = {};
  const tagCounts = { has_quote: 0, has_commitment: 0, has_objection: 0, has_order: 0, has_sample: 0 };

  const dirs = readdirSync(CHROMA_DIR, { withFileTypes: true });
  for (const entry of dirs) {
    if (entry.isDirectory()) {
      const dir = join(CHROMA_DIR, entry.name);
      const files = readdirSync(dir).filter(f => f.endsWith('.json'));
      customerCounts[entry.name] = files.length;
      for (const file of files) {
        try {
          const doc = JSON.parse(readFileSync(join(dir, file), 'utf-8'));
          totalTurns++;
          for (const tag of Object.keys(tagCounts)) {
            if (doc[tag]) tagCounts[tag]++;
          }
        } catch { /* skip */ }
      }
    } else if (entry.name.startsWith('snapshot_')) {
      totalSnapshots++;
    }
  }

  console.log(`=== ChromaDB Memory Stats ===`);
  console.log(`Total turns stored: ${totalTurns}`);
  console.log(`Total snapshots: ${totalSnapshots}`);
  console.log(`Customers tracked: ${Object.keys(customerCounts).length}`);
  console.log(`\nPer-customer:`);
  for (const [c, n] of Object.entries(customerCounts).sort((a, b) => b[1] - a[1]).slice(0, 10)) {
    console.log(`  ${c}: ${n} turns`);
  }
  console.log(`\nTag distribution:`);
  for (const [tag, count] of Object.entries(tagCounts)) {
    console.log(`  ${tag}: ${count}`);
  }
}

function sanitize(str) {
  return str.replace(/[^a-zA-Z0-9_+-]/g, '_');
}

// ─── CLI Parser ─────────────────────────────────────────────
function parseArgs(args) {
  const parsed = {};
  for (let i = 0; i < args.length; i++) {
    if (args[i].startsWith('--') && i + 1 < args.length) {
      parsed[args[i].slice(2)] = args[++i];
    } else if (!parsed._positional) {
      parsed._positional = args[i];
    }
  }
  return parsed;
}

const [,, command, ...args] = process.argv;
const opts = parseArgs(args);

switch (command) {
  case 'store':
    storeTurn(opts);
    break;
  case 'search':
    console.log(JSON.stringify(search(opts._positional || args[0], opts.customer, parseInt(opts.limit) || 5), null, 2));
    break;
  case 'recall':
    console.log(JSON.stringify(recall(opts._positional || args[0], parseInt(opts.limit) || 10), null, 2));
    break;
  case 'snapshot':
    snapshot();
    break;
  case 'stats':
    stats();
    break;
  default:
    console.log('Usage: chroma.mjs <store|search|recall|snapshot|stats> [args]');
}
