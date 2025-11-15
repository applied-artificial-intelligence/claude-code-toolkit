---
title: prepare-review
aliases: [review-prep, external-review]
---

# Prepare External Code Review Package

Package codebase for external review using RepoMix with intelligent file selection and token-efficient formatting.

## Purpose

Prepare a comprehensive, token-efficient package for external code review that includes:
1. **Intelligent file selection** - Only relevant code for the review focus
2. **Project context** - README, specs, PRDs (summarized if lengthy)
3. **Review prompt** - Clear guidance on what to review and how
4. **RepoMix package** - Token-efficient XML format without line numbers

**Critical constraint**: Keep total package <100,000 tokens, ideally significantly less.

## Usage

```bash
# Review entire codebase with generic quality check
/development:prepare-review

# Focus on specific area or concern
/development:prepare-review "API authentication layer"

# Review with multiple focus areas
/development:prepare-review "Focus on data processing pipeline and error handling patterns"
```

## Implementation Process

### Step 1: Understand Review Context

**If user provided focus context:**
- Use Sequential Thinking MCP to analyze what files are relevant
- Identify core files vs utility files
- Determine what documentation is needed

**If no context provided:**
- Assume generic architecture and code quality review
- Include all main source files
- Exclude tests, build artifacts, vendor code

**Key principle**: Token efficiency matters. Don't include 20 utility files if they're not central to the review.

### Step 2: Analyze Project Documentation

**Look for:**
- `README.md` - Always include (or summarize if >5000 tokens)
- `SPECIFICATION.md`, `PRD.md`, `REQUIREMENTS.md` - Project specs
- `.claude/` documentation - Project context and goals
- Any design documents

**Critical decision**: If documentation is >10,000 tokens total:
1. Use Sequential Thinking MCP to analyze and summarize
2. Create concise 2-3 page summary of "What we're building and why"
3. Include summary instead of full docs in review package

**Don't include**: 50 pages of docs when 5 pages suffice.

### Step 3: Intelligent File Selection

**Use these criteria:**

**Always Include (unless focus excludes them):**
- Main entry points (main.py, index.js, app.py, etc.)
- Core business logic
- Key architectural components
- API definitions and routes
- Database models and schemas
- Configuration that affects architecture

**Usually Exclude:**
- Tests (state this in review prompt)
- Build artifacts (dist/, build/, target/)
- Dependencies (node_modules/, venv/, vendor/)
- Generated files
- Simple utility functions (unless focus area)
- Migration scripts (unless relevant to focus)

**Focus-Dependent:**
- If focus is "authentication", include auth middleware, guards, decorators
- If focus is "data pipeline", include ETL, processing, transformation code
- If focus is "API design", include routes, controllers, serializers

**Report file selection**:
```
Included (15 files):
- Core: src/main.py, src/app.py, src/api/
- Business Logic: src/services/, src/models/
- Configuration: config.yaml, settings.py

Excluded:
- Tests (20 files in tests/) - Not included in this review
- Utilities (5 helper files) - Simple, low-value for architecture review
- Dependencies (venv/, node_modules/)

Token estimate: ~45,000 tokens
```

### Step 4: Generate RepoMix Configuration

**Create `.repomix/config.json`** (or modify existing):

```json
{
  "output": {
    "filePath": ".claude/external_reviews/[TIMESTAMP]/repomix_output.xml",
    "style": "xml",
    "showLineNumbers": false,
    "removeComments": false,
    "removeEmptyLines": true,
    "topFilesLength": 5
  },
  "include": [
    "src/**/*.py",
    "config.yaml",
    "README.md"
  ],
  "ignore": {
    "useGitignore": true,
    "useDefaultPatterns": true,
    "customPatterns": [
      "tests/**",
      "**/test_*.py",
      "**/__pycache__/**",
      "**/node_modules/**",
      "**/venv/**",
      "**/dist/**",
      "**/build/**",
      "**/*.pyc",
      "**/*.log"
    ]
  }
}
```

