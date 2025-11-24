# Claude Code Plugins

**Production-tested plugins for structured AI-assisted development**

> Enterprise plugin framework built over 6 months of production use: technical books, content production, and framework development.

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

---

## Quick Start

### Installation (Company Internal)

**Option 1: Marketplace Configuration (Recommended)**

Add to any project's `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "local": {
      "source": {
        "source": "directory",
        "path": "/home/stefan/agents/plugins"
      }
    }
  },
  "enabledPlugins": {
    "setup@local": true,
    "system@local": true,
    "workflow@local": true,
    "development@local": true,
    "transition@local": true,
    "memory@local": true
  }
}
```

**Option 2: Copy to Project**

```bash
# For specific project without marketplace setup
cp -r /home/stefan/agents/plugins/{system,workflow,memory,development} \
  ~/my-project/.claude/plugins/
```

### First Commands

```bash
# Navigate to your project
cd ~/my-project/

# Initialize with setup
/setup:python  # or /setup:javascript, /setup:existing

# Start systematic workflow
/explore "add user authentication"
/plan
/next
```

---

## What This Is

A collection of Claude Code plugins that enforce systematic workflows, prevent common pitfalls, and enable productive AI-assisted development. These aren't theoretical best practices—they're patterns we built solving real problems in production.

**Core plugins** (5):
- **setup** - Project initialization and configuration
- **system** - System health and maintenance
- **workflow** - Structured task execution (explore → plan → next → ship)
- **memory** - Context management and session handoffs
- **development** - Code analysis, review, testing, and external review preparation

**Domain plugins** (7):
- **quant** - Quantitative finance workflows with validators
- **ml3t-researcher** - ML research with paper search (v2.0: RAG with Qdrant)
- **ml3t-coauthor** - Book production workflow (v1.1: writing-skills integration)
- **reports** - Professional report generation
- **content-marketing** - Technical B2B content production (v1.3: website copy generation)
- **web-development** - Full-stack web development (Django + Tailwind)
- **diagrams** - D2 diagram generation with visual design expertise

**Utility plugins** (1):
- **writing-skills** - Shared writing methodology library (10 skills)

**Total**: 13 active plugins (5 core + 7 domain + 1 utility)

---

## Why We Built This

Claude Code is powerful but has constraints that break productivity if you don't work systematically:

**Context perception error**: Claude reports ~30% lower usage than actual (shows "64%" when actual is 92%)
**Hallucination risks**: Agents fabricate plausible details without systematic verification
**Execution constraints**: Commands run in project directory, not `~/.claude/`, preventing utility sharing

Our plugin framework provides guardrails that work productively within these constraints.

---

## Core Workflow Commands

### Systematic Task Execution: /explore → /plan → /next → /ship

**`/explore [description]`** - Systematic requirements and codebase analysis
```bash
/explore "add payment processing"
# Analyzes: requirements, current implementation, integration points, recommendations
# Creates: Work unit with exploration findings
```

**`/plan [--from-requirements]`** - Create structured implementation plan with task breakdown
```bash
/plan --from-requirements
# Creates: Ordered tasks with dependencies, state tracking, progress monitoring
# Output: implementation-plan.md with 5-15 tasks
```

**`/next [--task TASK-ID] [--parallel N]`** - Execute next task from plan
```bash
/next                    # Execute next pending task
/next --task TASK-03     # Execute specific task
/next --parallel 3       # Execute 3 tasks in parallel
```

**`/ship [--commit|--pr|--deploy]`** - Deliver completed work with validation
```bash
/ship --pr
# Validates: All tasks complete, tests passing, documentation current
# Creates: Pull request with comprehensive summary
```

### Work Unit Management

**`/work [active|paused|completed|all]`** - List and manage work units
```bash
/work                    # List all work units
/work active             # List only active units
/work switch 2025-11-15_01_feature_name  # Switch to different work unit
```

**Work units** are organized as: `.claude/work/YYYY-MM-DD_NN_description/`
- Date-based chronological ordering
- No lost counters
- Simple flat structure

---

## Memory & Context Management

### Critical Context Commands

**`/handoff`** - Create session handoff **before context limits**
```bash
/handoff
# When to use: At 70% perceived usage (~85% actual)
# Creates: .claude/transitions/YYYY-MM-DD/HHMMSS.md
# Preserves: Active work, decisions, next steps, current task state
```

**`/continue [transition-file]`** - Resume from most recent handoff
```bash
# After /clear:
continue
# Or explicitly:
continue from .claude/transitions/2025-11-15/223452.md
```

**`/index [--update] [focus_area]`** - Create persistent project knowledge base
```bash
/index
# Analyzes: Project structure, patterns, conventions
# Generates: Memory files in .claude/memory/ loaded via @import
```

**CRITICAL**: `/handoff` at 70% perceived usage prevents quality degradation. Context perception error means "64% shown" = "92% actual". By the time you notice quality issues, hallucinations have already entered output.

---

## Development Commands

**`/analyze [focus_area] [--semantic]`** - Deep codebase analysis
```bash
/analyze app/services/ --semantic
# With Serena MCP: Semantic code understanding, 70-90% token reduction
# Without MCP: Standard file reading and grep search
```

**`/review [file/directory] [--systematic] [--semantic]`** - Code review with quality checks
```bash
/review app/services/payment.py --systematic
# Checks: Bugs, design flaws, dead code, security, best practices
# Output: Prioritized action plan
```

**`/test [tdd] [pattern]`** - Test-driven development workflow
```bash
/test tdd "payment processing"
# Creates: Test-first development cycle
# Invokes: test-engineer agent for test creation
```

**`/fix [error|review|audit|all] [pattern]`** - Debug and apply fixes
```bash
/fix error "payment validation"
# With Serena: Semantic error location and fixing
# Applies: Review fixes or audit findings automatically
```

**`/prepare-review [focus]`** - Package codebase for external code review
```bash
/prepare-review "API authentication"
# Creates: Token-efficient RepoMix package (<100k tokens)
# Output: .claude/external_reviews/YYYY-MM-DD-HHMM/review_package.md
# Uses: Sequential Thinking for intelligent file selection
```

**`/docs fetch|search|generate [args]`** - Documentation operations
```bash
/docs fetch stripe    # Fetch external library docs
/docs search "auth"   # Search all documentation
/docs generate        # Generate project docs
```

**`/git commit|pr|issue [args]`** - Unified git operations
```bash
/git commit -m "feat: Add payment processing"
/git pr --title "Payment integration"
/git issue #123      # Work on specific issue
```

---

## System & Setup Commands

**`/setup:python`** - Initialize Python project with Claude Code framework
```bash
/setup:python
# Creates: .claude/ structure, settings.json, enables core plugins
# Configures: pytest, ruff, mypy integration
```

**`/setup:javascript`** - Initialize JavaScript/TypeScript project
```bash
/setup:javascript
# Creates: .claude/ structure, settings.json
# Configures: ESLint, TypeScript, Jest integration
```

**`/setup:existing`** - Add Claude Code to existing project
```bash
/setup:existing
# Analyzes: Current project structure and tooling
# Creates: Minimal .claude/ configuration
```

**`/audit [--framework|--tools|--fix]`** - Framework compliance validation
```bash
/audit --framework
# Validates: Plugin setup, manifest schemas, command structure
```

**`/cleanup [--dry-run|--auto] [root|tests|reports|work|all]`** - Clean up generated clutter
```bash
/cleanup --dry-run all
# Identifies: Duplicate docs, orphaned files, old artifacts
# Consolidates: Documentation into proper structure
```

**`/system:status [verbose]`** - Current project and task status
```bash
/system:status
# Shows: Active work unit, task progress, git status, memory usage
```

---

## Installation Troubleshooting

### Common Issues

**1. Commands not appearing**

**Problem**: After adding to `.claude/settings.json`, commands don't show up.

**Solution**:
```bash
# Restart Claude Code completely
# In VS Code: Cmd/Ctrl+Shift+P → "Claude Code: Restart"

