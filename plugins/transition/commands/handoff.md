---
title: handoff
aliases: [transition]
---

# Conversation Handoff

Prepare a smooth transition for the next conversation when approaching context limits or switching focus.

## Purpose

Creates a structured handoff document that:
1. **Extracts session-specific context** for immediate continuation
2. **Updates permanent memory** with durable learnings
3. **Prepares clean transition** for the next agent

## What Gets Created

### Transition Document
**Location**: `.claude/transitions/YYYY-MM-DD/HHMMSS.md` (UTC timestamps)

Contains:
- **Current Work Context**: What was being worked on, why, and current state
- **Recent Decisions**: Important choices made this session (not yet in permanent docs)
- **Active Challenges**: Current blockers, open questions, debugging context
- **Next Steps**: Specific, actionable tasks ready for immediate execution
- **Session-Specific State**: File changes, test results, temporary findings

### Memory Updates (if needed)
Updates `.claude/memory/` files with durable knowledge:
- **project_state.md**: Architecture changes, new components
- **conventions.md**: Discovered patterns, coding standards
- **dependencies.md**: New integrations, API changes

## Usage

```bash
# Standard handoff - analyzes conversation and creates transition
/handoff

# With specific focus for next session
/handoff "focusing on performance optimization"

# Quick handoff (minimal extraction)
/handoff --quick
```

## Handoff Process

I'll analyze our conversation and execute these steps:

### Step 1: Verify Working Directory (CRITICAL)

```bash
# ALWAYS check PWD first
pwd

# Verify .claude/transitions/ exists
[ -d ".claude/transitions" ] || echo "ERROR: Wrong directory!"
```

**Stop if not in correct directory** - Do not proceed with file creation.

### Step 2: Create Transition File

```bash
# Get UTC timestamp
UTC_DATE=$(date -u +%Y-%m-%d)
UTC_TIME=$(date -u +%H%M%S)

# Create date directory
mkdir -p ".claude/transitions/$UTC_DATE"

# Create transition file
TRANSITION_FILE=".claude/transitions/$UTC_DATE/$UTC_TIME.md"
```

### Step 3: Write Handoff Content

1. **Identify Durable Knowledge** → Update `.claude/memory/` files if needed
2. **Extract Session Context** → Write comprehensive transition document
3. **Include UTC Timestamp** → Header: `# Handoff: YYYY-MM-DD HH:MM:SS UTC`

### Step 4: Inform User

**IMPORTANT**: After I complete the handoff document, you must manually continue:

1. Run `/clear` (the CLI command, not a slash command)
2. Use `/memory:continue` OR say: "continue from .claude/transitions/YYYY-MM-DD/HHMMSS.md"

**Note**: Claude Code may ignore the continue command and check running processes first (internal command structure behavior). If this happens, run the command again or provide the explicit transition file path.

## User Continuation Steps

After I create the handoff document:

**Step 1**: Run `/clear` to reset conversation context
```bash
/clear
```

**Step 2**: Resume work using ONE of these methods:
```
# Option 1: Use the continue command (searches for latest transition)
/memory:continue

# Option 2: Provide explicit file path (more reliable)
continue from .claude/transitions/YYYY-MM-DD/HHMMSS.md
```

⚠️ **Note**: `/memory:continue` may sometimes prioritize other activities before loading the transition. If this happens, either run it again or use Option 2 with the explicit file path.

**Recommendation**: Always copy the transition file location when it's created, so you can provide it explicitly if needed for a smooth transition.

## Intelligence Guidelines

### What Goes in Permanent Memory
- Architectural decisions and rationale
- Discovered patterns and conventions
- Integration points and dependencies
- Long-term project goals

### What Stays in Transition
- Current debugging context
- Today's specific task progress
- Temporary workarounds
- Session-specific file edits

### What's Excluded
- Verbose narratives about changes
- Historical context ("we tried X then Y")
- Meta-discussion about process
- Redundant information already in docs

## Example Transition Structure

```markdown
# Handoff: 2025-09-18 14:32:15 UTC

## Active Work
Implementing MCP memory system with two-flow approach

## Current State
- Created /handoff and /memory-update commands
- Serena configured and working for semantic operations
- 4 MCP tools operational (Sequential Thinking, Context7, Serena, Firecrawl)

## Recent Decisions
- Use .claude/memory/ for durable knowledge referenced by CLAUDE.md
- Transition documents in .claude/transitions/ for session handoffs
- Keep README.md deliberately concise

## Next Steps
1. Test /handoff command with real scenario
2. Configure .claude/memory/ structure
3. Update CLAUDE.md to reference memory modules

## Session Context
Working in: /home/stefan/agents/claude_code
Last focus: Memory system design
Open PR: feature/sophisticated-hook-system
```

## Implementation Notes

### Critical: Working Directory Verification

**BEFORE creating any files**, verify you're in a project directory with `.claude/` infrastructure:

