---
allowed-tools: [Task, Bash, Read, Write, Grep, MultiEdit, mcp__firecrawl__firecrawl_search, mcp__firecrawl__firecrawl_scrape, mcp__sequential-thinking__sequentialthinking]
argument-hint: "[source: @file, #issue, description, or empty] [--work-unit ID]"
description: "Explore requirements and codebase with systematic analysis before planning (Anthropic's recommended first step)"
@import .claude/memory/conventions.md
@import .claude/memory/decisions.md
@import .claude/memory/dependencies.md
@import .claude/memory/lessons_learned.md
@import .claude/memory/project_state.md
---

# Requirements Exploration

I'll help explore the requirements and codebase through structured analysis, following Anthropic's recommended "Explore → Plan → Code → Commit" workflow.

**Input**: $ARGUMENTS

## Usage

### Requirement Analysis
```bash
/explore "build user authentication system"
/explore "fix login bug on mobile devices"
/explore "add payment processing"
```

### Document-Based Exploration
```bash
/explore @requirements.md          # Analyze requirements document
/explore @design-doc.md           # Explore design specification
/explore @issue-template.md       # Analyze issue description
```

### GitHub Issue Integration
```bash
/explore "#123"                   # Explore GitHub issue
/explore "issue #456"             # Alternative issue syntax
```

### Codebase Exploration
```bash
/explore                          # General codebase exploration
/explore "authentication code"    # Focused code exploration
```

## Implementation

