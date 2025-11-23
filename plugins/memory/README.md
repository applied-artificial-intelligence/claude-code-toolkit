# Memory Plugin

Active memory management and maintenance for Claude Code framework. Keep project context fresh, organized, and relevant.

## Overview

The Memory plugin provides tools to manage Claude Code's persistent memory system. It helps you review memory state, update memory files interactively, and clean up stale entries. This ensures Claude maintains accurate, relevant context across sessions while avoiding outdated information.

## Memory System

Claude Code uses a file-based memory system located in `.claude/memory/`:

```
.claude/memory/
├── project_state.md       # Current project status and structure
├── decisions.md           # Architectural and design decisions
├── lessons_learned.md     # Insights and patterns discovered
├── conventions.md         # Code style and naming conventions
├── dependencies.md        # External libraries and tools
└── [domain-specific].md   # Custom memory files
```

**How it works**:
- Memory files are **loaded into every Claude Code session**
- Files use **@import syntax** for modular organization
- Content should be **concise, current, and actionable**
- Stale information **degrades Claude's effectiveness**

## Features

- **Memory Review**: Inspect current memory state with metadata
- **Interactive Updates**: Add, update, remove, or relocate memory entries
- **Garbage Collection**: Identify and clean stale entries automatically
- **Auto-Reflection**: Suggest memory updates at task completion
- **Context Optimization**: Keep memory lean and relevant

## Commands

### `/memory-review`
Display current memory state with timestamps, sizes, and staleness indicators.

**What it does**:
- Lists all memory files in `.claude/memory/`
- Shows file sizes and line counts
- Displays last modified timestamps
- Identifies stale entries (>30 days old)
- Calculates total memory usage
- Highlights optimization opportunities

**Usage**:
```bash
/memory-review              # Review all memory files
```

**Output Example**:
```
Memory Files Review
===================

project_state.md
  Size: 3.2 KB (82 lines)
  Modified: 2 days ago
  Status: ✅ Current

decisions.md
  Size: 5.4 KB (148 lines)
  Modified: 1 week ago
  Status: ✅ Current

lessons_learned.md
  Size: 8.1 KB (210 lines)
  Modified: 45 days ago
  Status: ⚠️  Stale (consider reviewing)

conventions.md
  Size: 1.8 KB (52 lines)
  Modified: 3 days ago
  Status: ✅ Current

---
Total Memory: 18.5 KB (492 lines)
Stale Files: 1
Recommendation: Review lessons_learned.md
```

**When to use**:
- ✅ Before starting new work (check current context)
- ✅ After long breaks (verify memory is current)
- ✅ When context feels off (audit memory state)
- ✅ Before /memory-gc (see what will be cleaned)
- ✅ Regular maintenance (monthly review)

### `/memory-update`
Interactive memory maintenance with add, update, remove, and relocate operations.

**What it does**:
- Guides you through memory update workflow
- Suggests updates based on recent work
- Adds new knowledge to appropriate files
- Updates existing entries
- Removes outdated information
- Reorganizes memory structure

**Usage**:
```bash
/memory-update              # Interactive memory update workflow
```

**Workflow**:
1. **Review Recent Work**: Analyzes recent commits, completions, decisions
2. **Suggest Updates**: Proposes memory additions/updates
3. **Interactive Editing**:
   - Add new entries
   - Update existing entries
   - Remove outdated entries
   - Relocate entries to better files
4. **Apply Changes**: Updates memory files
5. **Verify**: Shows what changed

**Operations**:

**Add New Entry**:
```bash
/memory-update
> Operation: add
> File: decisions.md
> Entry: "Use PostgreSQL for data persistence (MongoDB too complex for our use case)"
```

**Update Existing Entry**:
```bash
/memory-update
> Operation: update
> File: dependencies.md
> Find: "React 17.0.2"
> Replace: "React 18.2.0 (upgraded for concurrent features)"
```

