# B2B SDR Agent 模板

> 5 分钟，让任何 B2B 外贸企业拥有 AI 销售代表。

一套开源、生产就绪的 AI SDR（销售开发代表）模板，覆盖**完整销售管线** — 从线索获取到成交 — 支持 WhatsApp、Telegram 和邮件。

基于 [OpenClaw](https://openclaw.dev) 构建，已在真实外贸企业验证。

**🌐 [English](./README.md) | 中文 | [Español](./README.es.md) | [Français](./README.fr.md) | [العربية](./README.ar.md) | [Português](./README.pt-BR.md) | [日本語](./README.ja.md) | [Русский](./README.ru.md)**

---

## 架构：7 层上下文系统

```
┌─────────────────────────────────────────────┐
│              AI SDR Agent                    │
├─────────────────────────────────────────────┤
│  IDENTITY.md   → 我是谁？公司、角色         │
│  SOUL.md       → 人格、价值观、底线         │
│  AGENTS.md     → 全链路销售工作流（8阶段）   │
│  USER.md       → 负责人画像、ICP、评分       │
│  HEARTBEAT.md  → 自动化 Pipeline 巡检       │
│  MEMORY.md     → 三层记忆架构               │
│  TOOLS.md      → CRM、渠道、集成            │
├─────────────────────────────────────────────┤
│  Skills        → 可扩展能力                 │
│  产品知识库     → 你的产品目录               │
├─────────────────────────────────────────────┤
│  OpenClaw Gateway (WhatsApp / Telegram)     │
└─────────────────────────────────────────────┘
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

### 全链路销售自动化

| 阶段 | AI 做什么 |
|------|----------|
| **线索获取** | 自动识别入站消息，创建 CRM 记录，提取关键信息 |
| **BANT 筛选** | 通过自然对话评估预算、决策权、需求、时间线 |
| **背调研究** | 搜索客户公司、LinkedIn、新闻 — 更新 ICP 评分 |
| **报价** | 生成报价单，发给负责人审批，确认后发给客户 |
| **谈判** | 记录每轮还价，推荐策略，超出授权时升级 |
| **汇报** | 每日 Pipeline 报表、停滞预警、周报 |
| **养育** | 自动跟进、行业资讯、售后关怀 |

### 拟人化对话
- 自动检测并用客户语言回复
- delivery-queue 技能实现自然消息节奏
- 文化适配（中东、非洲、东南亚、拉美、欧洲）
- 绝不暴露 AI 身份 — 以你的销售顾问名义沟通

### 智能记忆
- **热记忆**：公司上下文，每次会话加载
- **温记忆**：每日对话日志，按需加载
- **冷记忆**：归档洞察，向量数据库检索

## 7 层详解

| 层 | 文件 | 用途 |
|----|------|------|
| **身份层** | `IDENTITY.md` | 公司信息、角色定义、Pipeline 状态、线索分层 |
| **灵魂层** | `SOUL.md` | AI 人格、沟通风格、底线、成长机制 |
| **操作层** | `AGENTS.md` | 8 阶段销售工作流、BANT 筛选、安全策略 |
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

## 部署

### 前置条件
- Linux 服务器（推荐 Ubuntu 20.04+）
- Node.js 18+
- AI 模型 API Key（OpenAI、Anthropic、Google、Kimi 等）
- WhatsApp Business 账号（可选但推荐）

### 托管部署

不想自己搭？**[PulseAgent](https://ai.pulseagent.io)** 提供全托管 B2B AI SDR 服务：
- 一键部署
- 管理后台 & 数据分析
- 多渠道管理
- 优先技术支持

[立即体验 →](https://ai.pulseagent.io)

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
  由 <a href="https://ai.pulseagent.io">PulseAgent</a> 用心打造<br/>
  <em>Context as a Service — B2B 外贸 AI SDR</em>
</p>
