# Changelog

All notable changes to Claude Code Plugins will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2025-10-20

### Removed

#### Git Plugin
- **Removed git plugin entirely** - Git operations now fully integrated into development plugin
  - Removed deprecated `git/` plugin directory
  - Removed git plugin from marketplace.json
  - Updated all documentation to reflect git as part of development plugin
  - No migration required - git functionality unchanged, just consolidated

### Changed

#### Plugin Schema
- **Updated all plugin.json files** to match Claude Code official schema
  - Changed `author` from string to object: `{"name": "..."}`
  - Changed `repository` from object to URL string
  - Added `./` prefix to all commands and agents paths
  - Removed invalid fields (settings, capabilities, dependencies, mcpTools)
  - Plugin names now match directory names for clean command names

#### Marketplace
- **Removed obsolete plugin references** from marketplace.json
  - Removed "core" plugin (was renamed to "system" in v1.0.0)
  - Marketplace now accurately lists only current plugins

#### Documentation
- **Updated README.md** to reflect 5 core plugins (was 6)
  - Removed git plugin from plugin list
  - Updated enabledPlugins examples
  - Fixed documentation links to only reference existing files
  - Removed references to non-existent guides

- **Updated plugins/README.md** to reflect current plugin structure
  - Updated from 6 to 5 plugins
  - Moved git operations under development plugin
  - Updated command counts

### Fixed

- **Command name prefixes** - Commands no longer show with plugin prefix (e.g., `/handoff` instead of `/claude-code-memory:handoff`)
- **Duplicate marketplace** - Removed duplicate marketplace configuration causing conflicts
- **Invalid JSON** - All plugin.json files now validate against Claude Code schema

## [1.1.0] - 2025-10-19

### Added

#### Memory Plugin
- **`/continue` command** - Auto-load and resume from latest handoff
  - Automatically finds latest handoff via `.claude/transitions/latest/handoff.md` symlink
  - Verifies symlink points to actual newest handoff (not stale)
  - Loads context and briefs user on session focus, active work, next steps
  - Completes the handoff workflow loop (`/handoff` creates, `/continue` loads)

### Changed

#### Memory Plugin
- **`/handoff` command** - Removed misleading `continue` alias
  - Kept `transition` alias
  - Updated documentation to clarify `/handoff` creates handoffs, doesn't load them
  - Added reference to new `/continue` command for loading
- **plugin.json** - Updated capabilities and keywords
  - Added `sessionContinue` capability for `/continue` command
  - Added `continue` keyword for discoverability
- **README.md** - Expanded documentation
  - Added complete `/continue` command documentation
  - Added workflow example showing `/handoff` → `/clear` → `/continue` pattern
  - Updated command count from 6 to 7 commands

### Fixed

- **Misleading alias**: `/handoff` command had `continue` alias that implied auto-continuation when it only creates handoff documents
- **Manual workflow**: Previously required users to manually type "continue from .claude/transitions/latest/handoff.md" - now automated with `/continue` command

## [1.0.0] - 2025-10-18

### 🎉 Major Release: Plugin Reorganization

**Breaking Changes**: Core plugin removed and replaced with focused plugins.

### Added

#### New Plugins
- **system** plugin - System configuration and health monitoring
  - Moved from core: `status`, `setup`, `audit`, `cleanup`
- **agents** plugin - Specialized agent invocation
  - Moved from core: `agent`, `serena`

#### Enhanced Plugins
- **workflow** plugin - Now includes work unit management
  - Added from core: `work`, `spike`
  - Total: 6 commands (was 4)
- **memory** plugin - Now includes project understanding and session management
  - Added from core: `index`, `handoff`, `performance`
  - Total: 6 commands (was 3)
- **development** plugin - Now includes documentation operations
  - Added from core: `docs`
  - Total: 6 commands (was 5)

#### Documentation
- **MIGRATION.md** - Complete migration guide from v0.9.x to v1.0.0
  - Step-by-step instructions
  - Troubleshooting section
  - FAQ and rollback plan
