# Python Rules

## Environment
- **venv before pip install.** Check `which python3` — if not inside a venv path, activate first.
  ```
  python3 -m venv venv
  source venv/bin/activate
  ```
- macOS Homebrew Python is **externally managed**. Either use venv, or `pip3 install --break-system-packages` (last resort).
- Always `python3` and `pip3` on macOS — `python`/`pip` may be Python 2 or missing.

## No Hallucinated APIs
- If unsure a method/attribute exists: `print(dir(obj))` or check the package's actual source.
- For pandas/numpy: `help(df.method)` or check the API reference rather than guessing kwargs.
- For third-party libs: read the actual installed source via `python3 -c "import x; print(x.__file__)"`.

## DataFrame / Series Hygiene
- **Scalar extraction from a Series:** `series.iloc[-1].item()` — never `float(series)` (raises `TypeError`).
- **Before processing a DataFrame:** check `df.empty`, `df.dtypes`, `df.isna().sum()`, and `df.head()` to confirm shape and content.
- **Pandas-borderline rule placed at user level** because pandas shows up in study (data analysis) and occasionally web (build scripts) as well as quant.

## Real Data Only
- Never mock or fabricate financial data, API responses, or measurements. Use the real source (yfinance, ccxt, FRED, Polygon, etc.).
- If the real source is unavailable, **say so** rather than substituting fake data silently.

## Validation Before Processing
- Empty check, NaN check, dtype check on every DataFrame entering a transform.
- For API responses: print `data` raw if a `KeyError` hits — the API returned an error structure, not the expected payload.
