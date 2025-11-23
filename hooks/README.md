# Claude Code Hooks

**Purpose**: Proactive quality controls during development

This directory contains **1 example hook** demonstrating the Claude Code hooks system.

---

## Ruff Check Hook (Linting)

**File**: `ruff-check-hook.sh`
**Triggers**: `PostToolUse` on `Write|Edit` (for `.py` files)
**Purpose**: Lint Python code for quality issues

**What It Catches**:
- Unused imports (`F401`)
- Undefined names (`F821`)
- Syntax errors
- Code smells and anti-patterns

**Why This Hook Is Useful**: Claude sees the lint output and can act on it immediately - fixing issues in the same session.

### Hook Data Format

Hooks receive JSON via **stdin** containing tool information:

```json
{
  "tool_name": "Write",
  "tool_input": {
    "file_path": "/path/to/file.py",
    "content": "file contents..."
  },
  "tool_response": { ... }
}
```

Hooks parse this with `jq`:
```bash
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
```

### Installation

1. Copy hook to a location of your choice:
```bash
mkdir -p ~/.claude/hooks
cp ruff-check-hook.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/ruff-check-hook.sh
```

2. Configure in your project's `.claude/settings.json`:
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {"type": "command", "command": "~/.claude/hooks/ruff-check-hook.sh"}
        ]
      }
    ]
  }
}
```

3. Ensure `ruff` and `jq` are installed:
```bash
pip install ruff
# jq is usually pre-installed on Linux/Mac
```

---

## Creating Your Own Hooks

Use this hook as a template. Key patterns:

```bash
#!/bin/bash
# Read JSON from stdin
INPUT=$(cat)

# Extract file path
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Early exit if not applicable
[[ -z "$FILE_PATH" ]] && exit 0
[[ "$FILE_PATH" != *.py ]] && exit 0

# Your logic here...

# Exit 0 = allow operation (non-blocking)
# Exit 1 = block operation
exit 0
```

**Design Tips**:
- Keep hooks fast (<100ms)
- Make output actionable (Claude can act on feedback)
- Default to non-blocking (exit 0)
- Only block for critical issues (exit 1)

---

## Hook Types That Work Well

Hooks that provide **actionable feedback to Claude** are most useful:

✅ **Linting** - Claude sees errors and fixes them
✅ **Type checking** - Claude sees type errors and fixes them
✅ **Security scanning** - Claude sees vulnerabilities and fixes them

Hooks with broken feedback loops are less useful:

⚠️ **Auto-formatting** - File changes on disk but Claude doesn't see the reformatted result
⚠️ **Status alerts** - Noise without actionable value

---

## License

MIT License - Free to use, modify, and distribute.

---

**Last Updated**: 2024-11-22
