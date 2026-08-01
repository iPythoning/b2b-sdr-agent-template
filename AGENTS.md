# AGENTS.md — b2b-sdr-agent-template

> 本文件是本仓库的**唯一权威协作守则**，对所有厂商的 coding agent（Claude Code / Codex / Cursor / Gemini / Windsurf / Kimi 等）一视同仁。
> CLAUDE.md、GEMINI.md、.cursorrules 等厂商文件只是指向本文件的指针；冲突时以本文件为准。

## 项目速览

- 技术栈：Node.js
- 远程：https://github.com/iPythoning/b2b-sdr-agent-template.git

（项目职责与架构说明待补充）

## 开始工作前：接续三步（必做）

1. 按固定顺序阅读：`README* → AGENTS.md → docs/HANDOFF.md → docs/adr/ → git log -10 --oneline`
2. 先跑一次下方验证命令，确认基线是绿的。**基线红 → 先修基线，绝不在红基线上叠改动。**
3. 用自己的话复述当前任务与验收标准，确认与 HANDOFF 一致后再动手。

## 结束工作前：收尾三件套（必做）

1. 跑完整验证命令，确认全绿。
2. 更新 `docs/HANDOFF.md`：当前目标 / 已完成 / 进行中（含文件与位置）/ 已知坑 / 下一步 / 验证方式。
3. 提交 git：**不留未提交的半成品**；commit message 用 Conventional Commits 并写清"为什么"。

## 验证命令（共同基线）

- 测试：`npm test`

如命令变更，必须同步更新本节——这是所有 agent 的共同基线。

## 决策记录（ADR）

- 任何"为什么这么改"的架构 / 方案决策，写入 `docs/adr/`，格式见 `docs/adr/0000-template.md`。
- 对话里想通但没落盘的决策，等于没发生过。

## Git 纪律

- **禁止 `git add -A`**：只用 `git add -u` 或逐文件 `git add <path>`；新文件必须显式 add。
- commit 前 `git diff --stat` 确认无意外的 Dockerfile / nginx.conf / docker-compose.yml 变更；基础设施文件单独 commit。
- 小步提交，一个 commit 只做一件事；一个任务一个分支。

## 反模式（禁止）

- ❌ 把关键上下文写进 `.claude/`、`.cursor/` 等厂商私有目录
- ❌ 依赖对话摘要 / 上下文压缩传递状态
- ❌ 在测试红的状态下继续叠新功能
- ❌ 一次性做超出"半天能讲完"粒度的任务再交接
