---
name: system:status
description: Unified view of work, system, and memory state
allowed-tools: [Read, Bash, Glob]
argument-hint: "[verbose]"
---

# System Status Command

I'll show you a comprehensive view of your current work state, system status, and memory usage.

**Input**: $ARGUMENTS

## Implementation

```bash
#!/bin/bash

# Standard constants (must be copied to each command)
readonly CLAUDE_DIR=".claude"
readonly WORK_DIR="${CLAUDE_DIR}/work"
readonly WORK_CURRENT="${WORK_DIR}/current"
readonly MEMORY_DIR="${CLAUDE_DIR}/memory"
readonly TRANSITIONS_DIR="${CLAUDE_DIR}/transitions"

# Error handling functions (must be copied to each command)
error_exit() {
    echo "ERROR: $1" >&2
    exit 1
}

warn() {
    echo "WARNING: $1" >&2
}

debug() {
    [ "${DEBUG:-false}" = "true" ] && echo "DEBUG: $1" >&2
}

# Parse arguments
VERBOSE=false
if [[ "$ARGUMENTS" =~ verbose ]]; then
    VERBOSE=true
fi

echo "📦 Claude Code Status Report"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Work Status
echo "📋 WORK STATUS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ -f "${WORK_DIR}/ACTIVE_WORK" ]; then
    ACTIVE_WORK=$(cat "${WORK_DIR}/ACTIVE_WORK" 2>/dev/null || echo "")
    if [ -n "$ACTIVE_WORK" ] && [ -d "${WORK_CURRENT}/${ACTIVE_WORK}" ]; then
        echo "🟢 Active: $ACTIVE_WORK"

        # Try to read state.json if it exists
        if [ -f "${WORK_CURRENT}/${ACTIVE_WORK}/state.json" ] && command -v jq >/dev/null 2>&1; then
            STATUS=$(jq -r '.status // "unknown"' "${WORK_CURRENT}/${ACTIVE_WORK}/state.json" 2>/dev/null || echo "unknown")
            CURRENT_TASK=$(jq -r '.current_task // "none"' "${WORK_CURRENT}/${ACTIVE_WORK}/state.json" 2>/dev/null || echo "none")
            echo "   Phase: $STATUS"
            echo "   Task: $CURRENT_TASK"
        fi
    else
        echo "⚠️  Active work unit not found: $ACTIVE_WORK"
    fi
else
    echo "🔴 No active work unit"
fi

# Count work units
if [ -d "$WORK_CURRENT" ]; then
    TOTAL_WORK=$(find "$WORK_CURRENT" -maxdepth 1 -type d -not -path "$WORK_CURRENT" | wc -l)
    echo "   Total units: $TOTAL_WORK"
fi

echo ""

# Git Status
if command -v git >/dev/null 2>&1 && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "🔀 GIT STATUS"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    # Get branch and status
    BRANCH=$(git branch --show-current 2>/dev/null || echo "unknown")
    echo "🌳 Branch: $BRANCH"

    # Count changes
    MODIFIED=$(git status --porcelain 2>/dev/null | grep '^ M' | wc -l)
    STAGED=$(git status --porcelain 2>/dev/null | grep '^[AM]' | wc -l)
    UNTRACKED=$(git status --porcelain 2>/dev/null | grep '^??' | wc -l)

    if [ $MODIFIED -gt 0 ] || [ $STAGED -gt 0 ] || [ $UNTRACKED -gt 0 ]; then
        echo "📝 Changes: $MODIFIED modified, $STAGED staged, $UNTRACKED untracked"
    else
        echo "✅ Working directory clean"
    fi

    # Last commit
    if [ "$VERBOSE" = true ]; then
        LAST_COMMIT=$(git log -1 --pretty=format:"%h - %s (%ar)" 2>/dev/null || echo "No commits")
        echo "📥 Last: $LAST_COMMIT"
    fi

    echo ""
fi

# System Status
echo "⚙️  SYSTEM STATUS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check framework directories
FRAMEWORK_OK=true
for dir in "$CLAUDE_DIR" "$WORK_DIR" "$MEMORY_DIR"; do
    if [ ! -d "$dir" ]; then
        echo "❌ Missing: $dir"
        FRAMEWORK_OK=false
    fi
done

if [ "$FRAMEWORK_OK" = true ]; then
    echo "🏗️  Framework: Claude Code v3.0 ✅"
else
    echo "🏗️  Framework: Incomplete setup ⚠️"
fi

# Memory status
if [ -d "$MEMORY_DIR" ]; then
    MEMORY_FILES=$(find "$MEMORY_DIR" -type f -name "*.md" 2>/dev/null | wc -l)
    MEMORY_SIZE=$(du -sh "$MEMORY_DIR" 2>/dev/null | cut -f1)
    echo "💾 Memory: $MEMORY_FILES files, $MEMORY_SIZE"
fi

echo ""

# Memory Status
if [ "$VERBOSE" = true ]; then
    echo "🧠 MEMORY STATUS"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    # Check recent memory updates
    if [ -d "$MEMORY_DIR" ]; then
        RECENT=$(find "$MEMORY_DIR" -type f -name "*.md" -mmin -60 2>/dev/null | wc -l)
        if [ $RECENT -gt 0 ]; then
            echo "🔄 Recent updates: $RECENT files in last hour"
        fi
    fi

    # Check transitions
    if [ -d "$TRANSITIONS_DIR" ]; then
        TRANSITIONS=$(find "$TRANSITIONS_DIR" -maxdepth 1 -type d -not -path "$TRANSITIONS_DIR" 2>/dev/null | wc -l)
        if [ $TRANSITIONS -gt 0 ]; then
            echo "🔗 Transitions: $TRANSITIONS saved"
        fi
    fi

    echo ""
fi

# Recommendations
echo "🎯 NEXT STEPS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ -n "$ACTIVE_WORK" ] && [ -d "${WORK_CURRENT}/${ACTIVE_WORK}" ]; then
    echo "➡️ Continue with: /next"
    echo "➡️ View work details: /work"
else
    echo "➡️ Start new work: /explore [requirement]"
    echo "➡️ View available work: /work"
fi

if [ $MODIFIED -gt 0 ] || [ $STAGED -gt 0 ]; then
    echo "➡️ Commit changes: /git commit"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
```

