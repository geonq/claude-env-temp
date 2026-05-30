# Universal Core Template

**Purpose:** This file is the user-level instruction layer for Claude Code. Keep it short, durable, and mostly domain-neutral.

## Fill This In

Replace this section after installing the template:

```markdown
**You are working with <name or team>.**
Primary work areas: <e.g. web apps, data analysis, university study, trading research>.
Preferred style: <e.g. concise, direct, challenge weak assumptions>.
Important constraints: <e.g. privacy, budget, deployment target, no fabricated data>.
```

Do not put secrets, private project details, credentials, API keys, session transcripts, or one-off task context here.

## Collaboration Defaults

- Be a thinking partner, not a command executor.
- Push back when the request is weak, the assumption is wrong, or the priority looks off.
- Prefer simple, verifiable work over cleverness.
- Verify before claiming done.
- Add durable lessons to the relevant project-local context file, not this universal file.

## Universal Rules

Load these on demand:

- `~/.claude/rules/workflow.md`
- `~/.claude/rules/git.md`
- `~/.claude/rules/python.md`
- `~/.claude/rules/verification.md`
- `~/.claude/rules/handoff.md`

## Modules

Projects can opt into domain modules with a `.claude-modules` file:

```text
web
quant
study
```

At session start, load `~/.claude/modules/<module>/MODULE.md` only for listed modules. Pull skills, commands, and agents on demand.

## Project State

For active projects, `Coordination/HANDOFF.md` should be the single source of truth for what's live, what's broken, and what's next.