- **System Plugin README** - Complete documentation for system commands
- **Agents Plugin README** - Complete documentation for agent invocation
- Updated workflow plugin README with work/spike commands
- Updated memory plugin README with index/handoff/performance commands

#### Build System (Deferred)
- Created canonical utilities in `src/utils/common.sh` (86 lines, 5 constants, 4 functions)
- Comprehensive utility documentation in `src/utils/README.md` (650+ lines)
- Build system design in `docs/development/build-system.md`
- Implementation deferred to post-launch (utilities stable, ~1-2 changes/year)

### Changed

#### Plugin Structure
- **BREAKING**: Removed `core` plugin (bloated, 14 mixed commands)
- **BREAKING**: Replaced with 2 focused plugins (`system`, `agents`)
- Commands redistributed to 6 focused plugins by purpose
- No command behavior changes (pure reorganization)
- All command names unchanged

#### Dependencies
- **workflow** plugin: Dependency changed from `claude-code-core` to `claude-code-system`
- **development** plugin: Dependency changed from `claude-code-core` to `claude-code-system`

#### Plugin Manifests
- Updated `plugin.json` for workflow, memory, development, system, agents
- Added capabilities for new commands in each plugin
- Updated keywords to reflect expanded command scope
- All plugins now accurately describe their purpose

### Fixed

- **Major Issue #1**: Utility code duplication (94% reduction: ~1,320 lines → 86 lines)
  - Created single source of truth in `src/utils/common.sh`
  - Comprehensive documentation with usage examples
  - Deferred build system implementation (complexity > benefit)
- **Major Issue #2**: Bloated core plugin (addressed via reorganization)
  - Replaced 1 generic plugin with 6 focused plugins
  - Clear separation of concerns (system, workflow, agents, memory)
  - Improved discoverability and plugin descriptions

### Deprecated

- **core** plugin - Removed entirely
  - Commands redistributed to focused plugins
  - See MIGRATION.md for update instructions

### Migration

**Action Required**: Update `.claude/settings.json` in each project

Replace:
```json
"core@aai-plugins": true
```

With:
```json
"system@aai-plugins": true,
"agents@aai-plugins": true
```

**See MIGRATION.md for complete instructions.**

### Technical Details

#### Commits
- Created system and agents plugin structures (TASK-007)
- Moved 12 commands from core to focused plugins (TASK-008)
  - 4 commands → system
  - 2 commands → agents
  - 2 commands → workflow
  - 3 commands → memory
  - 1 command → development
- Updated all plugin manifests and documentation (TASK-009)

#### Progress
- 4/12 tasks complete (33%)
- 3 tasks deferred (build system)
- Efficiency: 250% (3.5h actual vs 7h estimated)

---

## [0.9.x] - Pre-reorganization

### Structure
- core plugin (14 commands)
- workflow plugin (4 commands)
- development plugin (5 commands)
- memory plugin (3 commands)
- git plugin (1 command)

**Total**: 27 commands across 5 plugins

### Issues
- Core plugin bloated and lacked focus
- Utility code duplicated across 30+ commands (~1,320 lines)
- Poor separation of concerns
- Generic plugin names

---

## Version Numbering

- **MAJOR** (X.0.0): Breaking changes (plugin reorganization, API changes)
- **MINOR** (1.X.0): New features, backward compatible
- **PATCH** (1.0.X): Bug fixes, documentation updates

---

## Links

- [GitHub Repository](https://github.com/applied-artificial-intelligence/claude-code-toolkit)
- [Migration Guide](MIGRATION.md)
- [Documentation](README.md)
- [Contributing Guide](CONTRIBUTING.md)

---

**Notes**:
- All git history preserved (commands moved via `git mv`)
- No command behavior changes (pure reorganization)
- Migration should take < 5 minutes per project
- See MIGRATION.md for troubleshooting
