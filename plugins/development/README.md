# Development Plugin

Code development and quality assurance tools for systematic analysis, testing, debugging, and review.

## Overview

The Development plugin provides essential tools for building high-quality code. It includes commands for codebase analysis, test-driven development, debugging, code execution, and comprehensive code review. Three specialized agents provide expert assistance for architecture, testing, and code quality.

## Features

- **Deep Analysis**: Semantic codebase understanding with architecture insights
- **Test-Driven Development**: Comprehensive TDD workflow with test generation
- **Universal Debugging**: Fix errors, bugs, and code issues with semantic analysis
- **Safe Execution**: Run scripts and code with monitoring and timeout control
- **Code Review**: Systematic review for bugs, design flaws, and quality issues
- **External Review Prep**: Package codebase for external review with RepoMix integration

## Commands

### `/analyze [focus_area] [--with-thinking] [--semantic]`
Analyze ANY project to understand its structure and architecture with semantic code intelligence and structured reasoning.

**What it does**:
- Analyzes codebase structure and organization
- Identifies architectural patterns and design choices
- Maps dependencies and relationships
- Highlights potential issues and improvements
- Generates comprehensive analysis report

**Usage**:
```bash
/analyze                                    # Full project analysis
/analyze src/auth                           # Analyze specific area
/analyze --with-thinking                    # Use structured reasoning
/analyze --semantic                         # Use Serena semantic analysis
/analyze src/api --with-thinking --semantic # Deep analysis with all tools
```

**Analysis Types**:
- **Structure**: Directory organization, module layout
- **Architecture**: Design patterns, architectural style
- **Dependencies**: Internal and external dependencies
- **Quality**: Code quality metrics, technical debt
- **Security**: Potential security issues
- **Performance**: Performance bottlenecks

**Output**:
- Comprehensive analysis document
- Architectural diagrams (textual)
- Dependency maps
- Recommendations for improvements

**When to use**:
- ✅ New codebase familiarization
- ✅ Architecture review
- ✅ Before major refactoring
- ✅ Technical debt assessment
- ✅ Onboarding new team members

### `/test [tdd] [pattern]`
Test-driven development workflow using test-engineer agent. Create tests, analyze coverage, and ensure quality.

**What it does**:
- Creates comprehensive test suites
- Analyzes test coverage
- Identifies untested code paths
- Generates test cases from specifications
- Runs tests and reports results

**Usage**:
```bash
/test                                       # Run existing tests
/test tdd                                   # Start TDD workflow
/test src/auth/*                            # Test specific pattern
/test --coverage                            # Generate coverage report
```

**TDD Workflow**:
1. **Write test first**: Define expected behavior
2. **Run test** (should fail initially)
3. **Implement code**: Make test pass
4. **Refactor**: Improve while keeping tests green
5. **Repeat**: Next feature

**Test Types Supported**:
- Unit tests
- Integration tests
- End-to-end tests
- Property-based tests
- Mutation tests

**When to use**:
- ✅ New feature development (TDD)
- ✅ Bug fixes (regression tests)
- ✅ Refactoring (safety net)
- ✅ Coverage improvements
- ✅ Quality assurance

### `/fix [error|review|audit|all] [file/pattern]`
Universal debugging and fix application with semantic code analysis. Debug errors or apply review fixes automatically.

**What it does**:
- Analyzes errors and exceptions
- Identifies root causes
- Proposes and applies fixes
- Applies code review suggestions
- Fixes audit findings

**Usage**:
```bash
/fix                                        # Fix latest error
/fix error src/auth/login.js               # Fix specific file errors
/fix review                                 # Apply review suggestions
/fix audit                                  # Fix audit findings
/fix all                                    # Fix everything
```

**Fix Sources**:
- **error**: Runtime errors, exceptions, crashes
- **review**: Code review feedback
- **audit**: Audit findings and compliance issues
- **test**: Test failures
- **lint**: Linter warnings and errors

