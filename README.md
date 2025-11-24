# Claude Code Toolkit

**Production-tested commands, skills, and patterns for Claude Code**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-2.0%2B-blue)](https://docs.claude.com/claude-code)

---

## Overview

A collection of plugins, skills, and patterns developed through 6+ months of daily Claude Code use. Copy what works, adapt to your needs.

**What's included**: 23 commands, 5 agents, and 6 domain skills across 5 core plugins.

### Design Goals

1. **Stateless architecture** - Commands execute independently, state persisted in files
2. **File-based persistence** - JSON and Markdown for all state management
3. **MCP integration** - Optional Model Context Protocol tools with graceful degradation
4. **Progressive disclosure** - Load context incrementally to optimize token usage
5. **Self-containment** - All logic inline, no external script dependencies

### Key Capabilities

- **Workflow management**: `explore` → `plan` → `next` → `ship` pattern
- **Memory persistence**: Cross-session context with automatic reflection
- **Quality automation**: Git safety, pre/post hooks, compliance auditing
- **Code intelligence**: Semantic code understanding (Serena MCP), 70-90% token reduction
- **Domain expertise**: 6 skills across ML/AI and general development with measurable improvements

---

## Architecture

### Component Structure

```
claude-code-toolkit/
├── plugins/                # Core plugins (5 plugins, 23 commands)
│   ├── system/            # System configuration (3 commands, 2 agents)
│   ├── workflow/          # Development workflow (6 commands)
│   ├── development/       # Code operations (7 commands, 3 agents)
│   ├── transition/        # Session boundaries (2 commands)
│   └── memory/            # Knowledge persistence (5 commands)
├── skills/                # Domain skills (6 skills)
│   ├── ml-ai/             # ML/AI skills
│   │   ├── rag-implementation/
│   │   ├── huggingface-transformers/
│   │   └── llm-evaluation/
│   └── general-dev/       # General development skills
│       ├── docker-optimization/
│       ├── sql-optimization/
│       └── api-authentication/
├── hooks/                 # Example hooks (1 hook)
│   └── ruff-check-hook.sh       # Lint Python code
└── docs/                  # Documentation
    ├── mcp-setup.md       # MCP server integration guide
    └── [additional docs]
```

### Stateless Execution Model

All commands are **stateless markdown files** that execute in the project directory:

- No persistent processes or background services
- All state stored in `.claude/` directory (JSON/Markdown)
- Git serves as the state machine for work tracking
- Commands can be interrupted and resumed safely

**File-Based State Management**:
```
.claude/
├── work/
│   └── current/
│       └── [work-unit]/
│           ├── state.json              # Task tracking
│           ├── exploration.md          # Analysis
│           └── implementation-plan.md  # Task breakdown
├── memory/
│   ├── project-context.md              # Project knowledge
│   └── lessons-learned.md              # Accumulated insights
└── settings.json                       # Configuration
```

### MCP Integration Architecture

**Graceful Degradation Philosophy**: All functionality works without MCP, enhanced when available.

**Supported MCP Servers** (see [docs/mcp-setup.md](docs/mcp-setup.md)):

| MCP Server | Impact | Token Change | Status |
|------------|--------|--------------|--------|
| Sequential Thinking | Structured reasoning | +15-30% | Built-in (no setup) |
| Serena | Semantic code understanding | -70-90% | Optional (per-project) |
| Context7 | Documentation access | -50% | Optional (API key) |
| Chrome DevTools | Browser automation | Varies | Optional |
| FireCrawl | Web research | -40% | Optional (API key) |

**Commands auto-detect MCP availability** and fall back to standard operations when unavailable.

---

## Installation

### Prerequisites

- **Claude Code 2.0+** ([installation](https://claude.com/install))
- **Git 2.0+**
- **jq** (JSON processing)
- **Node.js v20+ or v22+** (for MCP servers, optional)
- **mdtoken** (for contributors - `pip install mdtoken`)

### Quick Start

```bash
# Clone repository
git clone https://github.com/appliedaiconsulting/claude-code-toolkit.git
cd claude-code-toolkit

# Start Claude Code
claude

# In Claude Code, run:
/setup-project
```

### Manual Configuration

Add to project's `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "local": {
      "source": {
        "source": "directory",
        "path": "/path/to/claude-code-toolkit/plugins"
      }
    }
  },
  "enabledPlugins": {
    "system@local": true,
    "workflow@local": true,
    "development@local": true,
    "transition@local": true,
    "memory@local": true
  }
}
```

### MCP Setup (Optional)

For enhanced functionality, install MCP servers:

```bash
# Install Serena (semantic code understanding)
npm install -g @context7/serena-mcp

