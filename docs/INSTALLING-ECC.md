# Installing ECC

[ECC](https://github.com/affaan-m/ECC) is an agent harness for Claude Code that
ships 60 agents, 232 skills, hooks, language rules, and MCP configs. This guide
shows the three supported installation paths and how to use the wrapper script
in `scripts/install-ecc.sh`.

> Requirements: Claude Code CLI v2.1.0+, Node.js, git.

> **Do not stack methods.** The most common broken setup is `/plugin install`
> followed by `install.sh --profile full`. Pick one path.

---

## Option 1 — Plugin install (recommended)

Run inside Claude Code:

```text
/plugin marketplace add https://github.com/affaan-m/ECC
/plugin install ecc@ecc
```

Plugins cannot distribute rule files. After installing, copy the rules you want:

```bash
git clone --depth 1 https://github.com/affaan-m/ECC.git /tmp/ecc
mkdir -p ~/.claude/rules/ecc
cp -R /tmp/ecc/rules/common      ~/.claude/rules/ecc/
cp -R /tmp/ecc/rules/typescript  ~/.claude/rules/ecc/   # pick your stack
```

---

## Option 2 — Wrapper script (this repo)

`scripts/install-ecc.sh` clones ECC into `~/.cache/ecc`, runs `npm install`, and
invokes the upstream installer.

```bash
./scripts/install-ecc.sh                       # profile=core, target=claude
./scripts/install-ecc.sh --profile minimal     # no hooks runtime
./scripts/install-ecc.sh --profile full        # everything, all language rules
./scripts/install-ecc.sh --dir /opt/ecc        # custom checkout location
```

Extra flags are forwarded to the upstream installer, e.g.:

```bash
./scripts/install-ecc.sh --profile core --without baseline:hooks
./scripts/install-ecc.sh --target claude --modules hooks-runtime
```

---

## Option 3 — Manual install

```bash
git clone https://github.com/affaan-m/ECC.git
cd ECC
npm install
./install.sh --profile full         # macOS / Linux
# .\install.ps1 --profile full      # Windows PowerShell
# npx ecc-install --profile full    # cross-platform alternative
```

---

## Profiles

| Profile   | Contents                                                  | Use case                          |
|-----------|-----------------------------------------------------------|-----------------------------------|
| `minimal` | rules, agents, commands, skills (no hooks)                | low-context, no automation        |
| `core`    | standard components + hooks                               | default                           |
| `full`    | everything including all language rules                   | complete install                  |

---

## Verifying the install

After install, these should exist:

```bash
ls ~/.claude/agents     ~/.claude/skills     ~/.claude/commands
ls ~/.claude/hooks      ~/.claude/rules/ecc  # rules only after manual copy
```

In Claude Code, `/plugin` lists installed plugins; `/help` should show new
commands contributed by ECC.

---

## Uninstall / reset

If you stacked installs by accident, use ECC's uninstall script:

```bash
node ~/.cache/ecc/scripts/uninstall.js --dry-run   # preview
node ~/.cache/ecc/scripts/uninstall.js             # remove ECC-managed files
```

---

## Notes for this repo

- This template runs on remote ephemeral containers (Claude Code on the web).
  ECC components installed into `~/.claude/` in a remote session are wiped when
  the container is reclaimed. Install ECC on the workstation where you run the
  Claude Code CLI, not inside a session container.
- If you want ECC available in CI or web sessions, install it from a
  `SessionStart` hook — see `skills/session-start-hook` for the pattern.
