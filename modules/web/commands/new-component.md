---
name: new-component
description: Spec-first component creation. Forces the component-architect agent to produce a component tree + state plan before any code is written.
---

# /new-component

## Usage
`/new-component <one-line description>`

Example: `/new-component dashboard tile showing live PnL with delta indicator`

## What It Does
1. Invokes `component-architect` agent.
2. Agent produces: component tree, state ownership, prop signatures, open questions.
3. The user reviews and answers open questions.
4. Implementer gets greenlit to write code only after the architecture is approved.

## Why
Most component bugs are architecture bugs — wrong state ownership, wrong prop boundaries. Forcing the tree-first discipline catches these before code exists.
