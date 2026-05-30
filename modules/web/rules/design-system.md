# Design System / Taste Rules

## Aesthetic Defaults
- **Palette placeholder.** Replace this with your own default palette guidance. Keep it neutral until a project-specific brand exists.
- **No emojis in code or UI** unless the user explicitly asks. No emoji icons in component names, button labels, or commit messages.
- **Neutral first.** Default palettes lean grayscale + one accent. Add color only where it earns its place.

## Spacing
- Consistent scale (4 / 8 / 12 / 16 / 24 / 32 / 48 / 64 px). No 13px margins or 17px gaps.
- Vertical rhythm: line-height × n for vertical spacing where possible.

## Typography
- One sans-serif body font, one mono for code/numerics. Avoid serif unless the project's brand demands it.
- Tabular figures (`font-variant-numeric: tabular-nums`) on any column of numbers — keeps decimals aligned.

## Contrast & Accessibility
- WCAG AA minimum on all text. AAA where reasonable.
- Focus visible on every interactive element. Never `outline: none` without a replacement.
- Color is never the only signal — pair with icon, text, or position.

## Animation
- Subtle by default. 150–250ms for micro-interactions, 300–400ms for state transitions.
- Respect `prefers-reduced-motion` — disable non-essential animation.
- No bouncing physics on serious financial dashboards. Save those for marketing.

## Iconography
- Consistent stroke weight across an icon set. Don't mix Lucide and Heroicons in the same view.
- Match icon scale to text-line-height, not arbitrary sizes.

## Future Additions
Add concrete tokens here as your design system solidifies (specific hex values, shadow scales, named radii).
