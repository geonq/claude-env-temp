# Git Rules

## Daily Flow
```
git status
git add <specific files>     # never `git add .` or `-A` for unknown trees
git commit -m 'message'
git push
```

## Commit Messages
- **Never paste commit messages from chat** — copied quotes are often curly (`'…'`), and git rejects or mangles them. Type manually, or use HEREDOC.
- Descriptive: focus on *why*, not *what* (the diff already shows what).
- Single quotes safer than double quotes for shell escaping.

## Repo Root Discipline
- Always run git commands from the **repo root**, never from a subfolder.
- **Never `git init` inside a subfolder of an existing repo** — creates nested-repo chaos.
- If unsure where the root is: `git rev-parse --show-toplevel`.

## Recovery
| Symptom | Fix |
|---------|-----|
| `rejected non-fast-forward` | `git pull --rebase` then `git push` |
| `refusing to merge unrelated histories` | `git pull --allow-unrelated-histories` (rare, double-check) |
| `pathspec did not match` | Likely curly quotes pasted from chat — retype |
| Accidentally committed secret | Rotate the secret immediately, then `git filter-repo` or BFG |

## Never
- `git push --force` to a shared branch without explicit instruction.
- `git reset --hard`, `git checkout .`, `git clean -f` without explicit instruction.
- Amend commits only when explicitly requested. Failed pre-commit hook = the commit didn't happen; re-stage and create a new commit.
- Skip hooks (`--no-verify`, `--no-gpg-sign`) unless explicitly requested. Fix the underlying issue instead.