**Fix Process**:
1. Identify issue and context
2. Analyze root cause
3. Propose fix with explanation
4. Apply fix (with user confirmation if risky)
5. Verify fix resolves issue
6. Run tests to prevent regression

**When to use**:
- ✅ Debugging runtime errors
- ✅ Addressing review feedback
- ✅ Fixing test failures
- ✅ Resolving linter issues
- ✅ Quick fixes with confidence

### `/review [file/directory] [--spec requirements.md] [--systematic] [--semantic]`
Standard code review focused on bugs, design flaws, dead code, and code quality with prioritized action plan.

**What it does**:
- Reviews code for bugs and logic errors
- Identifies design flaws and anti-patterns
- Finds dead code and unused variables
- Checks code quality and maintainability
- Provides prioritized recommendations

**Usage**:
```bash
/review                                     # Review recent changes
/review src/auth                            # Review directory
/review src/auth/login.js                   # Review specific file
/review --spec @requirements.md             # Review against spec
/review --systematic                        # Use structured reasoning
/review --semantic                          # Use semantic code analysis
```

**Review Focus Areas**:
1. **Bugs**: Logic errors, edge cases, null checks
2. **Design**: Architecture, patterns, coupling
3. **Dead Code**: Unused functions, variables, imports
4. **Quality**: Readability, maintainability, naming
5. **Security**: Vulnerabilities, input validation
6. **Performance**: Inefficiencies, optimization opportunities
7. **Testing**: Test coverage, test quality

**Output Format**:
```
HIGH Priority:
- [BUG] Null pointer in login.js:45
- [SECURITY] SQL injection risk in query.js:120

MEDIUM Priority:
- [DESIGN] God class in UserService.js
- [PERFORMANCE] N+1 query in getUsers()

LOW Priority:
- [QUALITY] Inconsistent naming in helpers.js
- [DEAD CODE] Unused import in utils.js
```

**When to use**:
- ✅ Before pull request submission
- ✅ After completing feature
- ✅ Regular code quality checks
- ✅ Onboarding review
- ✅ Security audits

### `/prepare-review [focus_area_or_context]`
Prepare external code review package using RepoMix with intelligent file selection and token-efficient formatting.

**What it does**:
- Intelligently selects relevant files for review
- Includes project documentation (README, specs, PRDs)
- Generates comprehensive review prompt
- Creates RepoMix package in XML format (no line numbers)
- Keeps token count <100k for external reviewer submission

**Usage**:
```bash
/prepare-review                                 # Generic quality review
/prepare-review "API authentication layer"      # Focus on specific area
/prepare-review "Data pipeline error handling"  # Focus on specific concerns
```

**Review Package Includes**:
1. **Review Prompt**: Clear guidance on what to review and how
2. **Project Context**: README and specs (summarized if lengthy)
3. **Codebase**: Token-efficient RepoMix package (XML, no line numbers)

**Output Location**:
```
.claude/external_reviews/YYYY-MM-DD-HHMM/
└── review_package.md    # Complete package ready to share
```

**Token Efficiency**:
- Target: <100,000 tokens (ideally much less)
- XML format for clean separation
- No line numbers (saves 20-30% tokens)
- Intelligent file selection (exclude utilities if not relevant)
- Documentation summarization (50 pages → 5 pages when appropriate)

**File Selection Intelligence**:
- **Always Include**: Main entry points, core logic, API definitions, key architecture
- **Usually Exclude**: Tests, build artifacts, dependencies, simple utilities
- **Focus-Dependent**: Includes files relevant to specified focus area

**Review Focus Areas** (default):
- Architecture and overall design
- Completeness (gaps, errors, omissions)
- Best practices for stated goals
- Maintainability and code quality
- Component integration and logic

**When to use**:
- ✅ Before major architecture decisions
- ✅ External expert review needed
- ✅ Complex system requiring fresh perspective
- ✅ Onboarding senior engineer for review
- ✅ Pre-production quality gate