```bash
#!/bin/bash

# Standard constants (must be copied to each command)
readonly CLAUDE_DIR=".claude"
readonly WORK_DIR="${CLAUDE_DIR}/work"
readonly MEMORY_DIR="${CLAUDE_DIR}/memory"

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

# Safe directory creation
safe_mkdir() {
    local dir="$1"
    mkdir -p "$dir" || error_exit "Failed to create directory: $dir"
}

# Parse arguments to extract requirement source and work unit
ARGUMENTS="$ARGUMENTS"
REQUIREMENT_SOURCE=""
REQUIREMENT_TYPE="description"
WORK_UNIT_ID=""

# Extract --work-unit flag if provided
if [[ "$ARGUMENTS" =~ --work-unit[[:space:]]+([0-9]+) ]]; then
    WORK_UNIT_ID="${BASH_REMATCH[1]}"
    # Remove --work-unit flag from arguments
    ARGUMENTS=$(echo "$ARGUMENTS" | sed 's/--work-unit[[:space:]]\+[0-9]\+//' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
fi

if [[ "$ARGUMENTS" =~ ^@(.+)$ ]]; then
    REQUIREMENT_SOURCE="${BASH_REMATCH[1]}"
    REQUIREMENT_TYPE="document"
elif [[ "$ARGUMENTS" =~ ^#([0-9]+)$ ]] || [[ "$ARGUMENTS" =~ issue[[:space:]]+#([0-9]+) ]]; then
    REQUIREMENT_SOURCE="${BASH_REMATCH[1]}"
    REQUIREMENT_TYPE="issue"
else
    REQUIREMENT_SOURCE="$ARGUMENTS"
fi

echo "🔍 Exploring Requirements"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Source Type: $REQUIREMENT_TYPE"
if [ -n "$REQUIREMENT_SOURCE" ]; then
    echo "Source: $REQUIREMENT_SOURCE"
fi
echo ""

# Generate date-based work unit ID
safe_mkdir "$WORK_DIR"

# Get current date for work unit prefix
WORK_DATE=$(date +%Y-%m-%d)

if [ -n "$WORK_UNIT_ID" ]; then
    # Use provided work unit ID
    WORK_COUNTER=$(printf "%02d" $WORK_UNIT_ID)
    WORK_NAME="${WORK_DATE}_${WORK_COUNTER}_exploration"
    if [ -n "$REQUIREMENT_SOURCE" ] && [ "$REQUIREMENT_TYPE" = "description" ]; then
        SLUG=$(echo "$REQUIREMENT_SOURCE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/_/g' | sed 's/__*/_/g' | sed 's/^_//;s/_$//' | cut -c1-30)
        WORK_NAME="${WORK_DATE}_${WORK_COUNTER}_${SLUG}"
    fi
else
    # Find next counter for today's date
    # Look for existing work units with today's date prefix
    EXISTING_UNITS=$(find "$WORK_DIR" -maxdepth 1 -type d -name "${WORK_DATE}_*" 2>/dev/null | wc -l)
    WORK_COUNTER=$(printf "%02d" $((EXISTING_UNITS + 1)))

    # Create work unit name
    WORK_NAME="${WORK_DATE}_${WORK_COUNTER}_exploration"
    if [ -n "$REQUIREMENT_SOURCE" ] && [ "$REQUIREMENT_TYPE" = "description" ]; then
        # Create slug from description
        SLUG=$(echo "$REQUIREMENT_SOURCE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/_/g' | sed 's/__*/_/g' | sed 's/^_//;s/_$//' | cut -c1-30)
        WORK_NAME="${WORK_DATE}_${WORK_COUNTER}_${SLUG}"
    fi
fi

WORK_UNIT_DIR="${WORK_DIR}/${WORK_NAME}"

# Create work unit directory structure
echo "📁 Creating work unit: $WORK_NAME"
safe_mkdir "$WORK_UNIT_DIR"

# Initialize metadata
METADATA_FILE="${WORK_UNIT_DIR}/metadata.json"
cat > "$METADATA_FILE" << EOF || error_exit "Failed to create metadata.json"
{
    "name": "$WORK_NAME",
    "date": "$WORK_DATE",
    "counter": "$WORK_COUNTER",
    "created_at": "$(date -Iseconds)",
    "requirement_type": "$REQUIREMENT_TYPE",
    "requirement_source": "$REQUIREMENT_SOURCE",
    "phase": "exploring",
    "status": "active"
}
EOF

# Create requirements.md
REQUIREMENTS_FILE="${WORK_UNIT_DIR}/requirements.md"
cat > "$REQUIREMENTS_FILE" << EOF || error_exit "Failed to create requirements.md"
# Requirements

## Source
- Type: $REQUIREMENT_TYPE
- Reference: $REQUIREMENT_SOURCE
- Date: $(date -Iseconds)

## Description
$REQUIREMENT_SOURCE

## Analysis
[To be completed during exploration]

EOF

# Create exploration.md
EXPLORATION_FILE="${WORK_UNIT_DIR}/exploration.md"
cat > "$EXPLORATION_FILE" << EOF || error_exit "Failed to create exploration.md"
# Exploration Summary

## Codebase Analysis
[To be completed]

## Implementation Approach
[To be completed]

## Next Steps
[To be completed]

EOF

# Set as active work unit
echo "$WORK_NAME" > "${WORK_DIR}/ACTIVE_WORK" || error_exit "Failed to set active work unit"

echo ""
echo "✅ Work unit created: $WORK_NAME"
echo "📁 Location: $WORK_UNIT_DIR"
echo ""
echo "Next: Analyzing requirements and codebase..."
```

## Phase 1: Create Work Unit Context

I'll establish a work unit to organize this exploration and track progress:

### Work Unit Creation
1. **Generate Date-Based ID**: Create date-prefixed identifier (YYYY-MM-DD_NN)
2. **Create Directory Structure**: Set up organized workspace in `.claude/work/`
3. **Initialize Metadata**: Record exploration context and objectives
4. **Set Active Context**: Mark this as the current work unit

### Work Unit Structure
```
.claude/work/YYYY-MM-DD_NN_topic/
├── metadata.json          # Work unit metadata and status
├── requirements.md        # Captured requirements
├── exploration.md         # Exploration findings
├── plan.md               # Implementation plan (if generated)
└── state.json            # Task state (if planning completed)
```

## Phase 2: Requirement Source Analysis

Based on the input provided: $ARGUMENTS

I'll determine the requirement source and analyze accordingly:

