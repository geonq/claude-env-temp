#!/usr/bin/env bash
# strategic-compact.sh — PreToolUse hook for Edit/Write tools.
# Emits a one-shot stderr nudge once tool-call count crosses COMPACT_THRESHOLD (default 50)
# so the active agent considers a manual /compact at phase transitions.

set -u

THRESHOLD="${COMPACT_THRESHOLD:-50}"
COUNTER_FILE="/tmp/claude-tool-count-${CLAUDE_SESSION_ID:-$$}"
NOTIFIED_FILE="${COUNTER_FILE}.notified"

count=0
if [[ -f "$COUNTER_FILE" ]]; then
    count=$(cat "$COUNTER_FILE" 2>/dev/null || echo 0)
fi
count=$((count + 1))
echo "$count" > "$COUNTER_FILE"

if [[ "$count" -ge "$THRESHOLD" && ! -f "$NOTIFIED_FILE" ]]; then
    echo "[StrategicCompact] $count tool calls reached — consider /compact if transitioning phases" >&2
    touch "$NOTIFIED_FILE"
fi

exit 0
