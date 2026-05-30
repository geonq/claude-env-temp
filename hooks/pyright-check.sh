#!/usr/bin/env bash
# pyright-check.sh — PostToolUse hook for Edit/Write on .py files.
# Runs pyright on the edited file if pyright is available; informs via stderr without blocking.

set -u

# Hook input is JSON on stdin from Claude Code. We extract the file_path field.
INPUT="$(cat 2>/dev/null || true)"
FILE_PATH=""

if command -v jq >/dev/null 2>&1; then
    FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)
fi

if [[ -z "$FILE_PATH" || "${FILE_PATH##*.}" != "py" ]]; then
    exit 0
fi

if [[ ! -f "$FILE_PATH" ]]; then
    exit 0
fi

if ! command -v pyright >/dev/null 2>&1; then
    exit 0
fi

# Run pyright; only emit if there are real errors (not warnings/info).
PYRIGHT_OUT=$(pyright --outputjson "$FILE_PATH" 2>/dev/null || true)
if [[ -z "$PYRIGHT_OUT" ]]; then
    exit 0
fi

if command -v jq >/dev/null 2>&1; then
    ERR_COUNT=$(echo "$PYRIGHT_OUT" | jq -r '.summary.errorCount // 0' 2>/dev/null)
    if [[ "$ERR_COUNT" -gt 0 ]]; then
        echo "[pyright] $ERR_COUNT error(s) in $FILE_PATH:" >&2
        echo "$PYRIGHT_OUT" | jq -r '.generalDiagnostics[] | select(.severity=="error") | "  \(.range.start.line+1): \(.message)"' >&2
    fi
fi

exit 0
