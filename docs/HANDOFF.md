# 交接状态 · HANDOFF（b2b-sdr-agent-template）

> 任何 agent 开始工作前**必读**，结束工作前**必更新**。
> 本文件是当前任务状态的唯一权威来源；历史决策看 docs/adr/，历史变更看 git log。

## 项目速览

- 路径：`~/_projects_by_logic/01-paibao-pulseagent/b2b-sdr-agent-template`
- 技术栈：Node.js
- 远程：https://github.com/iPythoning/b2b-sdr-agent-template.git
- 当前分支：`main`
- 最后活动：2026-07-31

## 仓库速览（自动提取，供冷启动）






> 以下内容由 `agents-enrich-handoff.py` 从**本仓库文件**自动提取，只含事实，不含推测。
> 「当前目标 / 下一步」仍需人工填写——脚本无法知道你这轮要做什么。

### 这是什么

**We're live on Product Hunt!** → [PulseAgent B2B SDR Agent Skill](https://www.producthunt.com/products/b2b-sdr-agent?embed=true&utm_source=embed&utm_medium=post_embed) — Open-source AI SDR for WhatsApp, Email & Telegram. An upvote means the world to us 🙏

（package.json 描述：Open-source B2B AI SDR template for OpenClaw deployments.）

### 常用命令（来自 package.json / Makefile）

`npm test`

### 构建与部署设施

- CI workflow：`validate.yml`（Validate Template）

### 本仓库其他文档（接手时值得先扫一眼）

`docs/RUNNING-ON-KIMI.md`

### 目录与文件构成

顶层：`AGENTS.md`、`ANTI-AMNESIA.md`、`CHANGELOG.md`、`CHANGELOG.md.local`、`CLAUDE.md`、`CONTRIBUTING.md`、`GEMINI.md`、`LICENSE`、`README.ar.md`、`README.es.md`、`README.fr.md`、`README.ja.md`、`README.md`、`README.pt-BR.md`、`README.ru.md`、`README.zh-CN.md`　…

主要文件类型：`.md` × 74、`.json` × 65、`.sh` × 10、`.py` × 8、`.mjs` × 3、`.yml` × 2

## 如何验证（基线，动手前先跑一次）

- 测试：`npm test`

## 当前目标

> ⚠️ **待人工确认**：下次接手的 agent 请与用户确认本轮目标与验收标准后填写，不要凭猜测动手。

## 已完成（最近 10 次提交 · 自动生成于 2026-08-01）

- `4bc6bf078b` chore: add git-cliff changelog generation（2026-07-31）
- `22d0e447aa` fix: 13 篇微信队列草稿的相对链接改绝对 URL（draft/add 45166 invalid content 根因，二分定位确认）（2026-06-10）
- `deacd9858a` chore(sync): v2026.6.5 README announcement + blog published（2026-06-10）
- `38d9f8c1cf` chore(sync): no new release — wechat queue drain 20→13 (run #27)（2026-06-10）
- `b4b646f130` chore(sync): 2026-06-10 run — no new release, wechat queue 20 (403 persists)（2026-06-10）
- `8c4dbd65a2` chore(sync): no new release 2026-06-09 run8 + wechat queue update（2026-06-09）
- `a97093e8f7` chore(sync): no new release v2026.6.5 + wechat queue update (run 7)（2026-06-09）
- `723b36ee19` chore(sync): release v2026.6.5 + wechat queue update（2026-06-09）
- `e169d46d67` chore(sync): wechat queue drain run #25 — 19/19 still 403, no new release（2026-06-09）
- `40806abf20` chore(sync): 2026-06-09 run 6 — no new stable release, wechat queue 19→19（2026-06-09）

## 进行中 / 未提交改动（自动生成于 2026-08-01）

- 无未提交改动（工作区干净）

## 已知坑 / 注意事项

> 从跨会话记忆迁入。**凭据只写位置不写值。**

### ⚙️ 两种交付架构

**Container-per-Tenant（商业级，推荐）**：每租户 = 独立容器 + 独立 Gateway + 独立 API Key + 独立 WhatsApp 代理 IP。
- 隔离维度：进程 / 数据 / API Key / WhatsApp IP / 资源（768MB + 0.5 CPU）
- 容量：8GB VPS → 8-10 租户；16GB → 18-22 租户
- 端口约定：Gateway = `18800+N`，Proxy = `18900+N`

**单租户模式**：1 服务器 = 1 客户，systemd 部署，`deploy.sh` 仍支持。

### ⚠️ 47 上的 openclaw 与业务容器是两回事

47 上 openclaw 是**裸跑**的（npm 全局包 `/usr/lib/node_modules/openclaw` + systemd user service `openclaw-gateway.service`），Gateway **仅监听 `127.0.0.1:18789`**，不对外。

- 大量 crontab 任务依赖这个本地 gateway（memory-agent、astock-hunter、evomap、weekly_cleanup 等）—— **升级前先确认这些任务的影响**。
- 47 同时跑 portal / PA / bots 的 Docker 业务容器，**openclaw 与它们无依赖，可独立升级**。
- 升级：`npm install -g openclaw@latest` → `systemctl --user restart openclaw-gateway`。
- Gateway token 在服务器上，不落文档。

### ⚠️ 客户 VPS 供应商坑

advinservers / lisahost 这类小供应商**续费到账不会自动恢复被停的 VM**，必须登控制台手动 Start。续费后要验证机器真的起来了，别以为付了钱就好了。

## 下一步

（待补充）

## 最近交接记录

| 日期 | 操作者 | 摘要 |
|---|---|---|
| 2026-08-01 | agents-handoff.sh | 初始化交接状态（含真实 git 基线）|
