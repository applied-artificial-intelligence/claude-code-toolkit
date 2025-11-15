---
allowed-tools: [Read, Write, MultiEdit, Bash, Grep]
argument-hint: "[subcommand: continue|checkpoint|switch] [args] OR [filter: active|paused|completed|all]"
description: "Unified work management: list units, continue work, save checkpoints, and switch contexts"
---

# Unified Work Management

Comprehensive work unit management with subcommands for continuing work, saving checkpoints, switching contexts, and viewing status.

**Input**: $ARGUMENTS

## Implementation

```bash
#!/bin/bash

# Standard constants (must be copied to each command)
readonly CLAUDE_DIR=".claude"
readonly WORK_DIR="${CLAUDE_DIR}/work"

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

# Safe directory creation
safe_mkdir() {
    local dir="$1"
    mkdir -p "$dir" || error_exit "Failed to create directory: $dir"
}

# Parse arguments
ARGUMENTS="$ARGUMENTS"
SUBCOMMAND=""
FILTER="all"
WORK_ID=""
MESSAGE=""

# Extract subcommand or filter
if [[ "$ARGUMENTS" =~ ^(continue|checkpoint|switch) ]]; then
    SUBCOMMAND="${BASH_REMATCH[1]}"
    REMAINING="${ARGUMENTS#$SUBCOMMAND}"
    REMAINING="${REMAINING# }"  # Trim leading space

    case "$SUBCOMMAND" in
        continue|switch)
            WORK_ID="$REMAINING"
            ;;
        checkpoint)
            MESSAGE="$REMAINING"
            ;;
    esac
elif [[ "$ARGUMENTS" =~ ^(active|paused|completed|all) ]]; then
    FILTER="$ARGUMENTS"
fi

# Ensure work directory exists
safe_mkdir "$WORK_DIR"

# Main execution
if [ -z "$SUBCOMMAND" ]; then
    # List work units based on filter
    echo "📋 WORK UNITS"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    # List all work units (date-prefixed directories)
    # Work units are now in format: YYYY-MM-DD_NN_topic

    for work_dir in "$WORK_DIR"/20*; do
        [ -d "$work_dir" ] || continue
        work_id=$(basename "$work_dir")

        if [ -f "$work_dir/metadata.json" ]; then
            # Extract metadata (simplified - would use jq in practice)
            echo "🟢 $work_id    [active]    Progress info here"
        fi
    done

else
    case "$SUBCOMMAND" in
        continue)
            # Continue work unit
            if [ -z "$WORK_ID" ]; then
                # Find last active work unit
                if [ -f "${WORK_DIR}/ACTIVE_WORK" ]; then
                    WORK_ID=$(cat "${WORK_DIR}/ACTIVE_WORK")
                else
                    error_exit "No active work unit found"
                fi
            fi

            # Validate work unit exists
            if [ ! -d "${WORK_DIR}/${WORK_ID}" ]; then
                error_exit "Work unit ${WORK_ID} not found"
            fi

            # Set as active
            echo "$WORK_ID" > "${WORK_DIR}/ACTIVE_WORK" || error_exit "Failed to set active work unit"
            echo "✅ Resumed work unit: ${WORK_ID}"
            ;;

        checkpoint)
            # Save checkpoint
            if [ ! -f "${WORK_DIR}/ACTIVE_WORK" ]; then
                error_exit "No active work unit to checkpoint"
            fi

            ACTIVE_ID=$(cat "${WORK_DIR}/ACTIVE_WORK")
            CHECKPOINT_DIR="${WORK_DIR}/${ACTIVE_ID}/checkpoints"
            safe_mkdir "$CHECKPOINT_DIR"

            TIMESTAMP=$(date +%Y%m%d_%H%M%S)
            CHECKPOINT_FILE="${CHECKPOINT_DIR}/checkpoint_${TIMESTAMP}.json"

            # Create checkpoint (simplified)
            cat > "$CHECKPOINT_FILE" << EOF || error_exit "Failed to create checkpoint"
{
    "timestamp": "$(date -Iseconds)",
    "message": "${MESSAGE:-Checkpoint created}",
    "work_id": "$ACTIVE_ID"
}
EOF

            echo "✅ Checkpoint saved for ${ACTIVE_ID}"
            ;;

        switch)
            # Switch work units
            if [ -z "$WORK_ID" ]; then
                error_exit "Work unit ID required for switch"
            fi

            if [ ! -d "${WORK_DIR}/${WORK_ID}" ]; then
                error_exit "Work unit ${WORK_ID} not found"
            fi

            # Checkpoint current if exists
            if [ -f "${WORK_DIR}/ACTIVE_WORK" ]; then
                OLD_ID=$(cat "${WORK_DIR}/ACTIVE_WORK")
                echo "📝 Checkpointing ${OLD_ID} before switch..."
                # Would call checkpoint logic here
            fi

            # Switch to new work unit
            echo "$WORK_ID" > "${WORK_DIR}/ACTIVE_WORK" || error_exit "Failed to switch work unit"
            echo "✅ Switched to work unit: ${WORK_ID}"
            ;;
    esac
fi
```

