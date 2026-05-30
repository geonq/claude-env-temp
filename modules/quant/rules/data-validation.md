# Data Validation Rules

## Pre-Processing Checklist
Every DataFrame entering a transform gets checked:

```python
assert not df.empty, "Empty DataFrame — upstream fetch failed"
print(df.shape)
print(df.dtypes)
print(df.isna().sum())
print(df.head())
```

In production: convert prints to logging at DEBUG, keep the asserts.

## NaN Handling
- **Decide explicitly:** drop, forward-fill, interpolate, or error.
- Forward-fill prices over short gaps is usually fine. Forward-fill volume is usually wrong (zero volume means zero, not "same as yesterday").
- Returns columns: never forward-fill — a missing return is a missing observation, not a zero.

## Dtype Discipline
- Time columns: `pd.to_datetime(df['ts'], utc=True)` — always tz-aware unless you have a specific reason.
- Price columns: float64. If they come in as object, something's wrong with the source.
- Boolean signals: keep as bool, not int — int columns silently arithmetic-combine in ways bool doesn't.

## Source-Specific Edge Cases
- **yfinance**: occasionally returns multi-index columns when querying multiple tickers. Flatten with `df.columns = df.columns.get_level_values(0)` if you didn't ask for multi-index.
- **ccxt**: timestamps are ms-epoch ints, not datetimes. Convert with `pd.to_datetime(ts, unit='ms', utc=True)`.
- **FRED**: monthly data is reported on the first of the month — but the value is the *full month's average*, not the value on that date.
- **CL=F (crude oil)**: April 20, 2020 went negative (-$37.63). Filter or handle before log-return.

## Empty Response Diagnostics
- API returns empty / KeyError → print raw `data` to see what came back. Usually it's an error structure with a `"message"` or `"error"` field.
- Yahoo / yfinance occasionally returns 200 with empty payload during outages. Check `df.empty` even on success.
