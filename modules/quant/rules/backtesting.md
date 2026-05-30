# Backtesting Rules

## Lookahead Bias Prevention
- **Every signal `.shift(1)`** before use as a position. No exceptions.
- **No "today's close" in today's decision.** If the bar isn't closed, you can't use its close.
- Indicators built on rolling windows are fine — but their *use* as a signal must still shift.
- TradingView Pine: with `calc_on_order_fills=true`, do NOT use `position_size[1]` to detect transitions — track with a `var prevPosSize` instead, otherwise per-day caps and cooldowns silently break.

## Transaction Costs from Day One
- Always include commissions, slippage, and (where relevant) financing/borrow from the first backtest run, not retrofitted later.
- Slippage scales with bar size and liquidity — be honest about realistic fills, especially for intrabar/limit fills.

## Writer/Reviewer Pattern — MANDATORY
- Any backtest, any strategy validation, any financial model gets two passes:
  - **Writer** implements.
  - **Reviewer** is a separate session with adversarial prior. Use `~/.claude/modules/quant/agents/quant-reviewer.md`.
- Single-pass backtests are not allowed to graduate to real trading decisions.

## Monte Carlo Validation
- If claiming an edge, validate with **block bootstrap** Monte Carlo:
  - Resample returns in blocks (typical block ≈ 5–20 bars depending on regime persistence) to preserve autocorrelation.
  - Compare strategy Sharpe / max DD distribution against shuffled-returns null.
  - **Wilson CIs** on win-rate-style metrics, not normal-approx CIs.
- p-value alone is not sufficient — report effect size and CI overlap.

## IS/OOS Splits
- Walk-forward preferred over fixed train/test for time-series strategies.
- If using fixed IS/OOS, freeze the OOS data and **never look at it during development**. One peek contaminates the test.

## Survivorship
- Universe selection must include delisted/withdrawn tickers for the relevant period.
- "Top 100 by current market cap" is a survivorship-biased universe. Use historical constituents at each rebalance.

## Edge Cases
- **CL=F (crude oil) April 20, 2020** went negative (−$37.63). Log return is undefined. Filter or handle explicitly.
- Holidays / half-days produce zero-volume bars in some sources. Decide: drop, forward-fill, or error.
