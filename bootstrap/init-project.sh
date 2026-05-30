#!/usr/bin/env bash
# init-project.sh — initialize a new project with Claude Code coordination scaffolding.
#
# Usage:
#   init-project.sh <project-path> [--modules quant,web,study] [--git]
#
# Example:
#   init-project.sh "$HOME/Projects/NewProject" --modules quant
#   init-project.sh /tmp/test-project --modules quant,web

set -euo pipefail

PROJECT_PATH=""
MODULES=""
INIT_GIT=0

while [[ $# -gt 0 ]]; do
    case "$1" in
        --modules)
            MODULES="$2"
            shift 2
            ;;
        --git)
            INIT_GIT=1
            shift
            ;;
        --help|-h)
            grep '^#' "$0" | head -15
            exit 0
            ;;
        -*)
            echo "Unknown option: $1" >&2
            exit 1
            ;;
        *)
            if [[ -z "$PROJECT_PATH" ]]; then
                PROJECT_PATH="$1"
            else
                echo "Multiple positional arguments not supported: $1" >&2
                exit 1
            fi
            shift
            ;;
    esac
done

if [[ -z "$PROJECT_PATH" ]]; then
    echo "Error: project path required" >&2
    echo "Usage: $0 <project-path> [--modules quant,web,study] [--git]" >&2
    exit 1
fi

TEMPLATES="$HOME/.claude/bootstrap/templates"
if [[ ! -d "$TEMPLATES" ]]; then
    echo "Error: templates directory not found at $TEMPLATES" >&2
    exit 1
fi

PROJECT_NAME="$(basename "$PROJECT_PATH")"

mkdir -p "$PROJECT_PATH/Coordination" "$PROJECT_PATH/tasks"

# Copy coordination templates if they don't already exist
for f in HANDOFF.md DECISIONS.md CHANGELOG.md PHASE_STATUS.md; do
    if [[ ! -f "$PROJECT_PATH/Coordination/$f" ]]; then
        cp "$TEMPLATES/$f" "$PROJECT_PATH/Coordination/$f"
    fi
done

# tasks/todo.md
if [[ ! -f "$PROJECT_PATH/tasks/todo.md" ]]; then
    cp "$TEMPLATES/todo.md" "$PROJECT_PATH/tasks/todo.md"
fi

# Project-local CLAUDE.md (filled in with project name + modules)
if [[ ! -f "$PROJECT_PATH/CLAUDE.md" ]]; then
    sed -e "s/<PROJECT NAME>/$PROJECT_NAME/" \
        -e "s/<comma-separated module names>/${MODULES:-none}/" \
        "$TEMPLATES/project-CLAUDE.md" > "$PROJECT_PATH/CLAUDE.md"
fi

# .claude-modules — one module per line
if [[ -n "$MODULES" && ! -f "$PROJECT_PATH/.claude-modules" ]]; then
    echo "$MODULES" | tr ',' '\n' | sed 's/[[:space:]]//g' | grep -v '^$' > "$PROJECT_PATH/.claude-modules"
fi

# .gitignore
if [[ ! -f "$PROJECT_PATH/.gitignore" ]]; then
    cp "$TEMPLATES/.gitignore" "$PROJECT_PATH/.gitignore"
fi

# Optional git init
if [[ "$INIT_GIT" -eq 1 ]]; then
    if [[ ! -d "$PROJECT_PATH/.git" ]]; then
        (cd "$PROJECT_PATH" && git init -q)
        echo "[init-project] initialized git repo"
    else
        echo "[init-project] git repo already present; skipping git init"
    fi
fi

echo ""
echo "[init-project] scaffolded $PROJECT_PATH"
echo "  Coordination/ : HANDOFF, DECISIONS, CHANGELOG, PHASE_STATUS"
echo "  tasks/        : todo.md"
echo "  CLAUDE.md     : project-local stub"
[[ -n "$MODULES" ]] && echo "  .claude-modules: $MODULES"
echo ""
echo "Next:"
echo "  cd \"$PROJECT_PATH\" && claude"
