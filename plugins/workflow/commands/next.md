---
allowed-tools: [Task, Bash, Read, Write, MultiEdit, Grep, Glob, TodoWrite]
argument-hint: "[--task TASK-ID | --parallel [N|auto] | --preview | --status]"
description: "Execute the next available task(s) from the implementation plan with optional parallel execution"
@import .claude/memory/conventions.md
@import .claude/memory/lessons_learned.md
@import .claude/memory/project_state.md
---

# Task Execution (Enhanced with Parallel Execution)

I'll execute the next available task(s) from your implementation plan, with support for parallel execution of independent tasks.

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

# Check required tools
require_tool() {
    local tool="$1"
    if ! command -v "$tool" >/dev/null 2>&1; then
        error_exit "$tool is required but not installed"
    fi
}

# Parse arguments (ENHANCED for parallel execution)
MODE="execute"
TASK_ID=""
PARALLEL_MODE="none"  # "none", "auto", "count", "interactive"
PARALLEL_COUNT=1
SPECIFIC_TASKS=()

# Parse --parallel flag
if [[ "$ARGUMENTS" == *"--parallel"* ]]; then
    if [[ "$ARGUMENTS" =~ --parallel[[:space:]]+auto ]]; then
        PARALLEL_MODE="auto"
    elif [[ "$ARGUMENTS" =~ --parallel[[:space:]]+([0-9]+) ]]; then
        PARALLEL_MODE="count"
        PARALLEL_COUNT="${BASH_REMATCH[1]}"
    elif [[ "$ARGUMENTS" == *"--parallel"* ]] && [[ ! "$ARGUMENTS" =~ --parallel[[:space:]]+ ]]; then
        # Just "--parallel" with no args = interactive mode
        PARALLEL_MODE="interactive"
    fi
elif [[ "$ARGUMENTS" == *"--preview"* ]]; then
    MODE="preview"
elif [[ "$ARGUMENTS" == *"--status"* ]]; then
    MODE="status"
elif [[ "$ARGUMENTS" =~ --task[[:space:]]+([A-Z0-9-]+) ]]; then
    TASK_ID="${BASH_REMATCH[1]}"
fi

echo "🚀 Task Execution"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check for active work unit
if [ ! -f "${WORK_DIR}/ACTIVE_WORK" ]; then
    error_exit "No active work unit found. Run /explore or /work continue first."
fi

ACTIVE_WORK=$(cat "${WORK_DIR}/ACTIVE_WORK" 2>/dev/null || echo "")
if [ -z "$ACTIVE_WORK" ]; then
    error_exit "Active work unit is empty"
fi

WORK_UNIT_DIR="${WORK_DIR}/${ACTIVE_WORK}"
if [ ! -d "$WORK_UNIT_DIR" ]; then
    error_exit "Work unit directory not found: $WORK_UNIT_DIR"
fi

# Check for state.json
STATE_FILE="${WORK_UNIT_DIR}/state.json"
if [ ! -f "$STATE_FILE" ]; then
    error_exit "No state.json found. Run /plan first to create task breakdown."
fi

# Verify jq is available for JSON parsing
if ! command -v jq >/dev/null 2>&1; then
    warn "jq not installed - parallel execution requires jq"
    PARALLEL_MODE="none"
fi

echo "📁 Active Work Unit: $ACTIVE_WORK"

# Check work unit status
if command -v jq >/dev/null 2>&1; then
    STATUS=$(jq -r '.status // "unknown"' "$STATE_FILE" 2>/dev/null || echo "unknown")
    CURRENT_TASK=$(jq -r '.current_task // null' "$STATE_FILE" 2>/dev/null || echo "null")

    if [ "$STATUS" != "planning_complete" ] && [ "$STATUS" != "implementing" ]; then
        error_exit "Work unit status is '$STATUS'. Expected 'planning_complete' or 'implementing'."
    fi

    echo "📊 Status: $STATUS"
    if [ "$CURRENT_TASK" != "null" ] && [ -n "$CURRENT_TASK" ]; then
        echo "⏳ Current Task: $CURRENT_TASK"
    fi
fi

echo ""

