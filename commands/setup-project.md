---
description: Initialize Claude Code plugins for a new project
temperature: 0.0
---

You are helping set up Claude Code plugins for a project.

# Project Setup Workflow

## Step 1: Find Plugin Path

First, determine where the user cloned claude-code-toolkit:

```bash
# Check common locations
ls -d ~/claude-code-toolkit 2>/dev/null || \
ls -d ~/projects/claude-code-toolkit 2>/dev/null || \
ls -d ~/code/claude-code-toolkit 2>/dev/null || \
echo "NOT_FOUND"
```

If not found, ask the user: "Where did you clone the claude-code-toolkit repository?"

Store this path as `$PLUGINS_PATH`.

## Step 2: Detect Project Type

Examine current directory:

```bash
pwd
ls -la
```

Look for:
- **Python project**: pyproject.toml, setup.py, requirements.txt
- **JavaScript project**: package.json
- **General**: anything else

## Step 3: Ask User Preferences

Use AskUserQuestion to ask:

1. **Which plugins to enable?** (multi-select):
   - system (setup, audit, cleanup, status)
   - workflow (explore, plan, next, ship)
   - development (analyze, review, test, fix, git, docs)
   - memory (handoff, memory management)

2. **MCP servers to configure?** (multi-select):
   - Chrome DevTools (browser automation)
   - Serena (semantic code understanding)
   - Context7 (documentation access)
   - None

## Step 4: Create Configuration

Create `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "local": {
      "source": {
        "source": "directory",
        "path": "$PLUGINS_PATH/plugins"
      }
    }
  },
  "enabledPlugins": {
    "system@local": true,
    "workflow@local": true,
    "development@local": true,
    "memory@local": true
  }
}
```

Replace `$PLUGINS_PATH` with actual path from Step 1.

## Step 5: Create MCP Config (if requested)

Create `.mcp.json` at project root:

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest"]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp@latest"]
    }
  }
}
```

Note: Serena requires per-project setup with `serena.json`.

## Step 6: Create Directory Structure

```bash
mkdir -p .claude/memory
mkdir -p .claude/work
```

## Step 7: Summary

Show what was created:

```bash
ls -la .claude/
cat .claude/settings.json
```

Print:
- Files created
- Plugins enabled
- MCP servers configured (if any)
- Next steps: Try `/workflow:explore "your first task"`

# Plugin Reference

**Core plugins** (recommended):
- `system@local` - Project setup, audit, cleanup, status
- `workflow@local` - Explore, plan, next, ship workflow
- `development@local` - Analyze, review, test, fix, git, docs
- `memory@local` - Handoff, memory management

# Important Notes

1. **Plugin path must be absolute** - Use full path to cloned repo
2. **Create .mcp.json at project root** - Not in .claude/
3. **Ask before overwriting** existing configuration