# Verify plugin path is correct
ls /home/stefan/agents/plugins/workflow/commands/
# Should show: explore.md, plan.md, next.md, ship.md, work.md
```

**2. Plugin manifest validation errors**

**Problem**: Plugins fail to load silently with no error message.

**Solution**:
```bash
# Validate each plugin manifest
cd /home/stefan/agents/plugins
for plugin in */; do
  echo "Validating $plugin..."
  jq empty "$plugin/.claude-plugin/plugin.json" && echo "✅ $plugin" || echo "❌ $plugin"
done
```

**3. Commands execute but do nothing**

**Problem**: Commands run but don't create expected files or output.

**Solution**: Commands execute in **project directory**, not in `~/.claude/`. Ensure you're in correct directory:
```bash
pwd  # Should be your project root, not ~/.claude/
```

**4. Context perception issues**

**Problem**: Claude says "64% usage" but quality is degrading.

**Solution**: **Always handoff at 70% perceived usage**. Actual usage is ~30% higher. By 85% actual (64% shown), hallucinations begin.

```bash
# Check actual context usage:
/context  # Shows real token breakdown

# Create handoff proactively:
/handoff
```

**5. /continue doesn't find latest transition**

**Problem**: After `/handoff` and `/clear`, running "continue" doesn't load transition.

**Solution**: Claude Code may ignore the continue command and check running processes first (internal command structure). Use explicit path:
```bash
# Copy the transition file path from /handoff output
continue from .claude/transitions/2025-11-15/223452.md
```

**6. Work units in wrong location**

**Problem**: Work units created in `~/.claude/work/` instead of project.

**Solution**: Ensure project has `.claude/` directory:
```bash
# Initialize if missing
/setup:existing