**Remove Outdated Entry**:
```bash
/memory-update
> Operation: remove
> File: lessons_learned.md
> Entry: "Initial SQLite approach was too slow (replaced with PostgreSQL)"
```

**Relocate Entry**:
```bash
/memory-update
> Operation: relocate
> From: lessons_learned.md
> To: decisions.md
> Entry: "GraphQL adoption decision"
> Reason: "More appropriate in decisions.md"
```

**When to use**:
- ✅ After completing major feature (/ship auto-suggests)
- ✅ After making architectural decision
- ✅ After discovering important lesson
- ✅ After changing dependencies/conventions
- ✅ When /memory-review shows missing context

### `/memory-gc`
Garbage collection for stale memory entries - identify and clean up obsolete content.

**What it does**:
- Scans all memory files for stale entries
- Identifies information >30 days old with no recent references
- Detects superseded decisions
- Finds completed temporary tasks
- Proposes removals with rationale
- Optionally auto-cleans with confirmation

**Usage**:
```bash
/memory-gc                  # Analyze and suggest cleanup
/memory-gc --auto           # Auto-clean with confirmation
/memory-gc --dry-run        # Show what would be cleaned (no changes)
```

**Staleness Criteria**:
- **>30 days**: No modification in last month
- **Superseded**: Newer decision contradicts old one
- **Completed**: Task/work unit finished
- **Irrelevant**: Context no longer applicable
- **Redundant**: Duplicate information

**Output Example**:
```
Memory Garbage Collection
=========================

Stale Entries Found: 8

decisions.md
  ⚠️  "Use MongoDB for persistence" (45 days old)
      Superseded by: "Use PostgreSQL" (2 days ago)
      Recommendation: Remove

lessons_learned.md
  ⚠️  "TypeScript strict mode causes too many issues" (60 days old)
      Status: No longer relevant (now using strict mode successfully)
      Recommendation: Remove or update

  ⚠️  "Initial API design with REST" (90 days old)
      Superseded by: "GraphQL adoption" (10 days ago)
      Recommendation: Archive

---
Suggested Removals: 3
Suggested Updates: 2
Suggested Archives: 3

Apply changes? [y/N]
```

**Safety Features**:
- Shows what will be removed before doing it
- Requires confirmation for destructive operations
- Backs up before cleanup (`.claude/memory/.backup/`)
- Dry-run mode for safe preview

**When to use**:
- ✅ Monthly maintenance routine
- ✅ Before major milestones (keep memory lean)
- ✅ When memory grows >20KB (optimize)
- ✅ After pivots or major changes (clean old context)
- ✅ When Claude references outdated info

### `/index [--update] [--refresh] [focus_area]`
Create and maintain persistent project understanding through comprehensive project mapping.

**What it does**:
- Analyzes project structure and architecture
- Maps dependencies and relationships
- Identifies key components and patterns
- Creates searchable project index
- Updates index as project evolves

**Usage**:
```bash
/index                          # Create initial project index
/index --update                 # Update existing index
/index --refresh                # Rebuild index from scratch
/index backend                  # Focus on backend code
```

**Output**:
- `.claude/index/` - Project mapping and analysis
- Architectural overview
- Component relationships
- Key patterns and conventions

**When to use**:
- ✅ New project onboarding
- ✅ After major refactoring
- ✅ Before large features (understand context)
- ✅ Periodic updates (monthly)

### `/handoff`
Create transition documents with context analysis for session continuity.

**What it does**:
- Analyzes current session context and progress
- Documents work state and decisions
- Creates transition summary for next session
- Preserves token usage and memory state
- Updates symlink to latest handoff

**Usage**:
```bash
/handoff                        # Create handoff document
```

**Output**:
- `.claude/transitions/YYYY-MM-DD_NNN/handoff.md`
- Session summary and progress
- Current work state and next steps
- Context health metrics
- Recommendations for next session

**When to use**:
- ✅ End of work session (before closing)
- ✅ Context approaching 80%+ usage
- ✅ Before major context switches
- ✅ Milestone completions

