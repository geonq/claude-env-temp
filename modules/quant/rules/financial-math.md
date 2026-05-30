# Financial Math Rules

## Returns
- **Use log returns** for compounding and statistics: `np.log(price / price.shift(1))`.
- **Convert to arithmetic before Sharpe / per-period reporting:** `np.exp(log_return) - 1`.
- `pct_change()` is fine for display only — never feed it into Sharpe or compounding math directly.

## Signal Timing
- **Every signal must `.shift(1)` before being used as a position.** A signal computed at close of day T trades at open of day T+1.
- Failure to shift is the #1 lookahead-bias bug. Reviewer must verify presence of `.shift(1)`.

## Annualization
- `sqrt(252)` for daily, `sqrt(52)` for weekly, `sqrt(12)` for monthly.
- Crypto: `sqrt(365)` (24/7 markets). Intraday: scale to your bar frequency.

## Sharpe Ratio
```
arith_ret = np.exp(log_ret) - 1
excess    = arith_ret - rf_daily
sharpe    = excess.mean() / arith_ret.std() * np.sqrt(252)
```
- `rf_daily` from FRED — check current `DGS3MO` or equivalent before any analysis session if rates matter to the result.
- For strategies with zero/low correlation to rates, `rf = 0` may be acceptable if the assumption is documented and reviewed.

## Max Drawdown
```
cum     = (1 + arith_ret).cumprod()
peak    = cum.cummax()
dd      = (cum - peak) / peak
max_dd  = dd.min()              # negative number, e.g. -0.23
```

## Win Rate
- Only meaningful for **discrete trades** (entry to exit), not continuous positions.
- Daily-return-based "win rate" is misleading — don't report it for always-in strategies.

## FRED Rate Check (Pre-Analysis)
Before any analysis session that depends on the risk-free rate, fetch the current short rate from FRED. Stale rates from a notebook 6 months ago bias Sharpe materially.
