#!/bin/bash
# ruff-check-hook.sh
# Lint Python files with ruff check
# Reads JSON from stdin (Claude Code hook format)

# Read JSON from stdin
INPUT=$(cat)

# Extract file path using jq
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Exit if no file path or not a Python file
[[ -z "$FILE_PATH" ]] && exit 0
[[ "$FILE_PATH" != *.py ]] && exit 0

# Check if ruff is installed
if ! command -v ruff &> /dev/null; then
    exit 0
fi

# Run linting (if file exists)
if [[ -f "$FILE_PATH" ]]; then
    LINT_OUTPUT=$(ruff check "$FILE_PATH" 2>&1)

    if [ -n "$LINT_OUTPUT" ]; then
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "🔍 Ruff: $(basename "$FILE_PATH")"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "$LINT_OUTPUT" | head -15
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    fi
fi

exit 0
