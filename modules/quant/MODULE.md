# Quant Module

**Covers:** financial math, backtesting, Monte Carlo simulation, dashboards, options pricing, market data sources.

**Activate when:** the project's `.claude-modules` file lists `quant`. Loads `MODULE.md` + `rules/*.md` on session start. Skills and agents pulled on demand.

## Table of Contents

### Rules (loaded with module)
- `rules/financial-math.md` — log returns, shift(1), sqrt(252), Sharpe with arith-after-exp, max drawdown, FRED rate check
- `rules/backtesting.md` — lookahead prevention, transaction costs, win-rate semantics, Writer/Reviewer mandatory, MC validation
- `rules/data-validation.md` — `df.empty` checks, dtype verification, NaN handling, CL=F edge case

### Skills (on demand)
- `skills/monte-carlo.md` — block bootstrap, Wilson CIs, p-value interpretation, parametric vs empirical MC
- `skills/streamlit-patterns.md` — `set_page_config` first, two-call `update_layout`, button-gated MC reruns, cache primitives only
- `skills/plotly-patterns.md` — dark theme template, `hex_to_rgba`, heatmap NaN fill, scrollable chart pattern

### Agents (on demand)
- `agents/quant-reviewer.md` — Writer/Reviewer second pass with explicit 7-point checklist
- `agents/strategy-spec.md` — generates falsifiable strategy specs before any code

### Commands (on demand)
- `commands/review-backtest.md` — invokes quant-reviewer on the current file
- `commands/new-strategy.md` — spec-first workflow before any code

## Project Context Placeholder
Put project-specific trading constraints in the project's local `CLAUDE.md` or `PROJECT_CONTEXT.md`, not in this universal module. Examples: instrument universe, account rules, risk limits, execution venue, broker/API constraints, or evaluation rules.
