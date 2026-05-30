# Obsidian Format Rules

## Vault Path
Set this to your actual vault path in your private setup.

Template:
`~/path/to/Obsidian/Vault/`

Suggested subfolders:
- `Uni/` for university coursework
- `Research/` for research notes
- `Projects/` for project notes

## File Naming
- Title-case filenames for concept notes (`Black-Scholes Pricing.md`).
- Date-prefixed for daily / lecture notes (`2026-05-16 Linear Algebra L7.md`).
- No spaces in tag-like or programmatic files (use kebab-case).

## Frontmatter
```yaml
---
created: 2026-05-16
type: lecture | concept | daily | summary
tags: [course-name, topic, status]
source: <PDF filename or URL>
---
```

## Link Syntax
- Wiki-link format: `[[Note Name]]` — Obsidian's native style.
- Avoid Markdown-style `[label](path.md)` links inside the vault; they don't update on rename.
- Tags: `#tagname` inline, plus optional list in frontmatter.

## Concept Notes vs Lecture Notes
- **Lecture note**: one per lecture, dated, captures what was covered.
- **Concept note**: one per concept (Sharpe Ratio, eigenvector, etc.). Linked *from* lecture notes, never duplicated.
- The point: lectures decay, concepts compound. Re-reading a concept note 6 months later should still be useful.

## Anti-Patterns
- **No giant "Notes.md"** dumping everything in one file.
- **No daily duplication** of the same concept rewritten three times. Link to the concept note instead.
- **No raw PDF screenshots** as the only content. Transcribe key formulas/diagrams to markdown.
