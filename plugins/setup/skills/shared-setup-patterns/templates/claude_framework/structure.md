# Claude Framework Directory Structure

This template defines the standard .claude/ directory structure for all projects.

## Directory Layout

```
.claude/
├── work/
│   ├── current/          # Active work units
│   │   └── README.md    # Work directory guide
│   └── completed/        # Archived completed work
├── memory/               # Project knowledge
│   ├── project_state.md  # Tech stack, architecture
│   ├── dependencies.md   # Dependencies and versions
│   ├── conventions.md    # Project-specific conventions
│   └── decisions.md      # Key architectural decisions
├── reference/            # Reference documentation
├── hooks/                # Custom git/command hooks
└── settings.json         # Claude Code settings (security hooks, etc.)
```

## Purpose of Each Directory

### work/
Workspace for active development tasks and completed work archives.

### memory/
Persistent project knowledge that helps Claude understand the project context.

### reference/
Additional reference materials, domain knowledge, or imported documentation.

### hooks/
Custom hooks for git operations or command execution (if needed beyond settings.json).

### settings.json
Claude Code configuration including security hooks, quality gates, and integrations.