**Requirements**:
- RepoMix installed (`npm install -g repomix`) or available via `npx`
- See: https://repomix.com

**Example Output**:
```
✅ External review package prepared!

Location: .claude/external_reviews/2025-11-14-0530/review_package.md

Package Summary:
- Focus: API authentication layer
- Files included: 12 files (core auth modules)
- Token count: ~47,000 tokens ✅
- Format: XML (no line numbers)

Next Steps:
1. Review the package
2. Copy entire review_package.md
3. Submit to external reviewer
```

## Agents

### Architect (`architect.md`)
System design and architectural decisions specialist. Provides high-level design guidance.

**Expertise**:
- System architecture and design patterns
- Technology selection and evaluation
- Scalability and performance architecture
- Security architecture
- API design and integration patterns

**Capabilities**:
- ✅ Structured reasoning for complex decisions
- ✅ Trade-off analysis for technology choices
- ✅ Architectural blueprint creation
- ✅ Design review and recommendations
- ✅ Technical specification writing

**When to use**:
```bash
/agent architect "Design authentication system for multi-tenant SaaS"
/agent architect "Evaluate microservices vs monolith for our use case"
/agent architect "Review proposed API architecture"
```

### Test Engineer (`test-engineer.md`)
Test creation, coverage analysis, and quality assurance specialist.

**Expertise**:
- Test-driven development (TDD)
- Test suite design and organization
- Coverage analysis and improvement
- Testing strategies (unit, integration, e2e)
- Test framework selection

**Capabilities**:
- ✅ Semantic code understanding for test generation
- ✅ Coverage gap identification
- ✅ Test case generation from specs
- ✅ Testing best practices
- ✅ Test quality assessment

**When to use**:
```bash
/agent test-engineer "Create comprehensive tests for auth module"
/agent test-engineer "Analyze test coverage and suggest improvements"
/agent test-engineer "Design testing strategy for new feature"
```

### Code Reviewer (`code-reviewer.md`)
Code review, documentation quality, and security audit specialist.

**Expertise**:
- Code quality and maintainability
- Security vulnerability detection
- Documentation completeness
- Best practices enforcement
- Refactoring recommendations

**Capabilities**:
- ✅ Structured reasoning for complex reviews
- ✅ Semantic code analysis
- ✅ Security-focused review
- ✅ Performance optimization suggestions
- ✅ Comprehensive feedback with priorities

**When to use**:
```bash
/agent code-reviewer "Review authentication implementation for security"
/agent code-reviewer "Assess code quality of new payment module"
/agent code-reviewer "Review PR #123 for merge readiness"
```

## Integration with Other Plugins

### Core Plugin
- Uses `/agent` for invoking development agents
- Uses `/status` to show analysis and review progress
- Uses `/performance` for execution metrics

### Workflow Plugin
- `/analyze` used during `/explore` phase
- `/test` and `/review` used during `/ship` validation
- `/fix` helps resolve issues blocking `/next`

### Git Plugin
- `/review` provides feedback before git commit
- `/fix` applies changes that git commit includes
- Quality gates integrated with git workflow

## Configuration

### Analysis Defaults (`.claude/config.json`)
```json
{
  "development": {
    "analyze": {
      "defaultMode": "semantic",
      "useStructuredReasoning": true,
      "depthLevel": "comprehensive"
    }
  }
}
```

### Test Defaults
```json
{
  "development": {
    "test": {
      "framework": "auto-detect",
      "coverageThreshold": 80,
      "runBeforeCommit": true
    }
  }
}
```

### Review Defaults
```json
{
  "development": {
    "review": {
      "autoReview": false,
      "focusAreas": ["bugs", "security", "design"],
      "severityThreshold": "medium"
    }
  }
}
```

## Dependencies

### Required Plugins
- **claude-code-system** (^1.0.0): System status and configuration

### Optional MCP Tools
- **Sequential Thinking**: Enhances architect and code-reviewer structured reasoning
- **Serena**: Enables semantic code understanding (70-90% token reduction for code ops)
- **Context7**: Library documentation access for best practices