## Usage

```bash
/status                    # Quick status overview
/status verbose            # Detailed status with extended information
```

## Phase 1: Current Work Status

### Active Work Unit Analysis
I'll check for and analyze your current work context:

1. **Active Work Unit**: Look for `.claude/work/current/ACTIVE_WORK` and work unit directories
2. **Work Progress**: Analyze `state.json` and `metadata.json` for current progress
3. **Current Tasks**: Identify what tasks are in progress, completed, or blocked
4. **Phase Status**: Determine current workflow phase (exploring, planning, implementing, testing)

### Work Status Display
```
📋 WORK STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 Project: [Project Name]
🔄 Phase: [Current Phase]
📊 Progress: [X/Y tasks complete (Z%)]
⏱️  Current Task: [Task ID - Title]
```

### Task Overview
- **Completed Tasks**: List recently completed tasks with timestamps
- **In Progress**: Show currently active task with estimated completion
- **Next Available**: Identify tasks ready to be executed
- **Blocked Tasks**: Highlight tasks waiting on dependencies

## Phase 2: Git Repository Status

### Repository State Analysis
1. **Branch Information**: Current branch, ahead/behind status with remote
2. **Working Directory**: Modified, staged, and untracked files
3. **Recent Commits**: Last few commits with summary information
4. **Repository Health**: Check for any git issues or inconsistencies

### Git Status Display
```
🔀 GIT STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌳 Branch: [branch-name] (up to date / ahead X / behind Y)
📝 Changes: [X modified, Y staged, Z untracked]
📅 Last Commit: [hash] - [message] ([time ago])
```