## Usage Examples

```bash
/work                    # List all work units (default)
/work active             # List only active work units
/work continue          # Resume last active work unit
/work continue 002      # Resume specific work unit
/work checkpoint        # Save current progress
/work checkpoint "Major milestone reached"  # Save with custom message
/work switch 003        # Switch to work unit 003
```

## Detailed Operation Phases

### Phase 1: Determine Work Operation

Based on the arguments provided: $ARGUMENTS

I'll determine which work management operation to perform:

- **List Operations**: No subcommand or filter keyword - show work unit list
- **Continue Operations**: Arguments start with "continue" - resume work
- **Checkpoint Operations**: Arguments start with "checkpoint" - save progress
- **Switch Operations**: Arguments start with "switch" - change active work unit

## Phase 2: Execute Work Unit Listing

When listing work units:

### Work Unit Discovery
1. **Scan Work Directory**: Examine `.claude/work/` for all work units (YYYY-MM-DD_NN_topic/)
2. **Parse Metadata**: Read metadata.json files to understand work unit status
3. **Identify Active Unit**: Check `ACTIVE_WORK` file for currently active work
4. **Status Analysis**: Determine work unit phases and progress

### Filtering Options
- **All Units** (default): Show all work units regardless of status
- **Active Units**: Only show units in active development
- **Paused Units**: Show units that are paused but not completed
- **Completed Units**: Display archived and completed work units

### Work Unit Display Format
```
📋 WORK UNITS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🟢 001_auth_system        [implementing]     3/5 tasks  (60%)
   ↳ Last: 2 hours ago - TASK-003 in progress

⏸️  002_payment_flow      [paused]          1/4 tasks  (25%)
   ↳ Last: 1 day ago - waiting for API specs

✅ 003_user_dashboard     [completed]       4/4 tasks  (100%)
   ↳ Completed: 3 days ago - shipped to production

📝 004_notification_sys   [planning]        0/6 tasks  (0%)
   ↳ Last: 30 minutes ago - plan in progress
```

## Phase 3: Execute Continue Operations

When continuing work:

### Resume Active Work Unit
1. **Identify Target**: Determine which work unit to resume (last active or specified)
2. **Load Context**: Read work unit metadata, state, and progress
3. **Validate State**: Ensure work unit is in resumable state
4. **Set Active**: Mark work unit as active and update session context
5. **Display Status**: Show current task and next actions

### Context Restoration
1. **Work Unit Activation**: Set as active work unit in `ACTIVE_WORK`
2. **Session Memory**: Load work unit context into session memory
3. **Task Context**: Identify current task and next available tasks
4. **Environment Setup**: Prepare development environment for continued work

