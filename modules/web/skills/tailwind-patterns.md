# Tailwind Patterns

> Skeleton — populate as repeated web patterns emerge.

## Conditional Classes
Use `clsx` or `tailwind-merge` for conditional class composition. Don't string-concatenate Tailwind classes — PurgeCSS / JIT can't see runtime-built strings.

```tsx
import { clsx } from 'clsx';
<div className={clsx('px-4 py-2', isActive && 'bg-blue-500', isDisabled && 'opacity-50')} />
```

## Dark Mode
- Use the `dark:` variant consistently. Don't manually swap classes via JS.
- Define semantic tokens in `tailwind.config.js` (`bg-surface`, `text-primary`) rather than raw colors everywhere.

## Spacing
- Stick to the default scale unless the design explicitly diverges.
- Use `space-x-*` / `space-y-*` on flex/grid containers instead of margins on children.

## Responsive
- Mobile-first. Bare classes apply mobile; `md:`, `lg:` add desktop overrides.
- Avoid `hidden md:block` if you can `block md:flex` instead — keeps the markup present for SEO and accessibility.

## Future Additions
Add component-specific snippets here as patterns repeat.
