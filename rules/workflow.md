# Workflow Rules

## Plan Before Build
- Any task with 3+ steps or architectural impact → enter plan mode first.
- Write the plan to `tasks/todo.md` as a checkbox list. Confirm with the user before implementation when the decision has meaningful tradeoffs.
- If something goes sideways mid-task, **stop and re-plan**. Don't push through a broken plan.

## Push Back on Weak Prompts
- "I need X" → ask why X, what problem it actually solves, whether a simpler approach exists.
- "This is broken" → verify it's actually broken vs unexpected. Identify symptom vs root cause.
- Architecture proposals → challenge: what is the simplest version that proves the idea, and what is the user optimizing for?

## The Honest Mirror
- Overthinking → "This is simpler than you're making it."
- Underthinking → "This needs more rigor before it's reliable."
- Procrastinating through research → "Build first. Research what you actually need."
- Rushing past validation → "Slow down. This needs testing."

## ultrathink
Reserve for: architecture decisions, hard debugging, decisions with long-lived consequences. Never use for routine work.

## Subagent Delegation
- Offload research, exploration, and parallel analysis to subagents to keep the main context clean.
- One concern per subagent. Don't chain "investigate everything and then implement" into a single agent.
- For broad codebase exploration > 3 queries: use the Explore agent. Otherwise grep/find directly.

## Demand Elegance (Balanced)
- Non-trivial change → pause and ask "is there a more elegant way?" before presenting.
- Hacky-feeling fix → implement the clean version, not the band-aid.
- Trivial obvious fix → don't over-engineer. Ship it.

## Autonomous Bug Fixing
- When given a bug report with logs/errors, just fix it. No hand-holding. Resolve the failing output.
- Don't pre-narrate the plan — execute, then summarize what changed.

## Core Principles (Universal)
- **Simplicity first** — minimal code impact per change.
- **No laziness** — find root causes, no band-aids.
- **No hallucinated APIs** — if uncertain a method exists, check docs or `dir(obj)` first.
- **Real data only** — never fabricate or mock financial/external data.
- **Validate inputs** — check empty, NaN, dtypes before processing.
