# B2B SDR Agent 模板

> 5 分钟，让任何 B2B 外贸企业拥有 AI 销售代表。

一套开源、生产就绪的 AI SDR（销售开发代表）模板，覆盖**完整销售管线** — 从线索获取到成交 — 支持 WhatsApp、Telegram 和邮件。

基于 [OpenClaw](https://openclaw.dev) 构建，已在真实外贸企业验证。

> 🚀 **最新 · 2026-05-02** — **OpenClaw v2026.5.2**：ClawHub 插件管理中心上线（含诊断工具与审计记录），WhatsApp 精准触达细分路由更可靠，会话操作在 10,000+ 并发时保持稳定，200+ 项跨渠道与供应商修复落地。[查看完整更新日志 →](./CHANGELOG.md)

**🌐 [English](./README.md) | 中文 | [Español](./README.es.md) | [Français](./README.fr.md) | [العربية](./README.ar.md) | [Português](./README.pt-BR.md) | [日本語](./README.ja.md) | [Русский](./README.ru.md)**

---

## 架构：7 层上下文系统

```
┌─────────────────────────────────────────────────┐
│              AI SDR Agent                       │
├─────────────────────────────────────────────────┤
│  IDENTITY.md   → 我是谁？公司、角色                │
│  SOUL.md       → 人格、价值观、底线                │
│  AGENTS.md     → 全链路销售工作流（10 阶段）        │
│  USER.md       → 负责人画像、ICP、评分             │
│  HEARTBEAT.md  → 13 项自动化 Pipeline 巡检        │
│  MEMORY.md     → 三引擎记忆架构                   │
│  TOOLS.md      → CRM、渠道、集成                  │
├─────────────────────────────────────────────────┤
│  Skills        → 可扩展能力                       │
│  产品知识库     → 你的产品目录                      │ 
│  Cron Jobs     → 13 个自动化定时任务               │
├─────────────────────────────────────────────────┤
│  OpenClaw Gateway (WhatsApp / Telegram / Email)  
└─────────────────────────────────────────────────┘
```

每一层都是一个 Markdown 文件，按你的业务定制。AI 每次对话都会加载全部 7 层，获得关于你公司、产品和销售策略的深度上下文。

## 快速开始

### 方式 A：OpenClaw 用户（一条命令）

如果你已经在运行 [OpenClaw](https://openclaw.dev)：

```bash
clawhub install b2b-sdr-agent
```

完成。Skill 会自动安装完整的 7 层上下文系统、delivery-queue 和 sdr-humanizer 到你的 workspace。然后定制：

```bash
# 编辑关键文件
vim ~/.openclaw/workspace/skills/b2b-sdr-agent/references/IDENTITY.md
vim ~/.openclaw/workspace/skills/b2b-sdr-agent/references/USER.md

# 或复制到主 workspace
cp ~/.openclaw/workspace/skills/b2b-sdr-agent/references/*.md ~/.openclaw/workspace/
```

把所有 `{{占位符}}` 替换成你的真实信息，AI SDR 即刻上线。

### 方式 B：完整部署（5 分钟）

#### 1. 克隆 & 配置

```bash
git clone https://github.com/iPythoning/b2b-sdr-agent-template.git
cd b2b-sdr-agent-template

# 编辑 7 个 workspace 文件，填入你的业务信息
vim workspace/IDENTITY.md   # 公司信息、角色、Pipeline
vim workspace/USER.md       # 产品、ICP、竞品
vim workspace/SOUL.md       # AI 人格和规则
```

#### 2. 配置部署参数

```bash
cd deploy
cp config.sh.example config.sh
vim config.sh               # 填入：服务器 IP、API Key、WhatsApp 号码
```

#### 3. 一键部署

```bash
./deploy.sh my-company

# 输出:
# ✅ 部署完成: my-company
# Gateway:  ws://your-server:18789
# WhatsApp: 已启用
# Skills:   b2b_trade (28 个)
```

完成。你的 AI SDR 已在 WhatsApp 上线，准备好卖货了。

## 功能概览

### 全链路销售自动化（10 阶段）

| 阶段 | AI 做什么 |
|------|----------|
| **1. 线索获取** | 自动识别入站消息（WhatsApp/Telegram/CTWA 广告），创建 CRM 记录 |
| **2. BANT 筛选** | 通过自然对话评估预算、决策权、需求、时间线 |
| **3. CRM 录入** | 结构化数据采集 — 姓名、公司、国家、ICP 评分、产品意向 |
| **4. 背调 & 充实** | Jina AI 网页搜索 + 公司官网分析，3 层充实管线 |
| **5. 报价** | 自动生成 PDF 报价单，多语言，发给负责人审批 |
| **6. 谈判** | 记录每轮还价，推荐策略，超出授权时升级 |
| **7. 汇报** | 每日 09:00 Pipeline 报表、15:00 停滞预警、周报 |
| **8. 养育** | 自动跟进、行业资讯、售后关怀、季度回访 |
| **9. 邮件开发** | 个性化冷开发信序列（Day 1/3/7/14），自动跟进 |
| **10. 多渠道协同** | 跨渠道协调（WhatsApp + Email + Telegram），自动切换 |

### 自动化定时任务（13 个 Cron Jobs）

| 时间 | 任务 |
|------|------|
| 每 30 分钟 | Gmail 收件箱扫描，检查客户回复 |
| 每日 09:00 | Pipeline 报告发送至 WhatsApp |
| 每日 10:00 | AI 主动获客（市场轮换：非洲/中东/东南亚/拉美） |
| 每日 11:00 | 邮件跟进序列检查 |
| 每日 15:00 | 停滞线索检测 |
| 每周三 | 养育活动 |
| 每周五 | 竞品情报收集 |
| 每周一 | 周报汇总 |

### 拟人化对话
- 自动检测并用客户语言回复
- delivery-queue 技能实现自然消息节奏（3-90 秒延迟，消息拆分）
- 时区感知发送（7 个市场时区映射）
- 文化适配（中东、非洲、东南亚、拉美、欧洲）
- 绝不暴露 AI 身份 — 以你的销售顾问名义沟通

### 动态 ICP 评分
- 初始分基于 5 个加权维度（采购量、产品匹配、区域、支付能力、决策权）
- **根据互动自动调整**：快速回复 +1、索要报价 +2、提及竞品 +2、7 天无回复 -1
- 热线索（ICP>=7）自动标记，立即通知负责人

### 智能记忆（3 引擎）
- **Supermemory**：研究笔记、竞品情报、市场洞察 — 外联前自动查询
- **MemoryLake**：会话上下文、对话摘要 — 按会话自动回忆
- **MemOS Cloud**：跨会话行为模式 — 自动捕获

### 4 层反失忆系统

AI 在长对话和跨会话时会丢失上下文。我们的 **4 层反失忆架构**确保 AI SDR 永不遗忘：

```
消息进入 ──→ L1 MemOS 自动召回（结构化记忆注入）
    │
    ├──→ L3 ChromaDB 逐轮存储（客户隔离，自动标签）
    │
    ├──→ L2 主动摘要：65% token 时压缩（haiku 压缩，零信息丢失）
    │
    └──→ L4 CRM 快照：每日 12:00（灾难恢复兜底）
```

| 层级 | 引擎 | 作用 |
|------|------|------|
| **L1: MemOS** | 结构化记忆 | 每轮提取 BANT、承诺、异议，对话开始时注入 System Prompt |
| **L2: 主动摘要** | Token 监控 | 上下文占用 65% 时通过 haiku 级模型压缩，数字、报价、承诺逐字保留 |
| **L3: ChromaDB** | 逐轮向量存储 | 每轮对话以 `customer_id` 隔离存储，自动标记报价、承诺、异议，支持跨会话语义检索 |
| **L4: CRM 快照** | 每日备份 | 每日 12:00 将完整 Pipeline 状态存入 ChromaDB 作为灾难恢复，任何层失败时 L4 兜底 |

**效果**：AI 业务员记住每个客户、每份报价、每个承诺 — 即使 100+ 轮对话、沉默数周或系统重启后。

> 完整实施规范见 **[ANTI-AMNESIA.md](./ANTI-AMNESIA.md)**，包含代码、Prompt 和部署指南。

## 7 层详解

| 层 | 文件 | 用途 |
|----|------|------|
| **身份层** | `IDENTITY.md` | 公司信息、角色定义、Pipeline 状态、线索分层 |
| **灵魂层** | `SOUL.md` | AI 人格、沟通风格、底线、成长机制 |
| **操作层** | `AGENTS.md` | 10 阶段销售工作流、BANT 筛选、多渠道协同 |
| **用户层** | `USER.md` | 负责人画像、产品线、ICP 评分、竞品 |
| **巡检层** | `HEARTBEAT.md` | 自动 Pipeline 巡检 — 新线索、停滞、数据质量 |
| **记忆层** | `MEMORY.md` | 三层记忆架构、SDR 有效原则 |
| **工具层** | `TOOLS.md` | CRM 命令、渠道配置、搜索、邮件 |

## Skills 技能

开箱即用的扩展能力：

| 技能 | 说明 |
|------|------|
| **delivery-queue** | 定时分段发送，模拟真人节奏。支持 drip campaign。 |
| **supermemory** | 语义记忆引擎。自动提取客户洞察，跨会话搜索。 |
| **sdr-humanizer** | 拟人化对话规则 — 节奏、文化适配、反模式。 |
| **lead-discovery** | AI 主动获客。网页搜索潜在买家，ICP 评估，自动录入 CRM。 |
| **chroma-memory** | 逐轮会话存储，客户隔离，自动标签，CRM 快照。 |
| **telegram-toolkit** | Bot 命令、行内键盘、大文件处理、Telegram 优先市场策略。 |
| **quotation-generator** | 自动生成 PDF 形式发票，公司信头，多语言支持。 |

### 技能预设包

| 预设 | 技能数 | 适用场景 |
|------|--------|---------|
| `b2b_trade` | 28 | 外贸 B2B 企业（默认） |
| `lite` | 16 | 快速启动、低量级 |
| `social` | 14 | 社媒驱动销售 |
| `full` | 40+ | 全部启用 |

## 行业示例

开箱即用的行业配置：

| 行业 | 目录 | 亮点 |
|------|------|------|
| **重型车辆** | `examples/heavy-vehicles/` | 卡车、工程机械、车队销售、非洲/中东市场 |
| **消费电子** | `examples/electronics/` | OEM/ODM、Amazon 卖家、样品驱动 |
| **纺织服装** | `examples/textiles/` | 可持续面料、GOTS 认证、欧美市场 |

使用示例：

```bash
cp examples/heavy-vehicles/IDENTITY.md workspace/IDENTITY.md
cp examples/heavy-vehicles/USER.md workspace/USER.md
# 然后根据你的具体业务定制
```

## 产品知识库

结构化产品目录，让 AI 生成准确的报价：

```
product-kb/
├── catalog.json                    # 产品目录：规格、MOQ、交期
├── products/
│   └── example-product/info.json   # 详细产品信息
└── scripts/
    └── generate-pi.js              # 形式发票生成器
```

## 控制面板

部署后，AI SDR 自带 Web 管理面板：

```
http://YOUR_SERVER_IP:18789/?token=YOUR_GATEWAY_TOKEN
```

面板功能：
- 实时 Bot 状态和 WhatsApp 连接状况
- 消息历史和会话列表
- Cron 任务执行状态
- 渠道健康监控

Token 在部署时自动生成并显示在输出中。请妥善保管 — 拥有 URL+Token 即拥有完全控制权限。

> **安全提示**：在 config.sh 中设置 `GATEWAY_BIND="loopback"` 可禁用远程面板访问。默认值为 `"lan"`（局域网可访问）。

## 部署

### 前置条件
- Linux 服务器（推荐 Ubuntu 20.04+）
- Node.js 18+
- AI 模型 API Key（OpenAI、Anthropic、Google、Kimi 等）
- WhatsApp Business 账号（可选但推荐）

### WhatsApp 配置

默认情况下，AI SDR 接受**所有 WhatsApp 联系人**的消息（`dmPolicy: "open"`）。这是销售代理的推荐设置 — 你希望每个潜在客户都能联系到你。

| 设置 | 值 | 含义 |
|------|---|------|
| `WHATSAPP_DM_POLICY` | `"open"`（默认） | 接受任何人的私信 |
| | `"allowlist"` | 仅接受 `ADMIN_PHONES` 的消息 |
| | `"pairing"` | 需要先配对码 |
| `WHATSAPP_GROUP_POLICY` | `"allowlist"`（默认） | 仅在白名单群组中回复 |

部署后修改，编辑服务器上的 `~/.openclaw/openclaw.json`：

```json
{
  "channels": {
    "whatsapp": {
      "dmPolicy": "open",
      "allowFrom": ["*"]
    }
  }
}
```

然后重启：`systemctl --user restart openclaw-gateway`

### WhatsApp IP 隔离（多租户）

在同一台服务器上运行多个 Agent 时，每个 Agent 需要唯一的出口 IP，让 WhatsApp 将其识别为独立设备，防止跨账户封号。

```bash
# 部署客户后，隔离其 WhatsApp IP：
./deploy/ip-isolate.sh acme-corp

# 或指定 SOCKS5 端口：
./deploy/ip-isolate.sh acme-corp 40010
```

**原理：**

```
                  ┌─ wireproxy :40001 → WARP Account A → CF IP-A
                  │    ↑
tenant-a ─────────┘    ALL_PROXY=socks5://host:40001

tenant-b ─────────┐    ALL_PROXY=socks5://host:40002
                  │    ↓
                  └─ wireproxy :40002 → WARP Account B → CF IP-B
```

每个租户获得：
- 一个专属免费 [Cloudflare WARP](https://1.1.1.1/) 账户
- 一个隔离的 [wireproxy](https://github.com/pufferffish/wireproxy) 实例（约 4MB 内存）
- 所有出站流量（包括 WhatsApp）使用唯一的 Cloudflare 出口 IP

部署时自动启用：在 `config.sh` 中设置 `IP_ISOLATE=true`。

### 托管部署

不想自己搭？**[PulseAgent](https://pulseagent.io/app)** 提供全托管 B2B AI SDR 服务：
- 一键部署
- 管理后台 & 数据分析
- 多渠道管理
- 优先技术支持

[立即体验 →](https://pulseagent.io/app)

## 贡献

欢迎贡献！我们特别需要：

- **行业模板**：为你的行业添加示例
- **Skills**：构建新能力
- **翻译**：将 workspace 模板翻译为其他语言
- **文档**：改善指南和教程

## 许可证

MIT — 随意使用。

---

<p align="center">
  由 <a href="https://pulseagent.io/app">PulseAgent</a> 用心打造<br/>
  <em>Context as a Service — B2B 外贸 AI SDR</em>
</p>
