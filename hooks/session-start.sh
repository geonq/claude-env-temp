#!/usr/bin/env bash
# session-start.sh — SessionStart hook.
# Lists session-state files from the last 7 days so the agent knows what prior context is available.

set -u

SESSIONS_DIR="$HOME/.claude/sessions"
mkdir -p "$SESSIONS_DIR"

# Find session files modified in the last 7 days
recent_files=$(find "$SESSIONS_DIR" -maxdepth 1 -type f -name '*.tmp' -mtime -7 2>/dev/null | sort)

if [[ -n "$recent_files" ]]; then
    echo "[session-start] recent session state available (last 7 days):" >&2
    while IFS= read -r f; do
        [[ -z "$f" ]] && continue
        basename "$f" >&2
    done <<< "$recent_files"
    echo "[session-start] read individual files from $SESSIONS_DIR/ as needed" >&2
fi

exit 0