```bash
# Step 1: Check current directory
pwd

# Step 2: Verify .claude/transitions/ exists
if [ ! -d ".claude/transitions" ]; then
    echo "ERROR: Not in a project with .claude/ infrastructure"
    echo "Current directory: $(pwd)"
    exit 1
fi

# Step 3: Proceed with handoff creation
```

**Common mistake**: Claude creates transition files in random directories when not checking PWD first. Always verify location before writing files.

### Timestamp-Based Organization

**Directory Structure** (UTC timestamps):
```bash
# Get current UTC timestamp
UTC_DATE=$(date -u +%Y-%m-%d)
UTC_TIME=$(date -u +%H%M%S)

# Create date directory if needed
mkdir -p ".claude/transitions/$UTC_DATE"

# Create transition file
TRANSITION_FILE=".claude/transitions/$UTC_DATE/$UTC_TIME.md"
```

**Benefits**:
- ✅ No counter management needed
- ✅ No symlink complexity or permission issues
- ✅ Naturally chronological (sort by filename)
- ✅ Easy time-based queries ("5 hours ago")
- ✅ Date-based archiving (delete old date directories)
- ✅ No timezone confusion (always UTC)

### Finding Latest Transition

**Dynamic lookup** (no symlink needed):

```bash
# Find most recent date directory
LATEST_DATE=$(ls -1 .claude/transitions/ | grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' | sort -r | head -1)

# Find most recent timestamp in that directory
LATEST_TIME=$(ls -1 ".claude/transitions/$LATEST_DATE/" | grep -E '^[0-9]{6}\.md$' | sort -r | head -1)

# Full path to most recent transition
LATEST_TRANSITION=".claude/transitions/$LATEST_DATE/$LATEST_TIME"
```

**Why no symlink**:
- Avoids permission issues with symlink creation
- Reduces token usage (no symlink verification needed)
- Two simple `ls | tail` commands are more reliable
- Transparent and easy to understand

### Manual Continuation Workflow
After creating handoff, I will tell you:

```
✅ Handoff complete!

Location: .claude/transitions/YYYY-MM-DD/HHMMSS.md

To continue this work:
1. Run /clear (the CLI command)
2. Use /memory:continue command OR say: "continue from .claude/transitions/YYYY-MM-DD/HHMMSS.md"

⚠️ **Note**: /memory:continue may sometimes prioritize other activities first. If this happens, run it again or provide the explicit file path above.
```

**Important**: You must explicitly tell me to continue after `/clear`.

## Benefits

- **No Context Loss**: Smooth continuation across conversation boundaries (with manual continue step)
- **Clean Documentation**: Permanent docs stay concise and relevant
- **Efficient Startup**: Next agent gets exactly what they need
- **Progressive Learning**: Project knowledge accumulates properly
- **No Symlink Issues**: Dynamic lookup avoids permission problems
- **UTC Timestamps**: No timezone confusion, easy time-based queries
- **Date Organization**: Simple archival by date directory
- **Transparent**: Two simple `ls` commands, easy to understand and debug

## Helpful Queries

### Find Recent Transitions

```bash
# List today's transitions
ls -lh .claude/transitions/$(date -u +%Y-%m-%d)/

# List all transitions from last 3 days
find .claude/transitions/ -type f -name "*.md" -mtime -3

# Find transitions from specific date
ls -lh .claude/transitions/2025-10-19/
```

### Time-Based Lookups

```bash
# Transitions from last 5 hours (approximately)
FIVE_HOURS_AGO=$(date -u -d '5 hours ago' +%Y-%m-%d)
find .claude/transitions/$FIVE_HOURS_AGO/ -type f -name "*.md"

# Transitions created after specific time today
UTC_DATE=$(date -u +%Y-%m-%d)
find .claude/transitions/$UTC_DATE/ -type f -name "*.md" -newer .claude/transitions/$UTC_DATE/120000.md

# Most recent 5 transitions
find .claude/transitions/ -type f -name "*.md" | sort -r | head -5
```

### Archive Old Transitions

```bash
# Archive transitions older than 30 days
find .claude/transitions/ -type d -name "2025-*" -mtime +30 -exec mv {} .claude/transitions/archive/ \;

# Or delete old date directories
find .claude/transitions/ -type d -name "2025-*" -mtime +90 -exec rm -rf {} \;
```

### Compare Transitions

```bash
# Compare two transitions
diff .claude/transitions/2025-10-19/143022.md .claude/transitions/2025-10-19/165530.md

# See what changed in last transition
LATEST=$(readlink -f .claude/transitions/latest)
PREVIOUS=$(find .claude/transitions/ -type f -name "*.md" | sort -r | sed -n '2p')
diff "$PREVIOUS" "$LATEST"
```

---

*Part of the memory management system - ensuring continuous project understanding across sessions*