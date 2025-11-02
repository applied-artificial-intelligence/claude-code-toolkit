# System Plugin

**Purpose**: System configuration and health monitoring
**Category**: System
**Version**: 1.0.0

## Overview

The System plugin provides essential commands for configuring, monitoring, and maintaining Claude Code installations. These are system-level operations that configure or monitor Claude Code itself.

## Commands (9)

### /status
**Purpose**: Unified view of work, system, and memory state

Provides comprehensive status overview including:
- Active work units and progress
- Memory system state
- System configuration health
- Recent activity summary

**Usage**:
```bash
/status              # Standard status view
/status verbose      # Detailed status with full context
```

### /config
**Purpose**: Manage Claude Code configuration settings

Interactive configuration management:
- View current settings
- Update configuration
- Reset to defaults
- Validate configuration

**Usage**:
```bash
/config              # View current configuration
/config set key=value
/config reset
```

### /setup:python
**Purpose**: Initialize Python projects with Claude Code framework

Sets up Python project with configurable quality levels:
- Creates modern `pyproject.toml` with development tools
- Configures testing, linting, and type checking
- Sets up `.claude/` directory structure
- Initializes project memory and configuration

**Options**:
```bash
/setup:python                    # Standard setup (production-ready)
/setup:python --minimal          # Basic structure only
/setup:python --standard         # Standard with pytest, ruff, mypy (default)
/setup:python --full             # Comprehensive with docs, CI/CD
/setup:python my-project         # Create new project with name
```

### /setup:javascript
**Purpose**: Initialize JavaScript/Node.js projects with Claude Code framework

Sets up JavaScript project with modern tooling:
- Creates `package.json` with Jest, ESLint, Prettier
- Configures testing and code quality tools
- Sets up `.claude/` directory structure
- Initializes project memory and configuration

**Usage**:
```bash
/setup:javascript                # Initialize JavaScript project
/setup:javascript my-app         # Create new project with name
```

### /setup:existing
**Purpose**: Add Claude Code framework to existing projects

Detects project type and adds appropriate framework structure:
- Auto-detects Python or JavaScript projects
- Creates `.claude/` directory structure without modifying existing files
- Initializes configuration and memory system
- Preserves all existing project structure

**Usage**:
```bash
/setup:existing                  # Auto-detect and setup
```

### /setup:user
**Purpose**: Initialize user-level Claude Code configuration

Sets up global Claude Code configuration in `~/.claude/`:
- Creates user-level `CLAUDE.md` with best practices
- Initializes global memory templates
- Configures user preferences

**Options**:
```bash
/setup:user                      # Initialize user config
/setup:user --force              # Overwrite existing config
```

### /setup:statusline
**Purpose**: Configure Claude Code statusline display

Sets up statusline to show framework information:
- Configures statusline format
- Shows active work unit
- Displays memory state

**Usage**:
```bash
/setup:statusline                # Configure statusline
```

### /audit
**Purpose**: Validate framework compliance and configuration

Comprehensive framework validation:
- Configuration compliance checks
- Directory structure validation
- Memory system health
- Work unit integrity
- Best practices verification

**Usage**:
```bash
/audit                   # Full audit
/audit --framework       # Framework structure only
/audit --fix             # Auto-fix issues where possible
```

### /cleanup
**Purpose**: Clean up generated files and temporary data

Intelligent cleanup operations:
- Remove Claude-generated clutter
- Consolidate documentation
- Archive completed work
- Free up disk space

**Options**:
```bash
/cleanup --dry-run       # Preview what would be cleaned
/cleanup --auto          # Auto-cleanup with safe defaults
/cleanup root            # Clean project root only
/cleanup tests           # Clean test artifacts
/cleanup reports         # Clean old reports
/cleanup work            # Archive completed work units
/cleanup all             # Comprehensive cleanup
```

## Integration

### Memory System
- `status` command integrates with memory to show context state
- `audit` validates memory structure and health

### Work Units
- `status` shows active work unit progress
- `audit` validates work unit integrity
- `cleanup` can archive completed work units

### MCP Tools
- **Sequential Thinking** (optional): Enhanced status analysis and audit reasoning
- Graceful degradation when MCP unavailable

## Use Cases

### Daily Workflow
```bash
/status                  # Check what's happening
# ... do work ...
/status verbose          # Review progress before handoff
```

### Project Initialization
```bash
/setup:python --standard # Initialize Python project
/setup:javascript        # Initialize JavaScript project
/setup:existing          # Add framework to existing project
/audit                   # Verify setup correct
```

### Maintenance
```bash
/audit                   # Check framework health
/cleanup --dry-run       # See what can be cleaned
/cleanup all             # Clean up clutter
```

### Configuration Management
```bash
/config                  # Review current settings
/config set memory.auto_gc=true
/audit                   # Verify configuration valid
```

## Best Practices

### System Health
- Run `/status` at session start to understand current state
- Run `/audit` periodically to catch configuration drift
- Use `/cleanup` when projects accumulate clutter

### Configuration
- Use `/config` to view before modifying manually
- Run `/audit` after configuration changes
- Keep configuration in version control

### Setup
- Use `/setup:python --standard` for production Python projects
- Use `/setup:python --minimal` for experiments or learning
- Use `/setup:javascript` for Node.js applications
- Use `/setup:existing` to add framework to existing projects without disruption
- Use `/setup:user` once to configure global preferences

## Migration from Core Plugin

These commands moved from the `core` plugin (v0.9.x):
- `status` - Was `/core/status`
- `config` - Was `/core/config`
- `setup` - Was `/core/setup`
- `audit` - Was `/core/audit`
- `cleanup` - Was `/core/cleanup`

Command names and behavior unchanged. Only organizational change.

## Dependencies

None - System plugin is foundational.

## See Also

- **workflow** plugin - Task workflow management
- **memory** plugin - Knowledge and context management
- **development** plugin - Development tools

---

**Maintained by**: Claude Code Framework Team
**Version**: 1.0.0
**Last Updated**: 2025-10-18