### Change Summary
- **Modified Files**: Files with uncommitted changes
- **Staged Changes**: Files ready for commit
- **Untracked Files**: New files not yet added to git
- **Conflicts**: Any merge conflicts that need resolution

## Phase 3: System and Framework Status

### Framework Health Check
1. **Directory Structure**: Verify `.claude/` framework structure is intact
2. **Memory Status**: Check memory file sizes and recent updates
3. **Configuration**: Validate settings and hook configurations
4. **Command Availability**: Ensure all framework commands are accessible

### System Status Display
```
⚙️ SYSTEM STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🏗️  Framework: [Claude Code v3.0] ✅
📁 Structure: [.claude/ directories] ✅
💾 Memory: [X files, Y MB total]
🔧 Configuration: [settings.json] ✅
```

### Health Indicators
- **Framework Version**: Current Claude Code framework version
- **Directory Health**: Status of required framework directories
- **Memory Usage**: Current memory file count and total size
- **Configuration Status**: Settings and hook configuration validation

## Phase 4: Session and Memory Status

### Session Context Analysis
1. **Session Duration**: How long current session has been active
2. **Memory Files**: Current memory file status and recent updates
3. **Import Health**: Validate all `@import` links in CLAUDE.md files
4. **Context Window**: Estimate current context usage and available space

### Memory Status Display
```
🧠 MEMORY STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📝 Session: [X minutes active]
💾 Memory Files: [X files, recent update: Y minutes ago]
🔗 Imports: [X valid, Y broken links]
📊 Context: [~X% utilized]
```

### Memory Health
- **Recent Updates**: Files modified in current session
- **Import Validation**: Status of all `@` import links
- **Size Management**: Memory files approaching size limits
- **Archive Needs**: Old session data that should be compressed

## Phase 5: Verbose Information (Optional)

When verbose flag is specified, include additional details:

### Extended Work Information
- **Full Task List**: Complete task breakdown with dependencies
- **Timing Information**: Task duration estimates and actual times
- **File Changes**: Detailed file modification history
- **Quality Metrics**: Test coverage, code quality scores

### Extended Git Information
- **Commit History**: Extended commit log with detailed messages
- **Branch Analysis**: All branches and their status
- **Remote Status**: Detailed remote repository synchronization
- **Stash Information**: Any stashed changes

### Extended System Information
- **Tool Availability**: Status of development tools (git, python, node, etc.)
- **MCP Server Status**: Connected MCP servers and their health
- **Hook Configuration**: Detailed hook setup and execution status
- **Performance Metrics**: Command execution times and system performance

## Phase 6: Recommendations

### Next Action Recommendations
Based on current status, provide actionable next steps:

#### Work in Progress
```
🎯 NEXT STEPS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
→ Continue current task: [Task ID]
→ Estimated completion: [X hours]
→ Run `/next` to proceed
```

#### Ready for New Work
```
🎯 NEXT STEPS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
→ No active work detected
→ Run `/explore [requirement]` to start new work
→ Or run `/work` to see available work units
```

#### Issues Detected
```
⚠️ ATTENTION NEEDED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
→ [Issue description]
→ Recommended action: [specific command or fix]
```

## Success Indicators

- ✅ Current work status clearly displayed
- ✅ Git repository state summarized
- ✅ Framework health verified
- ✅ Memory and session status shown
- ✅ Clear next action recommendations provided
- ✅ All status information current and accurate

## Integration with Other Commands

- **Work Management**: Status integrates with `/work` for detailed work unit management
- **Planning**: Shows when `/plan` is needed for incomplete planning
- **Execution**: Indicates when `/next` can be used to continue tasks
- **Quality**: Highlights when `/audit` or `/review` might be beneficial

## Examples

### Quick Status Check
```bash
/status
# → Shows concise overview of current work, git, and system status
```

### Detailed Status Review
```bash
/status verbose
# → Comprehensive status with extended information and diagnostics
```

### Status During Development
```bash
/status
# → Shows current task progress, git changes, and next recommended actions
```

---

*Provides comprehensive current state overview enabling informed development decisions and workflow management.*