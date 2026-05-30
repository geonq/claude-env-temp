# Study Module

**Covers:** university lectures, PDF → Obsidian markdown notes, Anki flashcard generation, NotebookLM workflows, exam prep.

**Activate when:** the project's `.claude-modules` file lists `study`.

**Status:** skeleton. The prior `lecture-notes` skill is not present on this machine; rebuild concrete patterns as real lecture material is processed.

## Table of Contents

### Rules (loaded with module)
- `rules/obsidian-format.md` — vault path, link syntax, frontmatter conventions

### Skills (on demand)
- `skills/lecture-notes.md` — PDF → markdown pipeline (skeleton; rebuild as needed)
- `skills/exam-prep.md` — review/retrieval-practice patterns

### Agents (on demand)
- `agents/study-synthesizer.md` — lecture markdown → Anki cards + NotebookLM-compatible export

### Commands (on demand)
- `commands/digest-lecture.md` — end-to-end PDF → notes → cards
