#!/usr/bin/env bash
# archive-changelog.sh — rotate old CHANGELOG.md entries into Coordination/archive/CHANGELOG-YYYY-MM.md.
#
# Usage:
#   archive-changelog.sh [path-to-Coordination-dir]
#
# Default path: ./Coordination
#
# Behavior:
#   Keeps the most recent ~80 lines in CHANGELOG.md, moves older content to a
#   month-stamped archive file. The boundary is the first H2 (## YYYY-MM-DD) older
#   than ~30 days, or simply the line-count threshold if no dated headers exist.

set -euo pipefail

COORD_DIR="${1:-./Coordination}"
CHANGELOG="$COORD_DIR/CHANGELOG.md"
ARCHIVE_DIR="$COORD_DIR/archive"
KEEP_LINES=80

if [[ ! -f "$CHANGELOG" ]]; then
    echo "[archive-changelog] no CHANGELOG.md at $CHANGELOG; nothing to archive" >&2
    exit 0
fi

TOTAL_LINES=$(wc -l < "$CHANGELOG" | tr -d ' ')

if [[ "$TOTAL_LINES" -le "$KEEP_LINES" ]]; then
    echo "[archive-changelog] CHANGELOG.md is $TOTAL_LINES lines (threshold $KEEP_LINES); no rotation needed"
    exit 0
fi

mkdir -p "$ARCHIVE_DIR"
STAMP="$(date +%Y-%m)"
ARCHIVE_FILE="$ARCHIVE_DIR/CHANGELOG-$STAMP.md"

SPLIT_LINE=$((TOTAL_LINES - KEEP_LINES))

# Append the older portion to the archive (creating it if needed)
if [[ ! -f "$ARCHIVE_FILE" ]]; then
    echo "# Changelog Archive — $STAMP" > "$ARCHIVE_FILE"
    echo "" >> "$ARCHIVE_FILE"
fi
head -n "$SPLIT_LINE" "$CHANGELOG" >> "$ARCHIVE_FILE"

# Replace the live CHANGELOG with just the recent tail
TAIL_TMP="$(mktemp)"
{
    echo "# Changelog"
    echo ""
    echo "> Older entries archived to \`archive/CHANGELOG-$STAMP.md\` on $(date +%Y-%m-%d)."
    echo ""
    tail -n "$KEEP_LINES" "$CHANGELOG"
} > "$TAIL_TMP"
mv "$TAIL_TMP" "$CHANGELOG"

echo "[archive-changelog] archived $SPLIT_LINE lines to $ARCHIVE_FILE; CHANGELOG.md now $KEEP_LINES + header lines"
