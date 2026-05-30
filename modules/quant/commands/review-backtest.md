---
name: review-backtest
description: Run the quant-reviewer agent on the current backtest file. Use after the Writer session completes implementation, before declaring done.
---

# /review-backtest

Invokes the `quant-reviewer` agent against the specified backtest file.

## Usage
`/review-backtest <path-to-backtest-file.py>`

If no path is given, the agent picks the most recently edited `.py` file in the current directory matching `*backtest*`, `*strategy*`, or `*model*`.

## What It Does
1. Reads the target file end-to-end.
2. Runs the 7-point checklist from `~/.claude/modules/quant/agents/quant-reviewer.md`.
3. Reports pass/fail per item with line-number evidence.
4. Issues final recommendation: MERGE / FIX-AND-RECHECK / REJECT.

## When to Use
- After every backtest implementation, mandatory.
- After any non-trivial edit to an existing backtest (signal change, sizing change, cost-model change).
- Before any backtest result is presented as a basis for a real trading decision.
