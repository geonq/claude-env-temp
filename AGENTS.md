# Agent & Model Strategy Template

> Template for coordinating multiple models/agents across long-running projects. Replace model names and thresholds with your own setup.

## Tiers

**Orchestrator tier**
- Architecture decisions, spec authoring, adversarial review, handoff authoring, decision logic.
- Should write little implementation code. Its job is to clarify and direct.

**Implementer tier**
- Executes specs delivered by the orchestrator.
- Handles file edits, tests, repetitive coding, and focused bug fixes.
- Escalates architectural decisions instead of guessing.

**Reviewer tier**
- Reads finished work adversarially.
- Prioritizes bugs, missing tests, regressions, security/privacy issues, and broken assumptions.

## Cross-Model Handoff Pattern

Default assumption: any future session may be picked up by a different model or agent. The handoff file is the only context the next agent can rely on.

When the active agent approaches session/context limits, write a quicksave to `Coordination/HANDOFF.md` and stop.

The next agent should read only:

1. `Coordination/HANDOFF.md`
2. `Coordination/DECISIONS.md`
3. Project-root `AGENTS.md`

It should read `CHANGELOG.md`, `tasks/todo.md`, or large plans only when the handoff explicitly references them.

## What a Quicksave Must Capture

- Active task
- Last concrete finding
- Files touched
- Validation run
- Next step
- Blockers
- Last agent error or undone action

## Never

- Run multiple agents on the same task in parallel unless benchmarking outputs.
- Skip handoff writing because the work is "almost done."
- Let implementers make architectural decisions silently.

## Universal Subagents

Use these paths as examples; customize names to your own agent setup:

- `~/.claude/agents/orchestrator.md`
- `~/.claude/agents/implementer.md`
- `~/.claude/agents/reviewer.md`

Module-specific subagents live under each module's `agents/` directory.

## Python Environment Placeholder

If you use a shared Python environment, document it here using portable paths:

```markdown
- Activate: `source "$HOME/path/to/.venv/bin/activate"`
- Python: `"$HOME/path/to/.venv/bin/python"`
- Pip: `"$HOME/path/to/.venv/bin/pip"`
```

Prefer project-local virtual environments when dependencies must be reproducible.