case "$MODE" in
    preview)
        echo "📋 Available Tasks"
        echo "──────────────────"
        if command -v jq >/dev/null 2>&1; then
            jq -r '.tasks[]? | "\(.id) - \(.title) [\(.status)]"' "$STATE_FILE" 2>/dev/null || echo "Unable to parse tasks"
        else
            echo "Install jq for better task display"
        fi
        ;;

    status)
        echo "📊 Task Progress"
        echo "────────────────"
        if command -v jq >/dev/null 2>&1; then
            TOTAL=$(jq '.tasks | length' "$STATE_FILE" 2>/dev/null || echo "0")
            COMPLETED=$(jq '[.tasks[]? | select(.status == "completed")] | length' "$STATE_FILE" 2>/dev/null || echo "0")
            IN_PROGRESS=$(jq '[.tasks[]? | select(.status == "in_progress")] | length' "$STATE_FILE" 2>/dev/null || echo "0")
            PENDING=$(jq '[.tasks[]? | select(.status == "pending")] | length' "$STATE_FILE" 2>/dev/null || echo "0")

            echo "Total Tasks: $TOTAL"
            echo "✅ Completed: $COMPLETED"
            echo "🔄 In Progress: $IN_PROGRESS"
            echo "⏳ Pending: $PENDING"

            if [ $TOTAL -gt 0 ]; then
                PERCENT=$((COMPLETED * 100 / TOTAL))
                echo ""
                echo "Progress: ${PERCENT}%"
            fi
        else
            echo "Install jq for task status display"
        fi
        ;;

    execute)
        if [ "$PARALLEL_MODE" != "none" ]; then
            echo "🔍 Finding independent tasks for parallel execution..."

            # Find independent tasks using jq
            INDEPENDENT_TASKS_JSON=$(jq -c '
              # Get completed task IDs
              (.tasks[] | select(.status == "completed") | .id) as $completed |
              [.tasks[] | select(.status == "completed") | .id] as $completed_ids |

              # Find pending tasks with satisfied dependencies
              [.tasks[] |
                select(.status == "pending") |
                select(
                  (.dependencies // [] | length == 0) or
                  (.dependencies // [] | all(. as $dep | $completed_ids | index($dep)))
                )
              ] as $available |

              # Group by parallel_batch if it exists, otherwise treat each as independent
              if ($available[0].parallel_batch // null) then
                ($available | group_by(.parallel_batch) |
                 max_by(length))
              else
                $available
              end |

              # Return task details for parallel execution
              map({
                id: .id,
                title: .title,
                description: .description,
                type: .type,
                priority: .priority // "medium",
                dependencies: .dependencies // [],
                acceptance_criteria: .acceptance_criteria // [],
                estimated_hours: .estimated_hours // 0
              })
            ' "$STATE_FILE")

            TASK_COUNT=$(echo "$INDEPENDENT_TASKS_JSON" | jq 'length')

            if [ "$TASK_COUNT" -eq 0 ]; then
                echo "⚠️  No independent tasks available for execution."
                echo ""
                echo "Possible reasons:"
                echo "  • All pending tasks have unmet dependencies"
                echo "  • All tasks are already completed"
                echo "  • Tasks are blocked"
                echo ""
                echo "Run '/next --status' to see current state."
                exit 0
            fi

            # Determine how many tasks to run
            if [ "$PARALLEL_MODE" = "auto" ]; then
                TASKS_TO_RUN=$TASK_COUNT
                # Cap at 5 for safety
                if [ $TASKS_TO_RUN -gt 5 ]; then
                    TASKS_TO_RUN=5
                fi
            elif [ "$PARALLEL_MODE" = "count" ]; then
                TASKS_TO_RUN=$PARALLEL_COUNT
                if [ $TASKS_TO_RUN -gt $TASK_COUNT ]; then
                    TASKS_TO_RUN=$TASK_COUNT
                fi
            elif [ "$PARALLEL_MODE" = "interactive" ]; then
                # Display tasks and let user choose
                echo "Found $TASK_COUNT independent tasks:"
                echo ""
                echo "$INDEPENDENT_TASKS_JSON" | jq -r '.[] | "  • \(.id): \(.title) [\(.priority | ascii_upcase)]"'
                echo ""
                echo "How many tasks to execute in parallel?"
                echo "  (1-$TASK_COUNT, or 'all' for all tasks, max 5 recommended)"
                read -p "Your choice: " USER_CHOICE

                if [ "$USER_CHOICE" = "all" ]; then
                    TASKS_TO_RUN=$TASK_COUNT
                    if [ $TASKS_TO_RUN -gt 5 ]; then
                        TASKS_TO_RUN=5
                    fi
                elif [[ "$USER_CHOICE" =~ ^[0-9]+$ ]] && [ "$USER_CHOICE" -ge 1 ] && [ "$USER_CHOICE" -le "$TASK_COUNT" ]; then
                    TASKS_TO_RUN=$USER_CHOICE
                else
                    echo "Invalid choice. Defaulting to 1 task (sequential)."
                    TASKS_TO_RUN=1
                fi
            fi

            # Export task information for the main execution phase
            echo "$INDEPENDENT_TASKS_JSON" | jq -r --argjson count "$TASKS_TO_RUN" '.[:$count]' > /tmp/claude_parallel_tasks_$$.json

            echo ""
            echo "✅ Will execute $TASKS_TO_RUN task(s) in parallel"
            echo ""
        else
            # Traditional single task execution prep
            echo "🎯 Selecting next task..."
        fi
        ;;
esac
```

## Phase 1: Load Work Context and Validate State

I'll check the work environment before proceeding:

1. **Verify `.claude` directory exists** - Ensure we're in a Claude Code project
2. **Check for active work unit** - Look for `.claude/work/ACTIVE_WORK`
3. **Validate state file** - Ensure `state.json` exists and contains tasks
4. **Confirm readiness** - Work unit must be in `planning_complete` or `in_progress` status

If any validation fails, I'll provide clear error messages and guidance on how to proceed.

## Phase 2: Task Selection and Analysis (ENHANCED)

### Parallel Execution Mode

When `--parallel` flag is used, I'll:

1. **Find All Independent Tasks**: Query state.json for pending tasks with satisfied dependencies
2. **Group by Parallel Batch**: Use `parallel_batch` field if available, otherwise analyze dependencies
3. **Detect File Conflicts**: Analyze task descriptions for potential file overlaps
4. **Present Options**: Show user available tasks and get confirmation
5. **Prepare Task List**: Export selected tasks for parallel execution

### Independent Task Detection Algorithm

```javascript
// Implemented in jq within bash script
function findIndependentTasks(state) {
  // Get completed task IDs
  const completedIds = state.tasks
    .filter(t => t.status === "completed")
    .map(t => t.id);

  // Find pending tasks with satisfied dependencies
  const available = state.tasks.filter(task =>
    task.status === "pending" &&
    task.dependencies.every(dep => completedIds.includes(dep))
  );

  // Group by parallel_batch if exists
  if (available[0]?.parallel_batch) {
    const batches = groupBy(available, t => t.parallel_batch);
    return batches.sort((a, b) => b.length - a.length)[0];
  }

  // Otherwise, all available tasks are independent
  return available;
}
```

### Task Display Format (Parallel Mode)

```
🔍 Found 3 independent tasks:
   • TASK-101: Implement memory-review command [HIGH]
   • TASK-102: Implement memory-update command [HIGH]
   • TASK-103: Implement memory-gc command [HIGH]

How many tasks to execute in parallel?
  (1-3, or 'all' for all tasks, max 5 recommended)
Your choice: _
```

## Phase 3: Pre-Execution Validation

Same as before, with additions for parallel mode:

- **Parallel Safety Check**: Verify tasks are truly independent (no hidden dependencies)
- **Resource Check**: Ensure system has capacity for parallel execution
- **Conflict Warning**: Display any detected file conflicts

## Phase 4: Task Execution (ENHANCED for Parallel)

### Parallel Execution Strategy

When multiple tasks are selected:

1. **Read Task Details**: Load full task information from temp file
2. **Launch All Task Agents**: Single message with multiple Task tool invocations
3. **Monitor Progress**: Track each agent's completion
4. **Collect Results**: Gather success/failure status from all agents
5. **Process Results**: Update state for each task independently

### Task Agent Invocation Template

For each task in the parallel batch, I'll invoke:

```xml
<invoke name="Task">
  <parameter name="subagent_type">general-purpose</parameter>
  <parameter name="description">Execute {task.id}: {task.title}</parameter>
  <parameter name="prompt">
You are executing task {task.id} from the implementation plan.

**Task**: {task.title}
**Description**: {task.description}
**Type**: {task.type}
**Priority**: {task.priority}

**Acceptance Criteria**:
{criteria_list}

**Dependencies** (all satisfied):
{dependency_list}

**Instructions**:
1. Read and understand the task requirements thoroughly
2. Implement the solution meeting all acceptance criteria
3. Test your implementation thoroughly
4. Update any relevant documentation
5. Commit your changes with descriptive message

**Verification Required**:
- All acceptance criteria must be met
- Tests must pass (create tests if none exist)
- Code must follow project standards
- Documentation must be updated

**Return Format**:
Provide a structured completion summary with:
- **Status**: completed / blocked / failed
- **Files Created/Modified**: List all files touched
- **Tests Run**: Test results and coverage
- **Issues Encountered**: Any problems or blockers
- **Acceptance Criteria**: Mark each as ✅ met or ❌ not met
- **Time Spent**: Actual hours spent

Work autonomously but flag anything ambiguous or requiring user decision.
  </parameter>
</invoke>
```

**Critical**: All invocations must be in a **single message** for true parallel execution.

### Sequential Execution (Fallback)

If parallel execution not requested or only 1 task available, proceed with standard single-task execution.

## Phase 5: Continuous Quality Validation

Same quality checks as before, applied per task:

- **API Verification First**: Use Serena to verify APIs before writing code
- **Frequent Testing**: Run tests after significant changes
- **Code Quality**: Maintain linting and formatting standards
- **Security Scanning**: Check for vulnerabilities

## Phase 6: Post-Execution Validation and State Updates (ENHANCED)

### Parallel Results Processing

After parallel execution completes:

1. **Parse Agent Results**: Extract completion status from each agent response
2. **Categorize Results**: Group into completed, failed, blocked
3. **Update State Per Task**: Process each task result independently
4. **Maintain Consistency**: Ensure state.json remains valid even with partial failures
5. **Generate Summary Report**: Clear breakdown of what succeeded and failed

### State Update Logic

```javascript
// For each task result from parallel execution
for (const result of parallelResults) {
  const task = state.tasks.find(t => t.id === result.taskId);

  if (result.status === "completed") {
    task.status = "completed";
    task.completed_at = new Date().toISOString();
    task.actual_hours = result.timeSpent;
    task.deliverables = result.filesCreated;
  } else if (result.status === "blocked" || result.status === "failed") {
    task.status = "blocked";
    task.blocked_reason = result.error;
    task.blocked_at = new Date().toISOString();
  }
}

// Update completed_tasks and next_available arrays
state.completed_tasks = state.tasks
  .filter(t => t.status === "completed")
  .map(t => t.id);

// Recalculate next available tasks
state.next_available = findIndependentTasks(state.tasks, state.completed_tasks);

// Save state
fs.writeFileSync(stateFile, JSON.stringify(state, null, 2));
```

### Parallel Execution Report Format

```
📊 Parallel Execution Results
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ TASK-101 (memory-review): COMPLETED
   Files: commands/memory-review.md
   Tests: 3/3 passed
   Time: 2.5 hours

✅ TASK-102 (memory-update): COMPLETED
   Files: commands/memory-update.md
   Tests: 4/4 passed
   Time: 3.0 hours

❌ TASK-103 (memory-gc): BLOCKED
   Error: Missing dependency 'archival' module
   Resolution: Install module or adjust implementation
   State: Marked as blocked for investigation

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📈 Progress: 12/15 tasks complete (80%)
⏱️  Total Time: 5.5 hours (2.5 + 3.0 + partial)
⚡ Efficiency: 60% time savings vs sequential

🎯 Next Steps:
   • Investigate TASK-103 blocker (install archival module)
   • Run /workflow:next again for remaining 2 tasks
   • Or run /workflow:next --task TASK-103 after resolving blocker
```

## Phase 7: Automated Git Integration

### Batch Commit Strategy

For parallel execution, create a single commit encompassing all completed tasks:

```
feat: Complete parallel batch - Tasks 101, 102

Implemented memory management commands:
- TASK-101: memory-review command ✅
- TASK-102: memory-update command ✅

Files created:
- commands/memory-review.md
- commands/memory-update.md

Tests: 7/7 passed
Time: 5.5 hours (parallel execution)

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

Alternative: Allow user to choose per-task commits or batch commit.

## Phase 8: Work Unit Health and Next Steps

### Enhanced Next Steps for Parallel Mode

```
🎯 NEXT STEPS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ Completed 2/3 tasks in parallel batch
❌ 1 task blocked (TASK-103)
📊 Progress: 12/15 tasks complete (80%)

Options:
  1. Resolve TASK-103 blocker, then run /workflow:next --task TASK-103
  2. Run /workflow:next --parallel to execute remaining independent tasks
  3. Run /workflow:next for sequential execution
  4. Run /workflow:ship if all critical tasks complete

Remaining independent tasks: 2
Blocked tasks: 1 (needs resolution)
```

## Command Options (ENHANCED)

### New: Parallel Execution

```bash
# Interactive: Ask which tasks to run in parallel
/workflow:next --parallel

# Auto: Run all independent tasks (max 5)
/workflow:next --parallel auto

# Specific count: Run N tasks in parallel
/workflow:next --parallel 3

# Traditional single task (default)
/workflow:next
```

### Existing Options

```bash
/workflow:next --preview          # Show available tasks
/workflow:next --task TASK-003    # Execute specific task
/workflow:next --status           # Show progress
```

## Error Handling (ENHANCED)

### Partial Failure Handling

When some parallel tasks succeed and others fail:

1. **Process Successful Tasks**: Update state, commit changes
2. **Mark Failed Tasks**: Set status to blocked with error details
3. **Preserve Partial Progress**: Don't rollback successful work
4. **Clear Reporting**: Show exactly what succeeded and what failed
5. **Recovery Guidance**: Suggest specific next steps

### File Conflict Resolution

If multiple tasks modify the same file:

1. **Detection**: Git will show merge conflict
2. **Reporting**: Failed tasks marked as blocked
3. **Resolution**: User resolves conflict manually
4. **Retry**: Tasks can be re-run with `/workflow:next --task {id}`

### Complete Failure

If all tasks in parallel batch fail:

1. **No State Changes**: Tasks remain pending
2. **Error Analysis**: Display common causes
3. **Diagnostic Steps**: Suggest investigation actions
4. **Safe Rollback**: Work unit remains consistent

## Success Indicators (ENHANCED)

Parallel execution is successful when:

- ✅ 2+ tasks launched in single invocation
- ✅ All task agents complete (success or clear failure)
- ✅ State updated correctly for all tasks
- ✅ Partial failures handled gracefully
- ✅ Clear results report generated
- ✅ Next steps clearly communicated
- ✅ 50%+ time savings vs sequential execution

## Backwards Compatibility

This enhanced command maintains full backwards compatibility:

- **No --parallel flag**: Behaves exactly as before (single task)
- **Old state.json format**: Works without `parallel_batch` field
- **Existing workflows**: No breaking changes to current usage

## Performance Expectations

### Time Savings

For 3 independent tasks averaging 3 hours each:

- **Sequential**: 9 hours + user interaction time
- **Parallel**: ~3 hours (longest task) + minimal overhead
- **Savings**: ~67% wall-clock time, ~95% user interaction time

### Token Efficiency

- **Upfront Cost**: Higher (larger initial message with multiple Task invocations)
- **Total Cost**: Lower (fewer Claude API calls, less context repetition)
- **Net Benefit**: 20-30% token savings on multi-task workflows

---

*Systematic task execution with intelligent parallel processing for efficient multi-task implementation workflows.*
