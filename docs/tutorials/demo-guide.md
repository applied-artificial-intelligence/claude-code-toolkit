# Claude Code Toolkit - 5-Minute Demo

**Quick-start demonstration of core functionality**

Time: 5 minutes | Prerequisites: Claude Code installed | Level: Beginner

---

## What You'll Learn

This demo shows you how to use Claude Code Toolkit to:

1. **Explore and plan work** - Systematic project analysis and task breakdown
2. **Execute structured workflows** - Track and complete tasks with built-in quality gates
3. **Analyze code intelligently** - Deep codebase understanding with MCP tools
4. **Leverage AI/ML skills** - Domain expertise for RAG, transformers, and LLM evaluation

---

## Demo Flow

### Step 1: Project Setup (30 seconds)

Initialize Claude Code Toolkit in your project:

```bash
# Navigate to your project
cd ~/my-project

# Initialize project (auto-detects Python/JavaScript)
/system:setup
```

**What happens**:
- Detects project type (Python, JavaScript, or existing)
- Creates `.claude/` directory structure
- Sets up memory files and configuration

---

### Step 2: Explore and Plan Work (90 seconds)

Start a new feature using the workflow pattern:

```bash
# Explore: Analyze requirements and codebase
/workflow:explore "Add user authentication with JWT"

# After exploration completes, create implementation plan
/workflow:plan

# View task breakdown
/workflow:next --preview
```

**What happens**:
- `/explore` creates comprehensive analysis in `.claude/work/`
- Identifies files to modify, dependencies, and potential issues
- `/plan` breaks work into concrete tasks with dependencies

**Expected output** (from `/next --preview`):
```
Available Tasks
---------------
TASK-001 - Create User model with JWT fields [pending]
TASK-002 - Implement JWT authentication middleware [pending]
TASK-003 - Add login/logout endpoints [pending]
TASK-004 - Write authentication tests [pending]
```

---

### Step 3: Execute Tasks Systematically (60 seconds)

Execute tasks in dependency order with automatic tracking:

```bash
# Execute next available task
/workflow:next

# After task completes, continue with next
/workflow:next

# Check progress anytime
/workflow:next --status
```

**What happens**:
- Selects next task based on priorities and dependencies
- Executes task with quality checks
- Updates task tracking in `state.json`

---

### Step 4: Intelligent Code Analysis (60 seconds)

Use development tools for deep codebase understanding:

```bash
# Analyze project architecture
/development:analyze

# Review code quality
/development:review src/

# Fix issues automatically
/development:fix error
```

**What happens**:
- `/analyze` provides architectural overview and recommendations
- `/review` finds bugs, code smells, and security issues
- `/fix` automatically resolves common problems

---

### Step 5: Leverage AI/ML Skills (45 seconds)

Access domain expertise for AI/ML tasks:

```bash
# Get guidance on RAG implementation
"What's the best approach for implementing RAG with vector search?"

# Claude activates rag-implementation skill automatically
# Provides decision tree and best practices
```

**What happens**:
- Skills provide specialized domain knowledge
- Decision trees guide technology selection
- Working code examples and best practices

---

## What You've Learned

In 5 minutes, you've seen how to:

- **Set up projects** - Automatic detection and configuration
- **Explore and plan** - Systematic analysis and task breakdown
- **Execute workflows** - Structured task execution with tracking
- **Analyze code** - Deep understanding with MCP semantic tools
- **Use AI/ML skills** - Domain expertise on demand

---

## Next Steps

### Try These Workflows

**Web Development**:
```bash
/workflow:explore "Add REST API endpoints"
/workflow:plan
/workflow:next
```

**Testing**:
```bash
/development:test tdd  # Test-driven development
/development:review --spec requirements.md
```

**Git Operations**:
```bash
/development:git commit
/development:git pr
```

### Learn More

- [Installation Guide](../getting-started/installation.md)
- [MCP Setup](../mcp-setup.md)
- [Plugin Reference](../../plugins/README.md)

---

## Troubleshooting

**Q: Command not found**
Ensure plugins are enabled in `.claude/settings.json`:

```json
{
  "enabledPlugins": {
    "system@local": true,
    "workflow@local": true,
    "development@local": true
  }
}
```

**Q: MCP tools not working**
MCP tools are optional. Commands work without them but with reduced features. See [MCP Setup](../mcp-setup.md).

---

*Built from 6+ months of daily Claude Code use. Copy, adapt, make it yours.*
