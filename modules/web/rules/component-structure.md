# Component Structure

## File Organization
- **One component per file.** Filename matches component name (`Button.tsx`, not `button.tsx` or `components.tsx`).
- **Under 200 lines per file.** If exceeding, extract sub-components or move logic to hooks.
- **Co-locate** styles, types, and tests with the component (`Button.tsx`, `Button.test.tsx`, `Button.types.ts`).

## Composition Over Inheritance
- Build complex components from smaller composable ones.
- Avoid deeply nested prop drilling — if a prop is passed through 3+ levels, lift it to context or restructure.

## Prop Typing
- Every prop typed. No `any`. No `unknown` unless you're explicitly handling a serialized boundary.
- Required vs optional explicit (`prop: T` vs `prop?: T`).
- Discriminated unions for variant-based components (`type Props = ButtonPrimaryProps | ButtonSecondaryProps`).

## No Mega-Files
- A `utils.ts` with 800 lines is a code smell. Split by domain.
- A `components/index.ts` that re-exports 40 things is fine; a `components/All.tsx` defining 40 things is not.

## State Discipline
- Local state stays local. Lift only when shared.
- For shared state: context for cross-tree, props for parent→child, no globals.
- Server state lives in a query library (TanStack Query, SWR), not in component state.

## Inline Styles
- Inline `style={{...}}` for **dynamic values only** (animated colors, computed positions).
- Static styling goes in Tailwind classes, CSS modules, or styled-components — never inline.
