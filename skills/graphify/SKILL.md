---
name: graphify
description: "Knowledge graph engine for B2B sales intelligence. Builds queryable graphs from product catalogs, customer conversations, and market research. Powered by graphify."
---

# Graphify — Sales Intelligence Knowledge Graph

Build knowledge graphs from your product catalog, customer conversations, and market research to surface hidden connections, cross-sell opportunities, and competitive insights.

Based on [graphify](https://github.com/safishamsi/graphify) — adapted for B2B SDR context.

## Triggers

- Manual: "Build a knowledge graph of our products"
- Manual: "Map customer relationships"
- Manual: "Analyze competitive landscape"
- Cron (optional): Weekly rebuild after lead-discovery updates

## Prerequisites

```bash
# Ensure graphify is installed
python3 -c "import graphify" 2>/dev/null || pip install graphifyy -q --break-system-packages 2>&1 | tail -3
```

## Use Cases

### 1. Product Catalog Graph

Build a graph from `product-kb/` to understand product relationships, shared certifications, overlapping target markets, and cross-sell paths.

**When to use:** Before quotation, during BANT qualification, when customer asks about related products.

```bash
python3 -c "
import json
from graphify.extract import collect_files, extract
from graphify.build import build
from graphify.cluster import cluster, score_all
from graphify.analyze import god_nodes, surprising_connections
from pathlib import Path

# Extract from product catalog
files = collect_files(Path('product-kb'))
ast_result = extract(files)

# Build and analyze
G = build([ast_result])
communities, labels = cluster(G)
cohesion = score_all(G, communities)

gods = god_nodes(G, top_n=5)
surprises = surprising_connections(G, communities, top_n=5)

print('=== Core Products (God Nodes) ===')
for g in gods:
    print(f'  {g[\"label\"]} — {g[\"edges\"]} connections')

print('=== Surprising Connections ===')
for s in surprises:
    print(f'  {s[\"source\"]} ↔ {s[\"target\"]} [{s[\"confidence\"]}]')
"
```

**Sales actions from graph insights:**
- God nodes = your anchor products → lead with these in cold outreach
- Surprising connections = non-obvious cross-sell paths → "customers who buy X often need Y"
- Communities = product families → bundle pricing opportunities

### 2. Customer Intelligence Graph

Build a graph from conversation histories and CRM data to map customer relationships, identify buying patterns, and find warm introduction paths.

**Input sources:**
- ChromaDB conversation history (`chroma:recall`)
- CRM records (Google Sheets)
- Supermemory research notes (`memory:search`)

**What to extract (semantic, not AST):**
- Companies → employees (decision makers, influencers)
- Companies → products they bought or inquired about
- Companies → companies (same industry, same region, competitors)
- People → people (referrals, shared contacts)
- Deals → products, timelines, objections

**Sales actions from graph insights:**
- Cluster customers by behavior → tailor nurture campaigns per cluster
- Find bridge nodes (customers who connect segments) → referral candidates
- Detect isolated nodes (customers with no follow-up) → stalled lead recovery

### 3. Market Research Graph

Build a graph from lead-discovery research, competitor intel, and market signals stored in Supermemory.

**What to extract:**
- Competitors → products, pricing, markets
- Markets → trends, regulations, trade shows
- Customers → competitors they also buy from
- Regions → seasonal demand patterns

**Sales actions from graph insights:**
- Surprising connections between markets → expansion opportunities
- Competitor clusters → differentiation strategy
- Market god nodes → priority regions for lead-discovery rotation

## Graph Query (runtime)

After building a graph, query it for specific sales intelligence:

```bash
# BFS — broad context around a topic
python3 -m graphify query "hydraulic excavator certification" --budget 1500

# DFS — trace a specific relationship chain
python3 -m graphify query "Dubai customer fleet" --dfs --budget 1000
```

**Use before:**
- Responding to product questions → query product graph for specs and relationships
- Preparing quotations → find cross-sell opportunities in graph
- Cold outreach → understand prospect's market context from research graph

## Graph Export

```bash
python3 -c "
from graphify.export import to_json, to_html
from graphify.build import build_from_json
from pathlib import Path
import json

data = json.loads(Path('graphify-out/graph.json').read_text())
G = build_from_json(data)

# Interactive HTML for owner dashboard
to_html(G, Path('graphify-out/graph.html'))

# JSON for programmatic access
to_json(G, Path('graphify-out/graph.json'))
"
```

- **HTML**: Interactive vis.js graph — share with owner for pipeline visibility
- **JSON**: Machine-readable — feed into reporting or CRM enrichment
- **Report**: `graphify-out/GRAPH_REPORT.md` — god nodes, communities, knowledge gaps

## Output Format (report to owner)

```
Product Knowledge Graph:
- X nodes · Y edges · Z communities
- Core products: [god nodes list]
- Cross-sell opportunities: [surprising connections]
- Knowledge gaps: [isolated products with missing specs]

Recommendation: Update product-kb for [gap products] to improve graph coverage.
```

## Integration with Other Skills

| Skill | How Graphify Helps |
|-------|-------------------|
| **lead-discovery** | Query market graph before searching → better targeting |
| **quotation-generator** | Query product graph → include related products in quote |
| **chroma-memory** | Feed conversation data → build customer intelligence graph |
| **supermemory** | Feed research notes → build market research graph |
| **sdr-humanizer** | Graph context → more relevant, personalized conversations |

## Rebuild Strategy

- **Product graph**: Rebuild when `product-kb/` changes (new products, updated specs)
- **Customer graph**: Rebuild weekly from ChromaDB + CRM snapshots
- **Market graph**: Rebuild after lead-discovery runs (daily 10:00 output)

Store graphs in `graphify-out/` — survives across sessions, queryable anytime.