# Install Context7 (documentation access)
npm install -g @context7/context7-mcp

# Install Chrome DevTools (browser automation)
npm install -g @modelcontextprotocol/server-puppeteer

# Install FireCrawl (web research)
npm install -g @firecrawl/mcp-server
```

See [docs/mcp-setup.md](docs/mcp-setup.md) for complete MCP integration guide.

---

## Usage

### Basic Workflow Pattern

The framework follows an `explore` → `plan` → `next` → `ship` pattern:

```bash
# 1. Explore requirements and codebase
/workflow:explore "add user authentication with JWT"

# Creates work unit in .claude/work/current/
# Analyzes requirements, identifies files to modify
# Documents dependencies and integration points

# 2. Create implementation plan
/workflow:plan

# Generates task breakdown with dependencies
# Stores in state.json for execution tracking

# 3. Execute tasks sequentially
/workflow:next

# Selects next available task (dependency-aware)
# Executes task with quality checks
# Auto-commits changes with descriptive message

# Repeat /next until all tasks complete

# 4. Deliver completed work
/workflow:ship

# Validates quality gates
# Creates pull request (if configured)
# Archives work unit
```

### Command Reference

**System Commands**:
- `/system:setup` - Project initialization (auto-detects Python/JavaScript)
- `/system:status` - Project and system health check
- `/system:audit` - Framework compliance validation
- `/system:cleanup` - Remove generated clutter

**Workflow Commands**:
- `/workflow:explore` - Analyze requirements and create work breakdown
- `/workflow:plan` - Generate implementation plan with dependencies
- `/workflow:next` - Execute next available task
- `/workflow:ship` - Deliver completed work
- `/workflow:work` - Manage work units and parallel streams
- `/workflow:spike` - Time-boxed exploration in isolated branch

**Development Commands**:
- `/development:analyze` - Deep codebase analysis
- `/development:review` - Code quality and security review
- `/development:test` - Test creation and TDD workflow
- `/development:fix` - Automated debugging and fixes
- `/development:git` - Git operations (commit, PR, issues)
- `/development:docs` - Documentation operations

**Transition Commands**:
- `/transition:handoff` - Create session handoff with context analysis
- `/transition:continue` - Resume from previous session handoff

**Memory Commands**:
- `/memory:index` - Create persistent project understanding
- `/memory:memory-update` - Update memory with new insights
- `/memory:memory-review` - Display current memory state
- `/memory:memory-gc` - Garbage collect stale entries
- `/memory:performance` - View token usage and metrics

**Note**: For semantic code understanding, use Serena MCP directly. See [docs/mcp-setup.md](docs/mcp-setup.md) for configuration.

### Specialized Agents

The framework includes 5 specialized agents that Claude Code can invoke via its native Task tool. Simply ask Claude to use an agent by name:

**Available Agents**:

| Agent | Location | Purpose |
|-------|----------|---------|
| `architect` | development | System design and architectural decisions |
| `test-engineer` | development | Test creation and coverage analysis |
| `code-reviewer` | development | Code quality and security audit |
| `auditor` | system | Infrastructure verification and compliance |
| `reasoning-specialist` | system | Complex analysis with structured reasoning |

**Usage** - just ask Claude directly:
```
"Use the architect agent to design the authentication system"
"Have the code-reviewer agent review this PR"
"Use the test-engineer agent to create tests for the user service"
```

Claude Code's Task tool will invoke the appropriate agent. No wrapper commands needed.

### Domain Skills (6 Skills)

Skills use **progressive disclosure** - they auto-load only when relevant to your task, providing deep domain expertise without polluting context.

#### ML/AI Skills (3 skills)

**RAG Implementation** (`rag-implementation`)
- Vector database selection (Qdrant, Pinecone, Chroma, Weaviate)
- Chunking strategies and embedding models
- Retrieval optimization and hybrid search
- **Triggers**: "RAG", "vector database", "semantic search", "document retrieval"

**Hugging Face Transformers** (`huggingface-transformers`)
- Model loading and tokenization patterns
- Fine-tuning workflows (BERT, GPT, T5, LLaMA)
- Inference optimization (quantization, ONNX)
- **Triggers**: "transformers", "BERT", "fine-tune", "tokenizer", "Hugging Face"

**LLM Evaluation** (`llm-evaluation`)
- Prompt testing and validation
- Hallucination detection
- Benchmark creation and A/B testing
- **Triggers**: "LLM testing", "prompt evaluation", "hallucination", "LLM metrics"

#### General Development Skills (3 skills)

**Docker Optimization** (`docker-optimization`)
- Multi-stage builds for 85% size reduction (800MB → 120MB)
- Layer caching strategies for 50-80% faster builds
- Security hardening (non-root users, secrets management)
- **Triggers**: "Docker", "Dockerfile", "container size", "image optimization"
- **Demo value**: 800MB → 120MB Python image (real example included)

**SQL Optimization** (`sql-optimization`)
- EXPLAIN plan analysis across Postgres/MySQL/SQLite
- Index strategies (single, composite, partial, covering)
- N+1 query elimination and pagination optimization
- **Triggers**: "slow query", "EXPLAIN", "database performance", "SQL optimization"
- **Demo value**: 3s → 50ms query (60x speedup, real example included)

**API Authentication** (`api-authentication`)
- JWT, OAuth 2.0, API keys, session-based auth
- Decision matrix for choosing auth strategy
- Security best practices and vulnerability prevention
- **Triggers**: "authentication", "JWT", "OAuth", "API security", "login"
- **Demo value**: Secure auth on first try, prevents common vulnerabilities

#### How Skills Work

Skills activate automatically when your query matches their domain:

```bash
# Example 1: Docker skill auto-loads
"My Docker image is 800MB, how do I optimize it?"
> The "docker-optimization" skill is loading

