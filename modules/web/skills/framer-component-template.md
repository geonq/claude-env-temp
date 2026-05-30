# Framer Component Template

Boilerplate for a Framer Code Component.

```tsx
import { addPropertyControls, ControlType } from "framer"
import { motion } from "framer-motion"

interface Props {
    label: string
    color: string
    size: number
}

export default function MyComponent({ label, color, size }: Props) {
    return (
        <motion.div
            style={{
                padding: 16,
                background: color,
                fontSize: size,
                color: "#fff",
                borderRadius: 8,
            }}
            whileHover={{ scale: 1.02 }}
            transition={{ duration: 0.15 }}
        >
            {label}
        </motion.div>
    )
}

MyComponent.defaultProps = {
    label: "Click me",
    color: "#1f77b4",
    size: 16,
}

addPropertyControls(MyComponent, {
    label: { type: ControlType.String, title: "Label" },
    color: { type: ControlType.Color, title: "Color" },
    size: { type: ControlType.Number, title: "Size", min: 10, max: 48, step: 1 },
})
```

## Checklist Before Saving
- [ ] All props typed via `interface Props`
- [ ] `defaultProps` produces a sensible-looking component on a fresh page
- [ ] `addPropertyControls` covers every prop the designer should be able to edit
- [ ] No purple defaults, no emoji defaults
- [ ] Animation respects `prefers-reduced-motion` (Framer Motion handles this by default)
