# Claude Environment Template

A sanitized template for a portable Claude Code home directory.

This repository is meant to be copied or cloned into `~/.claude` and then customized. It contains structure and example instructions, not personal session history.

## Install

```bash
git clone https://github.com/<your-user>/claude-env-temp.git ~/.claude
chmod +x ~/.claude/hooks/*.sh ~/.claude/bootstrap/*.sh
```

Then edit:

- `CLAUDE.md` — your universal preferences and constraints
- `AGENTS.md` — your model/agent coordination strategy
- `modules/*` — domain-specific rules, skills, agents, and commands
- `settings.json` — hook registration and local Claude settings

## Architecture

### Universal Core

Loaded every session:

- `CLAUDE.md`
- `AGENTS.md`
- `rules/`
- `agents/`
- `hooks/`

### Domain Modules

Activated per project through `.claude-modules`:

- `web`
- `quant`
- `study`

Each module can contain:

- `MODULE.md`
- `rules/`
- `agents/`
- `skills/`
- `commands/`

### Project Bootstrap

Use the bootstrap script to initialize project-local coordination files:

```bash
~/.claude/bootstrap/init-project.sh "$HOME/Projects/NewProject" --modules web,study
```

Creates:

- `Coordination/HANDOFF.md`
- `Coordination/DECISIONS.md`
- `Coordination/CHANGELOG.md`
- `Coordination/PHASE_STATUS.md`
- `tasks/todo.md`
- project-local `CLAUDE.md`
- `.claude-modules`
- `.gitignore`

## Privacy Model

The `.gitignore` uses a whitelist approach. It tracks only the template structure and ignores private runtime state by default:

- session transcripts
- history files
- caches
- plugin data
- per-machine state
- local secrets

Still, review your own diff before publishing. Never commit credentials or private project context.

## Customization Guidance

Use this repo as a starting point. Replace placeholders with your own durable preferences, but keep one-off project facts in project-local files, not the universal template.
