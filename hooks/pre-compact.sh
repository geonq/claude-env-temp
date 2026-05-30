#!/usr/bin/env bash
# pre-compact.sh — PreCompact hook.
# Logs the compaction event with timestamp so context isn't silently lost during the squash.

set -u

SESSIONS_DIR="$HOME/.claude/sessions"
mkdir -p "$SESSIONS_DIR"

STAMP="$(date +%Y-%m-%d-%H%M%S)"
OUT_FILE="$SESSIONS_DIR/compaction-${STAMP}.tmp"

{
    echo "# Compaction event $STAMP"
    echo ""
    echo "**CWD:** $(pwd)"
    echo "**Session:** ${CLAUDE_SESSION_ID:-unknown}"
    echo ""
    echo "Context was compacted. If you need pre-compaction detail, check the prior transcript."
} > "$OUT_FILE"

exit 0
