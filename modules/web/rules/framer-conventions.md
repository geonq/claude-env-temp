# Framer Conventions

> Skeleton — fill in as preferences emerge during real Framer work.

## Code Components
- Use TypeScript. Type every prop explicitly with `propertyControls` for the Framer panel.
- File-per-component. No multi-component files unless tightly coupled (e.g., a Tabs + TabPanel pair).
- Keep components < 200 lines. If hitting the ceiling, extract sub-components.

## Property Controls
- Every visible prop needs a `propertyControls` entry so non-code edits can happen in the Framer panel.
- Use `ControlType.Enum` for variants, `ControlType.Color` for colors, `ControlType.Number` with min/max for sizes.
- Default values should produce a sensible-looking component when dropped on a fresh page.

## Responsive
- Mobile-first. Use `useMediaQuery` or Framer's built-in breakpoint variants.
- Test at the three default Framer breakpoints (Desktop / Tablet / Phone) before declaring done.

## Performance
- No heavy computation in render. Memoize with `useMemo` / `useCallback` for non-trivial work.
- Animations: prefer Framer Motion primitives over raw CSS keyframes — Framer Motion respects `prefers-reduced-motion` by default.

## Future Additions
This file expands as concrete patterns emerge. Add a section when:
- A bug recurs across components
- A convention emerges from repeated edits
- A Framer-specific API has a non-obvious gotcha
