# Lecture Notes Pipeline

> Skeleton. The prior `~/.claude/skills/lecture-notes/SKILL.md` is not present on this machine; rebuild concrete patterns as real lecture material is processed.

## Goal
PDF lecture → Obsidian markdown note that links to existing concept notes and produces Anki-ready Q&A.

## Pipeline
1. **Ingest** — read the PDF (text + diagrams). Identify: course, date, lecture number, main topics.
2. **Structure** — create a new dated note in the vault using the frontmatter from `rules/obsidian-format.md`.
3. **Transcribe** — section per main topic. Formulas in LaTeX math blocks. Diagrams described or linked.
4. **Link** — for every concept mentioned, link to (or create stub for) the corresponding concept note `[[Concept Name]]`.
5. **Extract Q&A** — at the bottom of the note, list 5–15 question/answer pairs that probe the key claims. These feed Anki/NotebookLM downstream.

## University Vault Convention Placeholder
- Put university lecture notes in `Uni/<Course>/` or your chosen course folder.
- Link each lecture note back to a course overview note, e.g. `[[Course Overview]]`.
- If you use a central connector note, document its name here, e.g. `[[University Connector]]`.
- Preserve the existing course naming style unless the vault already uses a different pattern for that course.

## LaTeX in Obsidian
- Inline: `$x = y$`
- Block:
  ```
  $$
  \dfrac{\partial V}{\partial t} + \dfrac{1}{2} \sigma^2 S^2 \dfrac{\partial^2 V}{\partial S^2} = rV - rS \dfrac{\partial V}{\partial S}
  $$
  ```
- Use `\dfrac{}{}` over `\frac{}{}` for better rendering at body font size.

## Concept-Note Stubbing
If a concept is mentioned but no existing note exists, **create a stub**:
```markdown
---
type: concept
tags: [stub]
---
# <Concept Name>

> Stub — created from [[<lecture note>]]. Expand when revisited.

- Brief one-line definition
- Where it came up: [[<lecture note>]]
```
This avoids dead links and gives a future study pass a hook to expand later.

## Defer Trigger Placeholder
If a project should not create deep study guides or concept notes yet, document that project-specific rule in the project's local `CLAUDE.md` instead of this universal template.