**Next step**: Use `/clear` then `/continue` to resume from this handoff

### `/continue`
Auto-load and resume from the most recent handoff document with verification.

**What it does**:
- Finds latest handoff via `.claude/transitions/latest/handoff.md` symlink
- Verifies symlink points to actual newest handoff (not stale)
- Loads handoff context automatically
- Briefs you on session focus, active work, and next steps

**Usage**:
```bash
# After /clear, simply:
/continue                       # Auto-loads latest handoff
```

**Output Example**:
```
📋 Continuing from: .claude/transitions/2025-10-18_005/handoff.md

Session Focus: Plugin v1.0.0 delivery
Active Work: Completed work unit 009, shipped v1.0.0
Next Steps: Applied AI website work

Main Takeaways:
- Plugin architecture refactored to 6 focused plugins
- Web development plugin fixed and ready

Ready to continue. What would you like to work on?
```

**When to use**:
- ✅ After `/clear` to resume work
- ✅ Starting new session
- ✅ Returning after break

**Workflow**:
```bash
# End session
/handoff

# Clear conversation
/clear

# Resume in new session
/continue
```

### `/performance`
View token usage and performance metrics across all components.

**What it does**:
- Shows real-time token breakdown by component
- Tracks conversation, MCP, memory, system usage
- Identifies optimization opportunities
- Monitors context health (70%, 80%, 90% thresholds)
- Provides actionable recommendations

**Usage**:
```bash
/performance                    # View current metrics
```

**Output Example**:
```
Token Usage Breakdown
=====================
Messages (conversation): 45,234 tokens (30%)
MCP Tools (servers):     18,500 tokens (12%)
Memory Files (context):   8,100 tokens (5%)
System (prompt):         12,000 tokens (8%)
Reserved (buffer):       15,000 tokens (10%)
Available:               51,166 tokens (35%)

Total: 150,000 / 200,000 (75%)
Status: ⚠️  Warning - Optimize proactively

Recommendations:
- Consider /clear after /handoff (free conversation tokens)
- Disable unused MCP servers (12K tokens)
- Review memory files for optimization
```

**When to use**:
- ✅ Session start (baseline metrics)
- ✅ Every 10-15 interactions (monitor)
- ✅ Before major operations (check headroom)
- ✅ When responses seem degraded

## Auto-Reflection

The memory plugin integrates with other commands to suggest updates automatically:

**After /ship**:
```
Feature shipped: User authentication

Memory Update Suggestions:
1. Add to decisions.md:
   "Use JWT for authentication (bcrypt for password hashing)"

2. Add to lessons_learned.md:
   "Pre-hashing passwords before validation improves security"

3. Update dependencies.md:
   "Added: jsonwebtoken v9.0.0, bcrypt v5.1.0"

Run /memory-update to apply? [y/N]
```

**After /fix**:
```
Fixed: Memory leak in data processing

Memory Update Suggestion:
Add to lessons_learned.md:
"Large datasets must be processed in streams, not loaded entirely into memory"

Run /memory-update to apply? [y/N]
```

**After /review**:
```
Code review completed: Found 12 issues

Memory Update Suggestion:
Add to conventions.md:
"Always validate input before processing (3 validation issues found today)"

Run /memory-update to apply? [y/N]
```

## Memory File Guidelines

### project_state.md
**Purpose**: Current project status and structure
**Update Frequency**: Weekly or at major milestones
**Contents**:
- Project overview
- Current phase/status
- Active work units
- Key metrics
- Recent changes

**Example**:
```markdown
# Project State

## Overview
Building user authentication system for SaaS platform.

## Current Status
Phase: Implementation (Week 3 of 4)
Active Work: OAuth integration
Tests: 87% coverage

## Structure
- `/src/auth` - Authentication modules
- `/src/users` - User management
- `/tests/integration` - Integration tests

## Recent Changes
- 2024-10-15: Migrated from MongoDB to PostgreSQL
- 2024-10-12: Added JWT authentication
```