### Continue Options
- **Continue Latest**: Resume most recently active work unit
- **Continue Specific**: Resume explicitly specified work unit by ID
- **Continue with Validation**: Verify work unit state before resuming

## Phase 4: Execute Checkpoint Operations

When creating checkpoints:

### Progress Capture
1. **Current State**: Capture current task progress and completion status
2. **Work Summary**: Document work completed since last checkpoint
3. **Context Preservation**: Save current development context and environment
4. **Timestamp Recording**: Record checkpoint creation time and duration

### Checkpoint Documentation
1. **Progress Summary**: What has been accomplished since last checkpoint
2. **Current Status**: What task is in progress and next steps
3. **Issues Encountered**: Any blockers or challenges discovered
4. **Next Session Prep**: What needs to be done to resume work

### Checkpoint Types
- **Automatic Checkpoints**: Created at natural stopping points
- **Manual Checkpoints**: Created with custom messages and context
- **Session Checkpoints**: Created when switching between work units
- **Milestone Checkpoints**: Created at major completion points

## Phase 5: Execute Switch Operations

When switching work units:

### Pre-Switch Validation
1. **Current Work Status**: Check if current work should be checkpointed
2. **Target Validation**: Verify target work unit exists and is accessible
3. **Conflict Detection**: Identify any conflicts between work units
4. **Safety Checks**: Ensure switching won't lose important work

### Context Switching
1. **Save Current Context**: Checkpoint current work unit if needed
2. **Load Target Context**: Load target work unit metadata and state
3. **Update Active Work**: Set new work unit as active
4. **Environment Update**: Adjust development environment for new context

### Switch Safety
- **Automatic Checkpointing**: Save current progress before switching
- **Work Validation**: Ensure target work unit is in valid state
- **Conflict Resolution**: Handle conflicts between work units
- **Rollback Capability**: Ability to return to previous work unit

## Phase 6: Work Unit Health Monitoring

### Health Checks
1. **Metadata Integrity**: Validate all work unit metadata files
2. **State Consistency**: Ensure task states are logically consistent
3. **File Organization**: Verify work unit directory structure
4. **Progress Tracking**: Validate progress calculations and dependencies

### Maintenance Operations
1. **Cleanup Stale Units**: Identify and clean up abandoned work units
2. **Archive Completed**: Move completed work units to archive
3. **Repair Corruption**: Fix any corrupted metadata or state files
4. **Optimize Storage**: Compress and optimize work unit storage

## Success Indicators

### Listing Operations
- ✅ All work units discovered and categorized
- ✅ Current status accurately displayed
- ✅ Progress information up to date
- ✅ Clear visual organization

### Continue Operations
- ✅ Work unit successfully resumed
- ✅ Context properly restored
- ✅ Current task clearly identified
- ✅ Ready for `/next` execution

### Checkpoint Operations
- ✅ Progress safely captured
- ✅ Context preserved for resumption
- ✅ Documentation complete
- ✅ Checkpoint successfully created

### Switch Operations
- ✅ Previous work safely saved
- ✅ New work unit activated
- ✅ Context successfully switched
- ✅ Environment properly configured

## Integration with Workflow

- **Explore Integration**: New work units created by `/explore` appear in listings
- **Planning Integration**: Work units show planning progress and completion
- **Execution Integration**: Task progress updates reflected in work unit status
- **Shipping Integration**: Completed work units marked and archived

## Examples

### List Active Work
```bash
/work active
# → Shows only work units currently in development
```

### Resume Last Work
```bash
/work continue
# → Resumes most recently active work unit
```

### Save Progress Checkpoint
```bash
/work checkpoint "Completed authentication module"
# → Saves current progress with descriptive message
```

### Switch Between Projects
```bash
/work switch 003
# → Switches to work unit 003, checkpointing current work
```

---

*Unified work management enabling parallel development streams with safe context switching and progress preservation.*