# Example 2: SQL skill auto-loads
"This query takes 3 seconds, help me optimize it"
> The "sql-optimization" skill is loading

# Example 3: RAG skill auto-loads
"What's the best vector database for production RAG?"
> The "rag-implementation" skill is loading
```

**Benefits**:
- Load knowledge only when needed (no context pollution)
- 10-20KB of focused expertise per skill
- Before/after examples showing measurable improvements
- Works with progressive disclosure for optimal token efficiency

### Example Hook

The framework includes an example hook demonstrating the Claude Code hooks system:

#### Code Quality (`ruff-check-hook.sh`)
- Lints Python code for quality issues
- Catches unused imports, undefined names, syntax errors
- Claude sees the lint output and can act on it immediately
- **Demo**: Write code with unused import, see immediate linting feedback

**Why this hook is useful**: Unlike auto-formatting hooks (where Claude doesn't see the result), linting hooks provide actionable feedback that Claude can respond to in the same session.

**Installation**:
```bash
# Copy hook to ~/.claude/hooks/
mkdir -p ~/.claude/hooks
cp hooks/ruff-check-hook.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/ruff-check-hook.sh

# Configure in project's .claude/settings.json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {"type": "command", "command": "~/.claude/hooks/ruff-check-hook.sh"}
        ]
      }
    ]
  }
}
```

**Creating Your Own Hooks**: See [hooks/README.md](hooks/README.md) for the hook data format and design tips

---

## Screenshots

### Context Management: /handoff → /continue

Managing context across sessions to prevent quality degradation:

![Handoff and Continue Workflow](screenshots/01_handoff_continue.png)

**Key features shown**:
- Context analysis at 70% perceived usage (~85% actual)
- Active work state preservation
- Recent decisions and outstanding items
- Clean continuation after `/clear`

---

### Complete Workflow: /explore → /plan → /next

Systematic task execution from requirements to implementation:

![Workflow Sequence](screenshots/02_workflow_sequence.png)

**Key features shown**:
- Requirements analysis with `/explore`
- Task breakdown with `/plan`
- Incremental execution with `/next`
- Progress tracking and state management

---

### Code Analysis: /analyze and /review

Deep codebase understanding and quality checks:

![Code Analysis and Review](screenshots/03_analyze_review.png)

**Key features shown**:
- Structural analysis with pattern identification
- Test coverage metrics
- Code quality review with actionable recommendations
- Security and performance assessment

---

## Technical Details

### State Management

**Work Unit Structure**:
```json
{
  "work_unit_id": "003_auth_feature",
  "status": "implementing",
  "current_phase": "2",
  "phases": [
    {"id": "1", "name": "Analysis", "status": "completed"},
    {"id": "2", "name": "Implementation", "status": "in_progress"}
  ],
  "tasks": [
    {
      "id": "TASK-001",
      "title": "Create User model",
      "status": "completed",
      "dependencies": [],
      "actual_hours": 0.5
    }
  ]
}
```

**State persisted in** `.claude/work/current/[work-unit]/state.json`

### Token Optimization

**Progressive Disclosure Pattern**:
1. **Startup**: Load minimal metadata (~2KB)
2. **Task Analysis**: Load relevant commands/agents (~10KB)
3. **Execution**: Load detailed patterns only when needed (~5KB)

**Result**: 70%+ token savings vs. loading all documentation upfront.

**With Serena MCP**: Additional 70-90% reduction for code operations.

### Quality Gates

**Automatic Quality Checks**:
- **Pre-execution**: Dependency verification, environment checks
- **During execution**: API verification (via Serena), linting, tests
- **Post-execution**: Acceptance criteria validation, integration tests
- **Commit time**: Conventional commit format, attribution

### Git Safety

**Protected Operations**:
- No `git push --force` to main/master
- No `git commit --amend` of other developers' commits
- Pre-commit hook validation
- Automatic commit attribution

**Commit Format**:
```
feat: Complete TASK-XXX - Add JWT authentication