### Document Sources (@file syntax)
When analyzing requirement documents:
1. **Read Source Document**: Load and understand the complete specification
2. **Extract Key Requirements**: Identify functional and non-functional requirements
3. **Clarify Ambiguities**: Note unclear or missing specifications
4. **Identify Dependencies**: Map external dependencies and integration points
5. **Assess Complexity**: Evaluate implementation complexity and risks

### GitHub Issue Sources (#issue syntax)
When working with GitHub issues:
1. **Fetch Issue Details**: Load issue description, comments, and metadata
2. **Understand Problem Context**: Analyze the reported problem or feature request
3. **Review Related Issues**: Check linked issues and related discussions
4. **Extract Acceptance Criteria**: Identify success criteria and constraints
5. **Map Technical Requirements**: Translate user needs to technical specifications

### Natural Language Requirements
When analyzing descriptive requirements:
1. **Requirement Clarification**: Ask clarifying questions for ambiguous requirements
2. **Scope Definition**: Define what's included and excluded from the work
3. **Success Criteria**: Establish clear acceptance criteria
4. **Technical Constraints**: Identify platform, performance, and integration constraints
5. **Risk Assessment**: Highlight potential risks and mitigation strategies

## Phase 3: Codebase Context Analysis

### Project Understanding
1. **Architecture Overview**: Understand current system architecture and patterns
2. **Technology Stack**: Identify frameworks, libraries, and tools in use
3. **Code Organization**: Map directory structure and module organization
4. **Existing Patterns**: Identify established coding patterns and conventions
5. **Integration Points**: Understand how new work will integrate with existing code

### Enhanced Analysis with Sequential Thinking

For complex exploration scenarios, I'll use Sequential Thinking to ensure systematic coverage:

**When to use Sequential Thinking**:
- Multi-layered requirement analysis with interconnected components
- Complex codebase architecture exploration
- Risk analysis for large-scale changes or integrations
- Legacy system modernization planning
- Cross-domain requirement analysis involving multiple stakeholders

**Sequential Thinking Benefits**:
- Methodical requirement decomposition preventing oversights
- Structured risk assessment with comprehensive coverage
- Clear documentation of exploration reasoning and decisions
- Systematic analysis of complex interdependencies and constraints
- Reduced risk of missing critical integration points or edge cases

If the exploration involves significant complexity (multi-domain requirements, legacy integration challenges, or architectural decisions), I'll engage Sequential Thinking to work through the analysis systematically, ensuring all aspects are properly considered and documented.

**Graceful Degradation**: When Sequential Thinking MCP is unavailable, I'll use standard analytical approaches while maintaining comprehensive exploration quality. The tool enhances systematic analysis but isn't required for effective requirement exploration.

### Enhanced Analysis (with Other MCP Tools)
When MCP servers are available, enhance codebase understanding:

#### Systematic Architecture Analysis (Sequential Thinking)
For complex explorations, use structured reasoning to:
1. **Methodical Architecture Analysis**: Step-by-step understanding of system design
2. **Requirement Decomposition**: Structured breakdown of complex requirements
3. **Risk Analysis**: Comprehensive assessment of implementation risks and challenges
4. **Integration Planning**: Systematic planning of how changes fit into existing system

#### Semantic Code Analysis (with Serena MCP)
When Serena is connected, use semantic understanding for:
1. **Symbol-Level Analysis**: Understand actual class and function relationships
2. **Dependency Mapping**: Real import tracking and integration points
3. **Impact Analysis**: Understand what code will be affected by changes
4. **API Surface Analysis**: Identify public interfaces that may be affected

## Phase 4: Smart Planning Integration

### Automatic Plan Generation
Based on requirement complexity and clarity, I'll determine if a complete implementation plan can be generated:

#### Simple, Well-Defined Requirements
When requirements are clear and straightforward:
1. **Generate Complete Plan**: Create detailed task breakdown with dependencies
2. **Create state.json**: Initialize task tracking for immediate `/next` execution
3. **Skip `/plan` Step**: Allow direct progression to implementation
4. **Recommend Next Action**: "Plan looks complete, ready to run `/next`"

