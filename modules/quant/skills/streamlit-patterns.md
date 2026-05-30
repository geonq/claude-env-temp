# Streamlit Patterns

## `set_page_config` Must Be First
`st.set_page_config(...)` must be the **first** Streamlit call in the script — before any `st.write`, `st.title`, imports that call Streamlit at top level, anything. Otherwise Streamlit raises `StreamlitAPIException`.

```python
import streamlit as st

st.set_page_config(
    page_title="Dashboard",
    page_icon="📈",
    layout="wide",
    initial_sidebar_state="expanded",
)

# everything else after this
```

## Button-Gated Heavy Computation
Monte Carlo, large backtests, and any computation > 2 seconds must be **gated behind a button** — otherwise it reruns on every slider/widget interaction.

```python
if st.button("Run Monte Carlo"):
    results = run_mc(n_paths=10000)
    st.session_state["mc_results"] = results

if "mc_results" in st.session_state:
    display(st.session_state["mc_results"])
```

## Caching Discipline
- `@st.cache_data` for pure functions returning serializable data.
- **Never pass mutable objects (DataFrames, dicts) as cache keys** — pass primitives (strings, ints, tuples). Mutable args defeat the cache.
- Invalidate explicitly when source data changes: `cache_data.clear()`.

## Layout
- `st.columns([2, 1])` for 2:1 split. Use proportional widths, not pixel widths.
- `st.tabs([...])` for multi-view dashboards. Cheaper than full multi-page apps when state is shared.
- Sidebar for inputs, main area for outputs. Never put a 30-control sidebar — group with `st.expander`.

## Common Errors
| Symptom | Fix |
|---------|-----|
| `set_page_config` error | Must be first Streamlit call |
| Cache not invalidating | Mutable cache arg — switch to primitives |
| MC reruns on every interaction | Wrap in `if st.button(...)` |
| Plotly figure not updating | `st.plotly_chart(fig, key="unique_key")` — give it a key |