### decisions.md
**Purpose**: Architectural and design decisions
**Update Frequency**: When making decisions
**Contents**:
- Technology choices
- Architecture patterns
- Design tradeoffs
- Rationale for decisions

**Example**:
```markdown
# Architectural Decisions

## Database: PostgreSQL
**Decision**: Use PostgreSQL instead of MongoDB
**Rationale**:
- Need ACID transactions
- Complex relational data
- Team expertise in SQL
**Date**: 2024-10-15

## Authentication: JWT
**Decision**: JWT-based authentication
**Rationale**:
- Stateless (scales better)
- Standard format
- Easy client integration
**Date**: 2024-10-12
```

### lessons_learned.md
**Purpose**: Insights and patterns discovered
**Update Frequency**: When learning something valuable
**Contents**:
- Mistakes and solutions
- Performance insights
- Best practices discovered
- "Next time" notes

**Example**:
```markdown
# Lessons Learned

## Stream Large Datasets
**Context**: Processing 10GB CSV files
**Problem**: Loading entire file into memory caused crashes
**Solution**: Use streaming with 100MB chunks
**Lesson**: Always stream data >1GB
**Date**: 2024-10-10

## Pre-hash Passwords
**Context**: User authentication implementation
**Problem**: Hashing during validation was slow
**Solution**: Hash passwords before storing
**Lesson**: Expensive operations should happen once
**Date**: 2024-10-12
```

### conventions.md
**Purpose**: Code style and naming conventions
**Update Frequency**: When establishing patterns
**Contents**:
- Naming conventions
- Code style rules
- File organization
- Testing patterns

**Example**:
```markdown
# Conventions

## Naming
- **Files**: kebab-case (user-service.js)
- **Classes**: PascalCase (UserService)
- **Functions**: camelCase (getUserById)
- **Constants**: UPPER_SNAKE (MAX_RETRIES)

## Testing
- Test files: `*.test.js`
- One describe block per function
- Test structure: Arrange, Act, Assert
- Coverage target: >80%

## File Organization
- One class per file
- Max 300 lines per file
- Group related functions
```

### dependencies.md
**Purpose**: External libraries and tools
**Update Frequency**: When adding/updating dependencies
**Contents**:
- Libraries and versions
- CLI tools
- Services/APIs
- Configuration requirements

**Example**:
```markdown
# Dependencies

## Core Libraries
- **express**: 4.18.2 (Web framework)
- **postgresql**: 14.5 (Database)
- **jsonwebtoken**: 9.0.0 (Authentication)
- **bcrypt**: 5.1.0 (Password hashing)

## Development Tools
- **jest**: 29.3.1 (Testing)
- **eslint**: 8.28.0 (Linting)
- **prettier**: 2.8.0 (Formatting)

## Services
- **GitHub**: Code hosting
- **AWS RDS**: PostgreSQL hosting
- **Sentry**: Error monitoring
```

## Best Practices

### Do
- ✅ Update memory after significant work
- ✅ Keep entries concise (2-4 lines max)
- ✅ Date important decisions
- ✅ Remove outdated information
- ✅ Run /memory-gc monthly
- ✅ Review memory before starting work

### Don't
- ❌ Copy entire code snippets (link instead)
- ❌ Document temporary decisions
- ❌ Keep superseded information
- ❌ Let memory grow >25KB
- ❌ Forget to update after major changes

### Optimization Tips

1. **Keep It Lean**: Target <20KB total memory
2. **Be Specific**: "Use PostgreSQL" > "Consider different databases"
3. **Date Decisions**: Helps identify stale entries
4. **One Topic Per Entry**: Easier to update/remove
5. **Link, Don't Copy**: Reference code/docs instead of duplicating

## Integration with Other Plugins

### Workflow Plugin
**Auto-reflection points**:
- `/explore complete`: Suggest project_state update
- `/plan created`: Suggest decisions.md entries
- `/ship complete`: Prompt for lessons_learned

