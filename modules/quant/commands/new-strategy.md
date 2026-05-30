---
name: new-strategy
description: Spec-first workflow for any new strategy. Forces the strategy-spec agent to produce a falsifiable spec before code is written.
---

# /new-strategy

Spec-first workflow. Run before writing a single line of strategy code.

## Usage
`/new-strategy <one-line idea>`

Example: `/new-strategy opening-hour momentum on NQ with vol-scaled sizing`

## What It Does
1. Invokes the `strategy-spec` agent (`~/.claude/modules/quant/agents/strategy-spec.md`) with the one-line idea.
2. Agent produces a filled-in spec template: thesis, universe, signal, sizing, entry/exit, costs, falsification criteria, out-of-scope.
3. The user reviews the spec, edits or approves.
4. Only after approval does the implementer get the green light to write code.

## Why
Most failed backtests fail at the spec level — the thesis was vague, the falsification criteria were absent, scope crept mid-build. This command makes the spec the deliverable, not the code.