**Key settings for token efficiency:**
- `"style": "xml"` - Clean separation, good structure
- `"showLineNumbers": false` - Saves significant tokens
- `"removeEmptyLines": true` - Reduces noise
- `"removeComments": false` - Keep comments for context (unless they're excessive)

### Step 5: Run RepoMix

**Check if RepoMix is available:**

```bash
# Check for repomix
if command -v repomix >/dev/null 2>&1; then
    echo "Using installed repomix"
    REPOMIX_CMD="repomix"
elif command -v npx >/dev/null 2>&1; then
    echo "Using npx repomix"
    REPOMIX_CMD="npx -y repomix"
else
    echo "ERROR: Neither repomix nor npx found. Install with: npm install -g repomix"
    exit 1
fi
```

**Run RepoMix with config:**

```bash
# Run repomix with generated config
$REPOMIX_CMD --config .repomix/config.json

# Capture token count from output
# RepoMix reports token count in its output
```

**Report results:**
- Number of files included
- Token count (CRITICAL - must be <100k)
- Any warnings or issues

### Step 6: Generate Review Prompt

**Create comprehensive but focused prompt:**

```markdown
# Code Review Request

## Review Objective
[If focus provided: specific focus area]
[If no focus: Generic architecture and code quality review]

## What We're Building
[Summarized context from README/specs - 1-3 paragraphs max]

## Review Focus Areas

Please review the following aspects of this codebase:

### 1. Architecture & Design
- Is the overall architecture sound and appropriate for the stated goals?
- Are components well-organized and responsibilities clearly separated?
- Is the design scalable, maintainable, and following best practices?
- Are there architectural patterns that should be applied but aren't?

### 2. Completeness & Correctness
- Are there gaps or missing functionality relative to requirements?
- Are there logical errors or flaws in the implementation?
- Are edge cases handled appropriately?
- Is error handling robust and comprehensive?

### 3. Code Quality & Maintainability
- Is the code well-structured and readable?
- Are naming conventions clear and consistent?
- Is there appropriate documentation (docstrings, comments)?
- Are there code smells or anti-patterns that harm maintainability?

### 4. Integration & Dependencies
- Do components integrate properly?
- Are dependencies managed appropriately?
- Are there tight coupling issues that should be addressed?

### 5. Best Practices
- Does the code follow language/framework best practices?
- Are there security considerations that need attention? (Not a full security audit)
- Is the code following DRY, SOLID, or other relevant principles?

## What's NOT Included

To avoid confusion, the following are NOT included in this review:
[List what's excluded, e.g.:]
- Tests (20 test files) - Not included to maintain focus on production code
- Build configuration and tooling
- Simple utility functions
- [Any other significant exclusions]

## Review Guidelines

**Focus on what matters:**
- Don't nitpick minor style issues
- Focus on architectural, logical, and maintainability concerns
- Identify issues that could cause problems in production or during maintenance

**Provide actionable recommendations:**
- Be specific about what should change and why
- Suggest concrete improvements
- Prioritize issues by impact (critical, important, minor)

**Format your review:**
1. Executive Summary (2-3 paragraphs)
2. Critical Issues (must fix)
3. Important Issues (should fix)
4. Minor Issues (nice to have)
5. Positive Observations (what's done well)

## Expected Output

Please provide:
- Structured review following the format above
- Specific file/line references where applicable
- Practical recommendations for improvement
- No need for detailed implementation plans or time estimates

---
```

### Step 7: Package Everything

**Create output directory:**

```bash
# Get current timestamp (YYYY-MM-DD-HHMM format)
TIMESTAMP=$(date +%Y-%m-%d-%H%M)

# Create review directory
REVIEW_DIR=".claude/external_reviews/$TIMESTAMP"
mkdir -p "$REVIEW_DIR"
```

**Create single review package file:**

```bash
# Create review_package.md with all components
cat > "$REVIEW_DIR/review_package.md" << 'EOF'
# External Code Review Package
Generated: [TIMESTAMP]
Focus: [FOCUS_AREA or "General code quality review"]

---

[REVIEW PROMPT SECTION - from Step 6]

---

# Project Context & Documentation

[SUMMARIZED README/SPECS - from Step 2]

---

# Codebase

[REPOMIX OUTPUT - from Step 5]

EOF
```

**Create metadata file:**

```bash
cat > "$REVIEW_DIR/metadata.json" << EOF
{
  "timestamp": "$TIMESTAMP",
  "focus": "$FOCUS_AREA",
  "files_included": $FILE_COUNT,
  "token_count": $TOKEN_COUNT,
  "review_type": "external",
  "config_file": ".repomix/config.json"
}
EOF
```

### Step 8: Final Report

**Report to user:**

```
✅ External review package prepared!

Location: .claude/external_reviews/YYYY-MM-DD-HHMM/review_package.md

Package Summary:
- Focus: [focus area or "General code quality"]
- Files included: 15 files (12 source, 3 config)
- Token count: ~47,000 tokens ✅ (under 100k target)
- Format: XML (no line numbers)

Files Included:
- Core: src/main.py, src/app.py, src/api/ (8 files)
- Business Logic: src/services/ (4 files)
- Config: config.yaml, settings.py, .env.example

Files Excluded:
- Tests: tests/ (20 files) - Stated in review prompt
- Utilities: src/utils/ (5 files) - Simple helpers, low review value
- Dependencies: venv/, node_modules/

Next Steps:
1. Review the package: .claude/external_reviews/YYYY-MM-DD-HHMM/review_package.md
2. Copy the entire content
3. Submit to external reviewer (Claude, GPT-4, human expert)
4. Share the single review_package.md file - it contains everything needed

RepoMix config saved to: .repomix/config.json
(Reusable for future reviews with similar scope)
```

## Token Efficiency Strategies

### Critical Settings
1. **XML format** - Clean separation without verbosity
2. **No line numbers** - Saves 20-30% tokens
3. **Remove empty lines** - Reduces noise
4. **Focus on relevant files** - 15 well-chosen files > 50 unfocused files

### Documentation Summarization
- README >5,000 tokens → Summarize to 2-3 pages
- Multiple spec docs → Combine and summarize
- Use Sequential Thinking MCP for complex summarization

### File Selection Intelligence
- Don't include every file "just in case"
- Simple utilities often don't need review
- Tests are typically excluded (state this clearly)
- 15-25 well-chosen files usually sufficient

### Token Budget Allocation
Target <100k total:
- Review prompt: ~3-5k tokens
- Documentation summary: ~5-10k tokens
- Codebase (RepoMix): ~40-80k tokens
- **Total: ~50-95k tokens**

## Error Handling

**If RepoMix not installed:**
```
ERROR: RepoMix not found.

Install RepoMix:
  npm install -g repomix

Or use npx (no install needed):
  npx repomix

For more info: https://repomix.com
```

**If token count >100k:**
```
⚠️ WARNING: Token count is 127,000 tokens (exceeds 100k target)

Recommendations to reduce:
1. Narrow focus area (exclude less critical files)
2. Summarize documentation more aggressively
3. Remove some utility/helper files
4. Consider splitting into multiple focused reviews

Rerun with more specific focus:
  /development:prepare-review "Focus only on core authentication layer"
```

**If no relevant files found:**
```
ERROR: No files matched the selection criteria.

Possible issues:
- Focus area too narrow
- File patterns don't match project structure
- All files excluded by gitignore

Try:
- Broaden focus area
- Review .repomix/config.json patterns
- Check that source files exist in expected locations
```

## MCP Tool Usage

### Sequential Thinking
**Use for:**
- Analyzing which files are relevant for review focus
- Determining what documentation to include vs summarize
- Making complex file selection decisions

**Example:**
```
When focus is "API authentication", I need to think through:
1. What files implement authentication? (middleware, guards, decorators)
2. What files DEPEND on authentication? (routes, controllers)
3. What files are UTILITY for authentication? (token helpers - include these)
4. What files are UNRELATED? (exclude)
```

### Serena (if available)
**Use for:**
- Finding symbols related to focus area
- Understanding code dependencies
- Identifying which files reference key components

**Example:**
```bash
# Find all files that implement or reference authentication
serena find_symbol "authenticate" --project-root .
serena find_symbol "AuthGuard" --project-root .
```

## Best Practices

### DO:
- ✅ Use Sequential Thinking for complex file selection decisions
- ✅ Summarize lengthy documentation (>10k tokens)
- ✅ Report token count prominently
- ✅ State clearly what's excluded and why
- ✅ Focus on architecture and maintainability over nitpicks
- ✅ Keep total package <100k tokens

### DON'T:
- ❌ Include every file "just in case"
- ❌ Include 50 pages of docs verbatim when 5-page summary suffices
- ❌ Include tests by default (state exclusion in prompt)
- ❌ Use line numbers (wastes tokens)
- ❌ Include simple utility files if not relevant to review
- ❌ Exceed 100k token target

## Example Workflow

```bash
# User runs command with focus
/development:prepare-review "Review the data processing pipeline"

# Command execution:
# 1. Uses Sequential Thinking to identify relevant files
#    → Core: src/pipeline/processor.py, src/pipeline/transformer.py
#    → Supporting: src/models/data.py, src/utils/validation.py
#    → Excluded: 15 other files not related to pipeline

# 2. Analyzes documentation
#    → README: 8000 tokens - include as-is
#    → ARCHITECTURE.md: 15000 tokens - summarize to 3000 tokens
#    → Total docs: ~11k tokens

# 3. Generates RepoMix config
#    → Includes 12 pipeline-related files
#    → XML format, no line numbers

# 4. Runs RepoMix
#    → 12 files processed
#    → Output: 42,000 tokens

# 5. Generates review prompt
#    → Focus on pipeline architecture, error handling, performance
#    → States tests excluded
#    → ~4k tokens

# 6. Packages everything
#    → .claude/external_reviews/2025-11-14-0530/review_package.md
#    → Total: ~57k tokens ✅

# 7. Reports results
#    → Location, token count, file summary
#    → User copies review_package.md and submits to reviewer
```

## Notes

- **Single file output**: Everything in one `review_package.md` for easy sharing
- **Reusable config**: `.repomix/config.json` can be reused for similar reviews
- **Timestamp-based**: No conflicts, easy chronological tracking
- **Self-contained**: Review package includes all context needed
- **Token-conscious**: Every decision optimized for efficiency

---

*Part of the development plugin - comprehensive code review preparation with RepoMix integration*