#### Complex or Ambiguous Requirements
When requirements need refinement:
1. **Generate Outline**: Create high-level plan structure
2. **Identify Unknowns**: Highlight areas needing clarification
3. **Recommend `/plan`**: "Run `/plan` to refine this outline into detailed tasks"
4. **Prepare Context**: Set up comprehensive context for planning session

### Plan Quality Assessment
For generated plans, evaluate:
1. **Completeness**: Are all requirements addressed?
2. **Feasibility**: Are tasks realistic and achievable?
3. **Dependencies**: Are task dependencies correctly identified?
4. **Testability**: Can each task be validated?
5. **Incremental**: Can work be delivered incrementally?

## Phase 5: Exploration Documentation

### Requirements Capture
Document the exploration in `requirements.md`:

```markdown
# Requirements: [Project/Feature Name]

## Overview
[Clear description of what needs to be built/fixed]

## Functional Requirements
1. [Requirement 1]
2. [Requirement 2]
3. [Requirement 3]

## Non-Functional Requirements
- Performance: [specifications]
- Security: [requirements]
- Compatibility: [constraints]

## Acceptance Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

## Out of Scope
- [What's explicitly not included]

## Dependencies
- [External dependencies]
- [Internal system dependencies]

## Risks and Assumptions
- [Key risks identified]
- [Assumptions made]
```

### Exploration Summary
Create `exploration.md` with findings:

```markdown
# Exploration Summary

## Codebase Analysis
- Architecture: [description]
- Key Files: [list of important files]
- Integration Points: [where changes will connect]

## Implementation Approach
- Strategy: [overall approach]
- Key Technologies: [tools and frameworks to use]
- Development Phases: [how to break down the work]

## Next Steps
[Recommended next actions]
```

## Phase 6: Context Handoff

### Work Unit Activation
1. **Set Active Context**: Mark this work unit as active for subsequent commands
2. **Update Session Memory**: Record exploration context for session continuity
3. **Prepare Planning Context**: Set up comprehensive context for `/plan` if needed
4. **Enable Task Execution**: If plan is complete, enable direct `/next` execution

### Recommendation Engine
Based on exploration findings, provide clear next step recommendations:

#### Ready for Implementation
```
✅ Requirements are clear and plan is complete
→ Run `/next` to start implementing
→ Estimated effort: X hours across Y tasks
```

#### Needs Planning Refinement
```
⚠️ Requirements need detailed planning
→ Run `/plan` to create detailed task breakdown
→ Key areas to plan: [list areas needing attention]
```

#### Needs Clarification
```
❓ Requirements have ambiguities
→ Clarify these questions first: [list questions]
→ Then run `/plan` for detailed implementation
```

## Success Indicators

- ✅ Work unit created and activated
- ✅ Requirements clearly documented
- ✅ Codebase context understood
- ✅ Integration approach identified
- ✅ Implementation complexity assessed
- ✅ Clear next steps recommended
- ✅ All exploration findings documented

## Enhanced Capabilities

### With Sequential Thinking MCP
- Structured reasoning through complex requirements
- Systematic risk analysis and mitigation planning
- Step-by-step architecture integration analysis

### With Serena MCP
- Semantic code understanding for integration planning
- Real dependency analysis and impact assessment
- Symbol-level understanding of existing codebase

### With Context7 MCP
- Automatic library documentation integration
- Framework-specific best practices
- Dependency-aware implementation guidance

## Examples

### Feature Exploration
```bash
/explore "add real-time notifications"
# → Analyzes notification requirements, creates work unit, generates implementation plan
```

### Bug Investigation
```bash
/explore "#123"
# → Loads GitHub issue, analyzes problem, creates debugging work unit
```

### Document-Based Planning
```bash
/explore @project-spec.md
# → Analyzes specification document, creates comprehensive implementation plan
```

### Codebase Discovery
```bash
/explore
# → General codebase exploration, identifies improvement opportunities
```

---

*First step in the structured development workflow, providing comprehensive requirement analysis and intelligent planning integration.*