**Graceful Degradation**: All commands work without MCP tools.

## Best Practices

### Analysis Workflow
```bash
# 1. Start with high-level analysis
/analyze

# 2. Deep-dive into specific areas
/analyze src/auth --semantic --with-thinking

# 3. Review findings and plan improvements
```

### TDD Workflow
```bash
# 1. Start TDD mode
/test tdd

# 2. Write test first
# (test-engineer helps generate test cases)

# 3. Run test (should fail)
npm test

# 4. Implement feature

# 5. Run test (should pass)
npm test

# 6. Refactor

# 7. Repeat
```

### Review Workflow
```bash
# 1. Self-review before PR
/review --semantic

# 2. Fix HIGH priority issues
/fix review

# 3. Address MEDIUM priority
# (make changes manually or with /fix)

# 4. Re-review to verify
/review

# 5. Submit PR when clean
```

## Performance Considerations

### Serena Semantic Analysis
When Serena MCP is available:
- **Token Reduction**: 70-90% fewer tokens for code operations
- **Accuracy**: More precise symbol understanding
- **Speed**: Faster code navigation and search

**Enable Serena**:
```bash
/serena  # From core plugin
```

### Sequential Thinking
When Sequential Thinking is available:
- **Quality**: +20-30% better architectural decisions
- **Tokens**: +15-30% more tokens (but worth it for complex decisions)

**Automatic**: Used automatically by architect and code-reviewer when available

## Troubleshooting

### /analyze finds no issues
- Try `--with-thinking` for deeper analysis
- Use `--semantic` if Serena available
- Specify focus area: `/analyze src/problem-area`

### /test can't find test files
- Verify test framework installed
- Check test file patterns in config
- Ensure tests exist in standard locations

### /fix doesn't find errors
- Specify error source: `/fix error [file]`
- Try `/fix review` after running `/review`
- Check recent command output for errors

### /review gives too much feedback
- Set severity threshold in config
- Focus on specific areas: `/review src/module`
- Address HIGH priority first, iterate on others

## Metrics and Quality

The development plugin tracks:
- **Code quality**: Issues found, severity distribution
- **Test coverage**: Percentage covered, gaps identified
- **Review metrics**: Issues per 1000 lines, time to review
- **Fix success**: Fixes applied, tests passing after fix

View with:
```bash
/status verbose
/performance
```

## Examples

### Example 1: New Feature with TDD
```bash
# Start TDD workflow
/test tdd

# Test-engineer generates test cases
# Implement feature to pass tests

# Run tests
npm test

# Review implementation
/review src/new-feature

# Fix any issues
/fix review

# Ship it
/ship --commit
```

### Example 2: Bug Investigation
```bash
# Analyze problem area
/analyze src/buggy-module --semantic

# Review code for bugs
/review src/buggy-module

# Fix identified issues
/fix review

# Run tests
npm test

# Verify fix
/test src/buggy-module
```

### Example 3: Architecture Review
```bash
# Get architect input
/agent architect "Review proposed microservices architecture"

# Analyze current architecture
/analyze --with-thinking

# Identify issues
/review --systematic

# Plan improvements based on findings
```

## Support

- **Documentation**: [Development Guide](../../docs/guides/development.md)
- **Issues**: [GitHub Issues](https://github.com/applied-artificial-intelligence/claude-agent-framework/issues)
- **Discussions**: [GitHub Discussions](https://github.com/applied-artificial-intelligence/claude-agent-framework/discussions)

## License

MIT License - see [LICENSE](../../LICENSE) for details.

---

**Version**: 1.0.0
**Category**: Development
**Commands**: 7 (analyze, docs, fix, git, prepare-review, review, test)
**Agents**: 3 (architect, test-engineer, code-reviewer)
**Dependencies**: core (^1.0.0)
**MCP Tools**: Optional (sequential-thinking, serena, context7)