Implements JWT-based authentication with:
- Token generation and validation
- Refresh token support
- Role-based access control

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

---

## Configuration

### Project Settings

Configure in `.claude/settings.json`:

```json
{
  "enabledPlugins": {
    "system@local": true,
    "workflow@local": true,
    "development@local": true,
    "transition@local": true,
    "memory@local": true
  },
  "mcpServers": {
    "serena": {
      "command": "npx",
      "args": ["-y", "@context7/serena-mcp"]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@context7/context7-mcp"],
      "env": {
        "CONTEXT7_API_KEY": "${CONTEXT7_API_KEY}"
      }
    }
  }
}
```

### User Configuration

Global user settings in `~/.claude/CLAUDE.md`:

```markdown
# My Development Preferences

## Git Preferences
- Always use conventional commit format
- Include issue numbers in commit messages
- Create draft PRs for WIP features

## Testing Preferences
- Run tests before committing
- Maintain >80% code coverage
- Use pytest for Python, Jest for JavaScript
```

---

## Documentation

### Getting Started

- **[5-Minute Demo](docs/demo-guide.md)** - Quick-start demonstration
- **[MCP Setup Guide](docs/mcp-setup.md)** - MCP server integration

### Plugin Documentation

Each plugin has detailed README:

- [system plugin](plugins/system/README.md) - System utilities
- [workflow plugin](plugins/workflow/README.md) - Development workflow
- [development plugin](plugins/development/README.md) - Code operations
- [transition plugin](plugins/transition/README.md) - Session boundaries
- [memory plugin](plugins/memory/README.md) - Context management

### Architecture Documentation

- **Design Principles**: Stateless execution, file-based persistence, MCP integration
- **Framework Constraints**: What the system can and cannot do
- **Extension Patterns**: How to create custom plugins

