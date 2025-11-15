---
allowed-tools: [Read, Write, Bash]
argument-hint: "[--force]"
description: Initialize user-level Claude Code configuration (~/.claude/CLAUDE.md)
---

# User Configuration Setup

I'll initialize your ~/.claude/CLAUDE.md configuration file.

```bash
USER_CLAUDE_DIR="$HOME/.claude"
USER_CLAUDE_FILE="$USER_CLAUDE_DIR/CLAUDE.md"
FORCE_FLAG=false

# Check for --force flag
if [ "$1" = "--force" ]; then
    FORCE_FLAG=true
fi

echo "🔧 Initializing user CLAUDE.md configuration..."
echo ""

# Create ~/.claude directory if needed
if [ ! -d "$USER_CLAUDE_DIR" ]; then
    mkdir -p "$USER_CLAUDE_DIR"
    echo "Created $USER_CLAUDE_DIR"
fi

# Check if file already exists
if [ -f "$USER_CLAUDE_FILE" ] && [ "$FORCE_FLAG" != true ]; then
    echo "⚠️  User CLAUDE.md already exists at: $USER_CLAUDE_FILE"
    echo ""
    echo "Use /setup:user --force to overwrite"
    exit 0
fi

# Create user CLAUDE.md
cat > "$USER_CLAUDE_FILE" << 'EOF'
# User-Level Claude Code Configuration

Personal preferences and settings that apply across all projects.

## Working Style
- Code style preferences
- Communication preferences
- Project organization preferences

## Common Tools
- Preferred development tools
- Standard aliases or shortcuts

## Personal Context
Add any personal context that helps Claude work better with you.
EOF

echo "✅ User configuration created at: $USER_CLAUDE_FILE"
echo ""
echo "Next: Edit $USER_CLAUDE_FILE to customize your preferences"
```
