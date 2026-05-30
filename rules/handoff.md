# Handoff Rules

## Coordination/ Directory
Every project has a `Coordination/` folder containing:

- `HANDOFF.md` — **single live state.** Current task, next action, blockers, last agent error. Hard line budget: 60. Older content rotates to CHANGELOG.
- `DECISIONS.md` — **append-only.** What was decided, why, what was ruled out. Never edited, only appended.
- `CHANGELOG.md` — rotating log of completed work. Budget ~80 lines; older entries archive via `~/.claude/bootstrap/archive-changelog.sh`.
- `PHASE_STATUS.md` — 10-line summary of where the project currently is in its phased plan.

## When to Quicksave
- **At ~90% session capacity**, write a quicksave to `HANDOFF.md` before stopping. Do not push past 90% hoping to finish — the next agent has no context if you crash mid-thought.
- After any major decision that the next agent would otherwise have to re-derive.
- Before a manual `/compact` if the squash would lose load-bearing state.

## What a Quicksave Captures
1. **Active task** — one sentence on what was being done
2. **Last finding** — the most recent concrete result
3. **Files touched** — paths edited or read in this run
4. **Validation run** — what was tested, what passed, what's unverified
5. **Next step** — the literal next concrete action
6. **Blockers** — anything that prevented completion, pending reviews
7. **Last agent error / undone** — what the previous agent had to revert (empty if clean)

## CHANGELOG Rotation
- When `CHANGELOG.md` exceeds ~80 lines, archive entries older than the current sprint to `Coordination/archive/CHANGELOG-YYYY-MM.md`.
- The `~/.claude/bootstrap/archive-changelog.sh` script automates this. Run manually or via hook.

## Discipline
- Keep coordination files **terse**. Don't duplicate filesystem state (`ls` output) or source-code state (paste of a function).
- HANDOFF is for the *story* of where things stand. The code is the source of truth for what the code does.

## Cross-model collaboration (default assumption)
Every session must assume another agent may pick up the next handoff. All agents read the same `Coordination/` directory. This means:
- Write HANDOFF entries as if the next reader has zero shared context with you — no in-jokes, no "as we discussed" references.
- Codex's convention is to read `AGENTS.md` at session start. Every project root must have one (gitignored — see below) pointing to `Coordination/HANDOFF.md` and the active plan.
- When in doubt about whether to leave context: leave it. A 10-second extra line in HANDOFF saves the next agent 10 minutes of grep.

## Always gitignored (local collab state, never push)
These files contain session state and workflow context, not deliverable artifacts. Every project's `.gitignore` must exclude:
```
CLAUDE.md
AGENTS.md
PROJECT_CONTEXT.md
REFERENCE.md
.claude/
.claude.json
Coordination/
tasks/todo.md
Tasks/todo.md
```
If a teammate or open-source contributor needs to see the project shape, that goes in `README.md` / `docs/` — not in agent-context files.