---

## Development

### Building Custom Plugins

**Plugin Structure**:
```
my-plugin/
├── .claude-plugin/
│   └── plugin.json           # Manifest (required)
├── commands/                 # Slash commands (optional)
│   └── my-command.md
├── agents/                   # Specialized agents (optional)
│   └── my-agent.md
└── hooks/                    # Event handlers (optional)
    └── hooks.json
```

**Minimal plugin.json**:
```json
{
  "name": "my-plugin",
  "version": "1.0.0",
  "description": "My custom plugin",
  "commands": [
    {
      "name": "my-command",
      "description": "Does something useful",
      "file": "commands/my-command.md"
    }
  ]
}
```

### Development Setup

```bash
# Install pre-commit hooks (requires mdtoken)
pip install mdtoken pre-commit
pre-commit install

# mdtoken enforces token limits on markdown files
# This keeps plugin commands concise and context-efficient
```

### Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for:
- Code style guidelines
- Testing requirements
- Pull request process
- Code of conduct

---

## Performance

### Benchmarks

**Token Usage** (typical feature development):
- Without MCP: ~150K tokens
- With Serena: ~30K tokens (80% reduction)
- With Sequential Thinking: ~180K tokens (+20%, higher quality)

**Time to First Value**:
- Project setup: <2 minutes
- First workflow execution: <5 minutes
- MCP server setup: <15 minutes

### Optimization Tips

**Maximize Serena Benefits**:
- Activate per-project for code-heavy work
- Keep index updated after major changes
- Use for all file reading and symbol lookup

**Efficient Memory Management**:
- Archive completed work units regularly
- Use `.claude/memory/` for project-specific knowledge
- Run `/memory:memory-gc` to clean stale entries

**Token Conservation**:
- Use progressive disclosure (load context incrementally)
- Leverage MCP tools for documentation lookup
- Prefer `/workflow:spike` for exploratory work (isolated, time-boxed)

---

## Troubleshooting

### Common Issues

**Q: Commands not found**

**A**: Verify plugins enabled in `.claude/settings.json`:
```json
{
  "enabledPlugins": {
    "system@local": true,
    "workflow@local": true,
    "development@local": true,
    "transition@local": true,
    "memory@local": true
  }
}
```

**Q: MCP tools not working**

**A**: MCP servers are optional. Commands work without them but with reduced features. See [docs/mcp-setup.md](docs/mcp-setup.md) for installation.

**Q: Serena not activating**

**A**: Serena MCP requires per-project setup. See [docs/mcp-setup.md](docs/mcp-setup.md) for configuration. Use Serena tools directly:
```
mcp__serena__activate_project()
mcp__serena__find_symbol()
```

**Q: Tasks not executing**

**A**: Check for dependency blockers:
```bash
/workflow:next --status  # Shows task dependencies
```

### Getting Help

- **Documentation**: Check plugin README files for detailed command usage
- **System Health**: Run `/system:status` to verify framework setup
- **Compliance**: Run `/system:audit` to check for issues
- **GitHub Issues**: https://github.com/appliedaiconsulting/claude-code-toolkit/issues

---

## Versioning

### Current Version: 1.0.0

**Semantic Versioning**:
- **Major** (1.x.x): Breaking changes to plugin API or command structure
- **Minor** (x.1.x): New plugins, commands, or backward-compatible features
- **Patch** (x.x.1): Bug fixes, documentation updates

**Compatibility**: Generated work units and state files are forward-compatible within major versions.

---

## License

**MIT License**

Copyright (c) 2025 Applied AI Consulting

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

---

## Acknowledgments

Built with [Claude Code](https://claude.com/claude-code) by Anthropic.

Framework developed through 6+ months of production use across book authoring, quantitative research, and full-stack development projects.

---

## References

- **Claude Code Documentation**: https://docs.claude.com/claude-code
- **MCP Specification**: https://modelcontextprotocol.io
- **Plugin Development**: See plugin README files for examples
- **GitHub Repository**: https://github.com/appliedaiconsulting/claude-code-toolkit
