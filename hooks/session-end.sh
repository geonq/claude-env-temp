#!/usr/bin/env bash
# session-end.sh — Stop hook.
# Writes a minimal session summary to ~/.claude/sessions/YYYY-MM-DD-HHMM.tmp
# so the next session can pick up context.

set -u

SESSIONS_DIR="$HOME/.claude/sessions"
mkdir -p "$SESSIONS_DIR"

STAMP="$(date +%Y-%m-%d-%H%M)"
TOPIC="${CLAUDE_SESSION_TOPIC:-session}"
OUT_FILE="$SESSIONS_DIR/${STAMP}-${TOPIC}.tmp"

CWD="$(pwd)"
COUNTER_FILE="/tmp/claude-tool-count-${CLAUDE_SESSION_ID:-$$}"
TOOL_COUNT=0
if [[ -f "$COUNTER_FILE" ]]; then
    TOOL_COUNT=$(cat "$COUNTER_FILE" 2>/dev/null || echo 0)
fi

{
    echo "# Session $STAMP"
    echo ""
    echo "**CWD:** $CWD"
    echo "**Tool calls:** $TOOL_COUNT"
    echo ""
    echo "## What this captures"
    echo "Auto-generated session boundary marker. Update manually with concrete completed items,"
    echo "blockers, and key decisions when the session involved load-bearing work."
    echo ""
    echo "## Completed"
    echo "- "
    echo ""
    echo "## Blockers"
    echo "- "
    echo ""
    echo "## Next session context"
    echo "- "
} > "$OUT_FILE"

# Clean up the tool counter for this session
rm -f "$COUNTER_FILE" "${COUNTER_FILE}.notified"

exit 0
