# Monte Carlo Patterns

## Block Bootstrap (Preserves Autocorrelation)
```python
def block_bootstrap(returns, block_size=10, n_paths=10000, path_len=None):
    path_len = path_len or len(returns)
    n_blocks = path_len // block_size + 1
    paths = np.empty((n_paths, path_len))
    for i in range(n_paths):
        starts = np.random.randint(0, len(returns) - block_size + 1, size=n_blocks)
        blocks = np.array([returns[s:s+block_size] for s in starts])
        paths[i] = blocks.flatten()[:path_len]
    return paths
```
Block size ≈ 5–20 bars depending on autocorrelation half-life. Check ACF before picking.

## Wilson Confidence Interval (Win-Rate-Style Metrics)
```python
from statsmodels.stats.proportion import proportion_confint
ci_low, ci_high = proportion_confint(wins, n, alpha=0.05, method='wilson')
```
Wilson handles small samples and edge proportions correctly. Normal-approx CIs break at <30 trades or extreme win rates.

## Parametric vs Empirical MC
- **Empirical (bootstrap)** — preserves the actual distribution of returns including tails. Use when the strategy's edge depends on the realized distribution.
- **Parametric (normal / Student-t fit)** — faster, smoother CIs. Use for stress-testing under known distributional assumptions, NOT for edge validation.
- **Geometric Brownian motion + jumps** — for evaluation-account or risk-limit path simulation where you need many years of synthetic equity curves.

## p-Value Pitfalls
- p-value alone is not sufficient — always report effect size (mean Sharpe under null vs strategy) and CI overlap.
- Multiple testing: if you tried 50 variants, a p=0.02 result is not significant. Bonferroni or FDR correction.
- "Statistically significant but economically tiny" = not tradeable. Both must hold.

## Evaluation Account Path Simulation
For funded-account, evaluation-account, or other rule-constrained runways, simulate:
- Per-day P&L draws from the strategy's empirical distribution
- Hit the trailing drawdown threshold → fail
- Hit the profit target → pass
- Estimate pass rate, expected days to pass, expected loss-given-fail
- Vary position sizing as a function of distance-to-DD and distance-to-target