# Verify structure
ls .claude/work/
# Should show: 2025-11-XX_NN_description/ directories
```

---

## Per-Project Plugin Selection

Different projects enable different plugin combinations:

**Book project**:
```json
{
  "enabledPlugins": {
    "system@local": true,
    "workflow@local": true,
    "development@local": true,
    "transition@local": true,
    "memory@local": true,
    "ml3t-researcher@local": true,
    "ml3t-coauthor@local": true,
    "writing-skills@local": true
  }
}
```

**Quant/Trading project**:
```json
{
  "enabledPlugins": {
    "system@local": true,
    "workflow@local": true,
    "development@local": true,
    "transition@local": true,
    "memory@local": true,
    "quant@local": true
  }
}
```

**Web development project**:
```json
{
  "enabledPlugins": {
    "setup@local": true,
    "system@local": true,
    "workflow@local": true,
    "development@local": true,
    "transition@local": true,
    "memory@local": true,
    "web-development@local": true
  }
}
```

**Content/Marketing project**:
```json
{
  "enabledPlugins": {
    "system@local": true,
    "workflow@local": true,
    "development@local": true,
    "transition@local": true,
    "memory@local": true,
    "content-marketing@local": true,
    "writing-skills@local": true
  }
}
```

---

## Key Lessons Learned (6 Months Production)

### 1. Handoff at 70% Perceived Usage

**Problem**: Context perception is ~30% off. Claude shows "64%" when actual is 92%.

**Solution**: Create `/handoff` at 70% perceived usage (roughly 85% actual). Quality degrades before Claude realizes—by the time you notice issues, hallucinations have already entered output.

**Impact**: Maintained quality across 24,836-word technical report with zero hallucinations.

### 2. Clean Background Processes Before Handoff

**Problem**: `/continue` loses focus when 11+ background processes create system reminders.

**Solution**: Kill all background processes before creating handoff. Clean environment enables reliable continuation.

### 3. Embrace Duplication When Execution Context Requires It

**Problem**: Commands execute in project directory, not `~/.claude/`. Cannot source external utilities.

**Solution**: Copy utilities inline to each command. Duplication is not a bug—it's the price of functionality.

**Rationale**: We spent 8-12 hours building sophisticated shared utilities. Usage: **zero**. Working duplicated code beats elegant broken abstractions.

### 4. Fact Manifests Prevent Hallucinations

**Problem**: Agents fabricate plausible details (names, dates, metrics) without verification.

**Solution**: Track every quantitative claim to source file and line number. Run section checkpoints every 1,500-2,000 words.

**Impact**: Caught 1 hallucination during checkpoints before it contaminated 24,836-word final output.

### 5. Schema Validation Matters

**Problem**: Invalid `plugin.json` breaks command loading silently. No error messages.

**Solution**: Validate schema before shipping:
```bash
jq empty .claude-plugin/plugin.json && echo "✅ Valid" || echo "❌ Invalid"
```

**Lesson**: We broke 13 projects simultaneously with invalid schema. Spent 3+ hours trial-and-error before reading docs. **Always validate manifests.**

---

## Production Use Cases

### ML4T Textbook (25 Chapters, 6 Months)

**Challenge**: Write technical book with code examples, academic citations, and consistent learning objectives

**Plugins Used**:
- `workflow` - Systematic chapter development
- `ml3t-researcher` - Literature review (semantic search over 79,957 indexed papers)
- `ml3t-coauthor` - Learning objective validation
- `memory` - Context management across 25 parallel chapters

**Results**:
- Literature review time: 2.5 hours vs 8-12 hours manual (67-75% reduction)
- Citation accuracy: 92% with semantic search
- Handoff discipline prevented cross-contamination between chapters

### Automation Discovery Whitepaper (24,836 Words)

**Challenge**: Produce publication-quality technical content without hallucinations

**Plugins Used**:
- `workflow` - Section-by-section systematic drafting
- `memory` - Handoffs at 70% perceived usage (before quality degradation)
- `reports` - Fact manifest tracking and section checkpoints

**Results**:
- Production time: 40 hours vs 100-120 manual (60-67% reduction)
- **Zero hallucinations in final output** (fact manifest caught issues at checkpoints)
- All metrics exact (76.4% not "~75%", maintained precision throughout)

### Plugin Framework Development (This Repo, 6 Months)

**Challenge**: Build production-ready plugin system for Claude Code

**Plugins Used**:
- `workflow` - Feature development
- `development` - Code review and testing
- `memory` - Context management during rapid iteration

**Results**:
- 13 plugins shipped
- Testing infrastructure complete
- Used daily in production across multiple projects

---

## When Claude Code Excels

✅ Multi-file coordinated refactoring
✅ Systematic workflow automation (explore → plan → next → ship)
✅ Content production with verification (fact manifests + checkpoints)
✅ Domain-specific work with specialized plugins
✅ Long-form technical writing (with handoff discipline)

**Real gains**: 30-40% feature development reduction, 60-67% content production reduction, 67-75% literature review reduction with researcher plugin.

---

## When Claude Code Struggles

❌ Real-time systems (no persistent connections)
❌ Background monitoring (stateless execution model)
❌ One-off simple tasks (overhead not worth it)
❌ GUI applications (terminal-only)

**Work within constraints**: Context limits require handoffs. Hallucination risks require systematic verification. Execution context requires duplication. Don't fight the framework—build guardrails that work within it.

---

## ROI Reality

**Investment**:
- Learning curve: 2-4 weeks to productivity
- Setup per project: 30-60 minutes (plugin activation, memory files)
- Ongoing discipline: 10-15% overhead (handoffs, checkpoints, verification)

**Returns**:
- 30-40% feature development reduction
- 60-67% content production reduction
- 67-75% literature review reduction with researcher plugin
- Overall: 2-5x productivity gain for systematic users when discipline maintained

**The framework doesn't eliminate effort—it channels effort into systematic verification that prevents expensive mistakes.**

---

## Plugin Architecture

### Official Claude Code Structure

```
plugin-name/
├── .claude-plugin/
│   └── plugin.json          # Manifest (name, version, author, commands)
├── commands/                # Slash commands at ROOT
│   └── command-name.md
├── agents/                  # Specialized agents at ROOT
│   └── agent-name.md
├── hooks/                   # Event handlers (optional)
│   └── hook-name.sh
├── skills/                  # Reusable knowledge modules (optional)
│   └── skill-name/
│       └── SKILL.md
└── README.md               # Plugin documentation
```

**Critical**: Commands, agents, hooks, and skills live at plugin **root**, not inside `.claude-plugin/`.

---

## License

MIT License - See [LICENSE](LICENSE) file for details.

Built by the Applied AI team over 6 months of production use.

**Repository**: Internal company distribution at `/home/stefan/agents/plugins/`

---

## Support

For questions or issues:
1. Check troubleshooting section above
2. Review plugin-specific README files
3. Contact the Applied AI team

---

**Use this framework. Build on our lessons. Avoid our mistakes.**

*Last updated: November 2025 | v1.2.0 | 13 active plugins*
