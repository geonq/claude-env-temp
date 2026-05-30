---
name: digest-lecture
description: End-to-end pipeline — PDF lecture → Obsidian markdown note → Anki cards. Runs lecture-notes skill then study-synthesizer agent.
---

# /digest-lecture

## Usage
`/digest-lecture <path-to-lecture.pdf>`

## What It Does
1. Reads the PDF.
2. Produces an Obsidian markdown note following `rules/obsidian-format.md`, with Q&A at the bottom.
3. Saves to the vault path declared in `modules/study/rules/obsidian-format.md` or a project-local override.
4. Invokes `study-synthesizer` agent on the new note → produces Anki CSV.
5. Prints the new note path and the Anki CSV path.

## Constraints
- Does NOT auto-generate concept-note expansions — only stubs for unknown concepts (see `skills/lecture-notes.md`).
- Does NOT push to Anki automatically. The user reviews the CSV before import.
