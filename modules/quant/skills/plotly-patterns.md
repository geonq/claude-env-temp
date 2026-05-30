# Plotly Patterns

## Two-Call `update_layout` (Always)
```python
# WRONG — raises "multiple values for keyword argument"
fig.update_layout(**CHART_LAYOUT, title="My Chart")

# RIGHT — global first, specific second
fig.update_layout(**CHART_LAYOUT)
fig.update_layout(title="My Chart")
```
Spreading a layout dict and also passing a keyword in the same call collides on shared keys. Always split into two calls.

## Dark Theme Template
```python
CHART_LAYOUT = dict(
    template="plotly_dark",
    paper_bgcolor="#0e1117",
    plot_bgcolor="#0e1117",
    font=dict(family="Inter, system-ui, sans-serif", color="#e0e0e0"),
    margin=dict(l=40, r=20, t=40, b=40),
    xaxis=dict(gridcolor="#262730", zerolinecolor="#262730"),
    yaxis=dict(gridcolor="#262730", zerolinecolor="#262730"),
    hoverlabel=dict(bgcolor="#1e1e2e", font_color="#e0e0e0"),
)
```

## hex_to_rgba (for Translucent Fills)
```python
def hex_to_rgba(hex_color: str, alpha: float = 0.3) -> str:
    h = hex_color.lstrip("#")
    r, g, b = int(h[0:2], 16), int(h[2:4], 16), int(h[4:6], 16)
    return f"rgba({r}, {g}, {b}, {alpha})"
```
Use for confidence-interval bands, drawdown shading, signal-region highlights.

## Heatmap NaN Handling
NaN cells silently take the gradient color of the nearest valid neighbor — bleeding effect ruins the visual. Fix:

```python
z = df.fillna(-1).values     # sentinel below real value range
fig = go.Figure(go.Heatmap(
    z=z,
    colorscale=[
        [0.0, "#0e1117"],      # NaN sentinel → background
        [0.0001, "#1f77b4"],   # real values start here
        [1.0, "#ff7f0e"],
    ],
    zmin=-1, zmax=df.max().max(),
))
```

## Scrollable / Long Chart Pattern
For long time-series, set `xaxis_rangeslider_visible=True` or wrap in a fixed-height container with `st.plotly_chart(fig, use_container_width=True, theme=None)`.

## Common Errors
| Symptom | Fix |
|---------|-----|
| `multiple values for keyword argument` | Use two `update_layout` calls |
| Gradient bleeds into NaN cells | Fill NaN with -1 sentinel and add explicit colorscale stop at 0.0 |
| Plot rendering blank in Streamlit | Add `use_container_width=True` to `st.plotly_chart` |
| Hover labels unreadable | Set `hoverlabel.bgcolor` and `font_color` explicitly |
