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

## For New Users (Friends Setting This Up)

The universal layer — `CLAUDE.md`, `rules/`, `agents/`, `hooks/` — is domain-neutral and works for anyone. The three example modules (`quant/`, `web/`, `study/`) are specific to the original author. Delete them and build your own.

**Minimum viable install** (no modules):

```bash
git clone https://github.com/<your-user>/claude-env-temp.git ~/.claude
chmod +x ~/.claude/hooks/*.sh ~/.claude/bootstrap/*.sh
# Edit CLAUDE.md with your name, work areas, and constraints.
# Done — no modules needed until you have a repeating domain.
```

**When you have a domain to add**, create a module folder:

```
modules/<your-domain>/
  MODULE.md          # one-paragraph overview; loaded at session start when active
  rules/             # domain rules, loaded with the module
  agents/            # specialized agents for this domain (load on demand)
  skills/            # reusable skill prompts (load on demand)
  commands/          # slash-command definitions (load on demand)
```

Activate it per project by adding the module name to `.claude-modules` in the project root.

---

## How Claude Should Read This Template

*This section is for Claude, not the human installer.*

When this directory is your `~/.claude`:

1. **CLAUDE.md loads first.** Fill in the "Fill This In" section with who you are and your work areas. The rest applies universally.
2. **`rules/` load on demand**, not at session start. Pull the relevant file when the task touches that domain (workflow, git, python, verification, handoff).
3. **Modules activate per-project.** If a project root contains `.claude-modules`, load each listed module's `MODULE.md` at session start. Pull agents, skills, and commands from that module only when the task calls for them.
4. **`agents/` defines your role in multi-agent work.** Read `orchestrator.md`, `implementer.md`, or `reviewer.md` depending on which tier you are acting as.
5. **`hooks/` run automatically.** They are wired into `settings.json` and fire on session lifecycle events. You do not load them.
6. **Per-project state lives in `Coordination/`.** `HANDOFF.md` is the single source of truth for what is live, broken, and next. Read it before acting on any project.
7. **`modules/quant`, `web`, `study` are example modules for the original author.** Delete them and build your own using the same folder structure.
