# Contributing to B2B SDR Agent Template

Thanks for your interest in contributing! This guide will help you get started.

## How to Contribute

### Reporting Bugs

Open a [GitHub Issue](https://github.com/iPythoning/b2b-sdr-agent-template/issues) with:
- Steps to reproduce
- Expected vs actual behavior
- Your environment (OS, Node.js version, OpenClaw version)

### Suggesting Features

Open an issue with the `enhancement` label. Describe your use case and why it would benefit B2B export businesses.

### Submitting Changes

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Make your changes
4. Run the template validation: `npm test`
5. Test with at least one industry example (`examples/`) when changing workspace prompts or product data
6. Commit with a clear message: `git commit -m "feat: add FOB calculator to quotation-generator"`
7. Push and open a Pull Request

### Code Style

- Shell scripts: Follow existing style, use `set -euo pipefail`, quote all variables
- Markdown workspace files: Keep instructions clear and actionable for AI agents
- JSON configs: Validate with `jq` before committing
- Skills (Node.js): ESM modules, no external dependencies unless necessary

### Commit Messages

Use [Conventional Commits](https://www.conventionalcommits.org/):
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation
- `refactor:` Code change that neither fixes a bug nor adds a feature
- `security:` Security improvement

### What We're Looking For

- New industry examples (beyond heavy vehicles, electronics, textiles)
- Skill improvements (better memory, smarter lead scoring)
- Deployment hardening (rollback, health checks)
- Translation improvements
- Security enhancements

## Development Setup

```bash
git clone https://github.com/iPythoning/b2b-sdr-agent-template.git
cd b2b-sdr-agent-template

# Test deployment (dry-run)
cp deploy/config.sh.example deploy/config.sh
# Edit config.sh with your settings
./deploy/deploy.sh test-client --dry-run

# Template smoke tests
npm test
```

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