### Development Plugin
**Auto-reflection points**:
- `/review complete`: Suggest conventions updates
- `/fix applied`: Prompt for lessons_learned
- `/test coverage`: Update quality metrics

### System Plugin
- `/status` shows memory state
- `/cleanup` can archive old memory
- `/audit` validates memory structure

## Configuration

### Memory Settings (`.claude/config.json`)
```json
{
  "memory": {
    "autoReflection": true,
    "staleThresholdDays": 30,
    "maxMemorySizeKB": 25,
    "autoBackup": true,
    "gcFrequency": "monthly"
  }
}
```

### Auto-Reflection Triggers
```json
{
  "memory": {
    "reflectionTriggers": {
      "ship": true,
      "fix": true,
      "review": true,
      "explore": false
    }
  }
}
```

### GC Settings
```json
{
  "memory": {
    "gc": {
      "autoClean": false,
      "requireConfirmation": true,
      "createBackup": true,
      "staleThresholdDays": 30
    }
  }
}
```

## Dependencies

### Required
None - Memory plugin is standalone

### Optional MCP Tools
- **Sequential Thinking**: Enhances memory analysis and suggestions

**Graceful Degradation**: All commands work without MCP tools.

## Metrics

The memory plugin tracks:
- **Memory size**: Total KB across all files
- **File count**: Number of memory files
- **Update frequency**: How often memory is updated
- **Stale entries**: Count of entries >30 days old
- **GC statistics**: Entries removed, size freed

View with:
```bash
/memory-review
/status verbose
```

## Troubleshooting

### Memory files not loading
- **Check location**: Files must be in `.claude/memory/`
- **Check syntax**: Valid markdown required
- **Check permissions**: Files must be readable

### /memory-gc removes too much
- **Adjust threshold**: Increase `staleThresholdDays` in config
- **Use --dry-run**: Preview before actual cleanup
- **Manual review**: Review suggestions before confirming

### Memory growing too large
- **Run /memory-gc**: Clean stale entries
- **Remove code snippets**: Link instead of copying
- **Archive old content**: Move to `.claude/archives/`
- **Split files**: Break large files into focused ones

### Auto-reflection not working
- **Check config**: Verify `autoReflection: true`
- **Check triggers**: Ensure command triggers are enabled
- **Manual update**: Use `/memory-update` directly

## Examples

### Example 1: New Project Setup
```bash
# Review current memory (likely empty)
/memory-review

# Add initial project state
/memory-update
> add project_state.md
> "New SaaS authentication project, using Node.js + PostgreSQL"

# Document initial decisions
/memory-update
> add decisions.md
> "Technology stack: Node.js, Express, PostgreSQL, JWT"
```

### Example 2: After Feature Completion
```bash
# Ship feature
/ship --pr

# Auto-reflection suggests updates
Memory Update Suggestions:
1. Add decision: "Use JWT for authentication"
2. Add lesson: "Pre-hash passwords for performance"

# Apply suggestions
/memory-update
> (apply suggestions)

# Review updated state
/memory-review
```

### Example 3: Monthly Maintenance
```bash
# Review current state
/memory-review
# Shows: lessons_learned.md is 45 days old

# Run garbage collection
/memory-gc --dry-run
# Shows: 5 stale entries found

# Apply cleanup
/memory-gc
> Confirm cleanup? y

# Verify
/memory-review
# Shows: Memory optimized, all files current
```

## Support

- **Documentation**: [Memory Management Guide](../../docs/guides/memory-management.md)
- **Issues**: [GitHub Issues](https://github.com/applied-artificial-intelligence/claude-code-toolkit/issues)
- **Discussions**: [GitHub Discussions](https://github.com/applied-artificial-intelligence/claude-code-toolkit/discussions)

## License

MIT License - see [LICENSE](../../LICENSE) for details.

---

**Version**: 1.1.0
**Category**: Core
**Commands**: 7 (memory-review, memory-update, memory-gc, index, handoff, continue, performance)
**Dependencies**: None
**MCP Tools**: Optional (sequential-thinking)
