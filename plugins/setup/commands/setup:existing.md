---
allowed-tools: [Read, Write, Bash]
argument-hint: ""
description: Add Claude Code framework to an existing project with auto-detection
skills: [shared-setup-patterns]
---

# Add Claude Framework to Existing Project

I'll add the Claude Code Framework to your existing project, auto-detecting the language and framework.

```bash
readonly CLAUDE_DIR=".claude"

echo "🔧 Adding Claude Code Framework to existing project..."
echo ""

# Auto-detect project type using shared-setup-patterns skill
echo "Detecting project characteristics..."

# Use framework detection patterns from skill to identify:
# - Language (Python, JavaScript, Go, Rust)
# - Framework (FastAPI, Django, Next.js, Express, etc.)
# - Tools (pytest, Jest, etc.)

# Create .claude directory structure
mkdir -p $CLAUDE_DIR/work
mkdir -p $CLAUDE_DIR/memory
mkdir -p $CLAUDE_DIR/reference
mkdir -p $CLAUDE_DIR/hooks

# Generate security hooks and memory files from shared skill
echo "I'll create:"
echo "  - .claude/settings.json (security hooks)"
echo "  - .claude/memory/* (project knowledge files)"
echo "  - CLAUDE.md (project instructions)"
echo ""

# Create project CLAUDE.md
PROJECT_NAME=$(basename "$PWD")
cat > CLAUDE.md << EOF
# $PROJECT_NAME

## Project Knowledge
@.claude/memory/project_state.md
@.claude/memory/dependencies.md
@.claude/memory/conventions.md
@.claude/memory/decisions.md

## Current Work
@.claude/work/README.md
EOF

# Create work README
cat > $CLAUDE_DIR/work/README.md << 'EOF'
# Work Units

Active development work units are organized here with date-prefixed directories:
- YYYY-MM-DD_NN_topic/ - Work unit format with date and running counter

Each work unit contains:
- metadata.json - Work unit metadata and status
- state.json - Task tracking and implementation plan
- Other relevant files for the work

See workflow plugin commands (/explore, /plan, /next, /ship) for managing work units.
EOF

echo "✅ Claude Code Framework added!"
echo ""
echo "Created:"
echo "  .claude/        - Framework directory"
echo "  CLAUDE.md       - Project instructions"
echo ""
echo "Next: Review and customize CLAUDE.md and .claude/memory/ files for your project."
```
