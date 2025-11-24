---
allowed-tools: [Task, Bash, Read, Write, Grep, MultiEdit, mcp__sequential-thinking__sequentialthinking]
argument-hint: "[--from-requirements | --from-issue #123 | description]"
description: "Create detailed implementation plan with ordered tasks and dependencies using structured reasoning"
@import .claude/memory/decisions.md
@import .claude/memory/lessons_learned.md
@import .claude/memory/project_state.md
---

# Implementation Planning

I'll create a comprehensive implementation plan from your requirements, breaking down the work into manageable, ordered tasks.

**Input**: $ARGUMENTS

## Performance Monitoring Setup

I'll initialize performance tracking for this planning session:

```bash
# Initialize session performance tracking
PLAN_START_TIME=$(date +%s)
PLAN_SESSION_ID="plan_$(date +%s)_$$"

# Performance monitoring setup (optional)
if command -v npx >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
    echo "📊 Performance monitoring available"

    # Optional: Track baseline usage
    BASELINE_TOKENS=$(npx ccusage@latest session --since $(date -d "-1 hour" +%Y%m%dT%H) --json 2>/dev/null | jq '.sessions[-1].total_tokens // 0' 2>/dev/null || echo "0")

    if [ "$BASELINE_TOKENS" != "0" ]; then
        echo "📈 Session baseline: $BASELINE_TOKENS tokens"
    fi
else
    echo "📝 Running without performance monitoring (tools not available)"
fi
```

## Phase 1: Understand Planning Context

I'll validate the planning environment before creating the implementation plan:

1. **Check project setup** - Verify `.claude` directory and structure exist
2. **Find active work unit** - Look for work unit with completed exploration
3. **Validate requirements** - Ensure `requirements.md` exists and has content
4. **Check planning status** - Warn if overwriting existing plan

If any validation fails, I'll provide clear guidance on what needs to be completed first.

Based on the provided arguments: $ARGUMENTS

I'll determine the planning approach and source material:

- **From Requirements**: Use existing requirements documentation
- **From GitHub Issue**: Plan implementation for specific issue (#123)
- **From Description**: Create plan from provided description
- **Continuing Work**: Plan for active work unit

### Planning Prerequisites

Before creating an implementation plan, I'll verify:
1. **Requirements clarity**: Clear understanding of what needs to be built
2. **Work unit context**: Active work unit with exploration complete
3. **Technical constraints**: Understanding of platform, tools, dependencies
4. **Quality standards**: Testing, documentation, and delivery requirements

## Phase 2: Requirements Analysis and Task Decomposition

### Requirements Processing

I'll analyze the requirements to identify:
- **Core functionality**: Primary features and capabilities needed
- **Quality requirements**: Performance, security, reliability needs
- **Integration points**: External systems, APIs, dependencies
- **User experience**: Interface requirements, usability considerations
- **Technical constraints**: Platform limits, technology choices

### Enhanced Analysis with Sequential Thinking

For complex planning scenarios, I'll use Sequential Thinking to ensure systematic coverage:

**When to use Sequential Thinking**:
- Multi-dimensional planning problems
- Complex architectural decisions
- Risk analysis and mitigation planning
- Large-scale system design
- Integration challenges with multiple dependencies

**Sequential Thinking Benefits**:
- Structured reasoning through interconnected factors
- Comprehensive coverage of edge cases and dependencies
- Clear documentation of decision-making process
- Reduced risk of overlooking critical considerations

If the planning task involves significant complexity, I'll engage Sequential Thinking to work through the analysis systematically, ensuring all aspects are properly considered and documented.

**Graceful Degradation**: When Sequential Thinking MCP is unavailable, I'll use standard analytical approaches while maintaining comprehensive planning quality. The tool enhances the process but isn't required for effective planning.

### Task Breakdown Strategy

I'll decompose the work using these principles:

#### Task Sizing Guidelines
- **2-4 hours per task**: Focused, completable units of work
- **Single responsibility**: Each task has one clear objective
- **Testable outcomes**: Clear success criteria for each task
- **Incremental value**: Each task produces working functionality
- **API verification**: Confirm APIs exist before planning their use

#### Task Categories
- **Foundation**: Project setup, infrastructure, core architecture
- **Features**: User-facing functionality and business logic
- **Integration**: External system connections and APIs
- **Testing**: Test implementation and quality assurance
- **Documentation**: User guides, API docs, deployment instructions

## Phase 3: Dependency Analysis and Sequencing

### Dependency Mapping

I'll create a logical task sequence ensuring:
- **Prerequisites completed first**: Foundation before features
- **No circular dependencies**: Clear directed acyclic graph
- **Parallel opportunities**: Independent tasks identified
- **Critical path optimization**: Shortest path to working system

### Task Relationships
- **Sequential Dependencies**: Task B requires Task A completion
- **Parallel Opportunities**: Tasks that can be worked simultaneously
- **Optional Extensions**: Nice-to-have features that don't block delivery
- **Risk Mitigations**: Alternatives if high-risk tasks fail

## Phase 4: Create Implementation Plan

### State Management Setup

I'll create structured state tracking in `.claude/work/YYYY-MM-DD_NN_[work-unit]/`:

#### state.json Structure
```json
{
  "project": {
    "name": "Project Name",
    "description": "Clear project description",
    "created_at": "2025-01-24T10:00:00Z",
    "updated_at": "2025-01-24T10:00:00Z"
  },
  "status": "planning_complete",
  "current_task": null,
  "tasks": [
    {
      "id": "TASK-001",
      "title": "Setup project foundation",
      "description": "Create project structure, configure tools, setup development environment",
      "type": "foundation",
      "status": "pending",
      "dependencies": [],
      "acceptance_criteria": [
        "Project directory structure created",
        "Configuration files in place",
        "Development tools configured",
        "Initial tests passing"
      ],
      "estimated_hours": 3,
      "priority": "high"
    }
  ],
  "completed_tasks": [],
  "next_available": ["TASK-001"]
}
```

### Implementation Plan Document

I'll create a comprehensive plan document (`implementation-plan.md`) containing:

#### Project Overview
- **Objective**: What we're building and why
- **Scope**: What's included and excluded
- **Success criteria**: How we know we're done
- **Timeline estimate**: Total effort and critical milestones

#### Technical Architecture
- **Technology stack**: Languages, frameworks, tools chosen
- **Architecture patterns**: Design approaches and principles
- **Integration points**: External systems and dependencies
- **Data models**: Key entities and relationships

#### Task Execution Plan
- **Phase breakdown**: Logical groupings of related tasks
- **Critical path**: Minimum viable sequence to working system
- **Parallel tracks**: Independent work streams
- **Risk mitigation**: Contingency plans for high-risk elements

#### Quality Assurance Strategy
- **Testing approach**: Unit, integration, end-to-end testing
- **Code quality**: Linting, formatting, review standards
- **Documentation**: API docs, user guides, deployment instructions
- **Performance**: Benchmarks and optimization targets

## Phase 5: Enhanced Planning with Specialist Agent Guidance

### Agent Selection for Task Types

Based on the task breakdown, I'll suggest appropriate specialist agents for specific types of work:

#### 🏗️ Architecture & Design Tasks → **architect** agent
**Suggest when tasks involve**:
- System architecture decisions
- Technology stack choices
- Integration design
- Performance architecture
- Scalability planning

**Example suggestion**: *"TASK-002 involves complex microservices design. Consider using `/agent architect` for architectural guidance."*

#### 🧪 Testing & Quality Tasks → **test-engineer** agent
**Suggest when tasks involve**:
- Test strategy development
- Coverage analysis
- TDD implementation
- Performance testing
- Test automation setup

**Example suggestion**: *"TASK-005 requires comprehensive test coverage. Recommend `/agent test-engineer` for testing strategy."*

#### 🔍 Code Review & Security Tasks → **code-reviewer** agent
**Suggest when tasks involve**:
- Security analysis
- Code quality review
- Performance optimization
- Refactoring guidance
- Best practices validation

**Example suggestion**: *"TASK-007 handles authentication logic. Suggest `/agent code-reviewer` for security review."*

#### 📋 Framework & Compliance Tasks → **auditor** agent
**Suggest when tasks involve**:
- Framework compliance
- Setup validation
- Standards enforcement
- Configuration review
- Best practices audit

**Example suggestion**: *"TASK-001 sets up project structure. Consider `/agent auditor` for compliance validation."*

### Natural Agent Integration

In the planning output, I'll include agent suggestions as helpful recommendations rather than requirements:
- Use natural language like "Consider using..." or "Recommend involving..."
- Explain why the agent would be beneficial for specific tasks
- Always note that agent use is optional and user can override
- Suggest agents based on task content and complexity, not rigid rules

## Phase 6: Plan Validation and Finalization

### Completeness Verification

I'll validate the plan ensures:
- **All requirements mapped**: Every requirement has corresponding tasks
- **Dependencies resolved**: No circular dependencies or missing prerequisites
- **Resource requirements**: Time estimates and skill requirements clear
- **Quality gates**: Testing and review checkpoints defined
- **Integration planned**: External dependencies and APIs addressed

### Feasibility Assessment

I'll verify the plan is achievable by checking:
- **Technology maturity**: Chosen tools are stable and appropriate
- **Complexity management**: Tasks are properly scoped and sequenced
- **Resource availability**: Required skills and tools are accessible
- **Timeline realism**: Estimates account for complexity and dependencies

### Plan Documentation

Final deliverables include:
1. **state.json**: Machine-readable task definitions and dependencies
2. **implementation-plan.md**: Human-readable comprehensive plan
3. **task-details/**: Individual task specifications with acceptance criteria
4. **risk-assessment.md**: Identified risks and mitigation strategies

## Phase 7: Work Unit Transition

After creating the implementation plan, I'll:

### Update Work Unit Metadata
- **Phase transition**: Move from "exploring" to "planning_complete"
- **Task count**: Record number of tasks created
- **Effort estimate**: Total estimated hours for completion
- **Next actions**: Clear guidance for starting implementation

### Session Memory Update
- **Planning decisions**: Key architectural and technical choices
- **Critical path**: Most important sequence of tasks
- **Risks identified**: Major challenges and mitigation strategies
- **Next session prep**: What context to load for implementation

## Success Indicators

Implementation plan is complete when:
- ✅ All requirements have corresponding tasks
- ✅ Dependencies form valid directed acyclic graph
- ✅ Tasks are properly sized (2-4 hours each)
- ✅ Critical path identified and optimized
- ✅ Quality gates defined for each task
- ✅ Risk mitigation strategies documented
- ✅ Work unit ready for task execution

## Performance Summary and Optimization

I'll conclude with performance analysis and optimization recommendations:

```bash
# Calculate session performance metrics
PLAN_END_TIME=$(date +%s)
PLAN_DURATION=$((PLAN_END_TIME - PLAN_START_TIME))

if command -v npx >/dev/null 2>&1; then
    echo ""
    echo "📈 Planning Session Performance Report"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    # Get current session usage
    CURRENT_TOKENS=$(npx ccusage@latest session --since $(date -d "-1 hour" +%Y%m%dT%H) --json 2>/dev/null | jq '.sessions[-1].total_tokens // 0')
    SESSION_TOKENS=$((CURRENT_TOKENS - BASELINE_TOKENS))

    echo "⏱️ Planning Duration: ${PLAN_DURATION}s"
    echo "🎯 Tokens Used: $SESSION_TOKENS tokens"

    # Calculate efficiency metrics if dynamic context was used
    if [ -n "$DYNAMIC_CONTEXT_BUDGET" ]; then
        BUDGET_USAGE=$((SESSION_TOKENS * 100 / DYNAMIC_CONTEXT_BUDGET))
        echo "💰 Budget Utilization: ${BUDGET_USAGE}% of ${DYNAMIC_CONTEXT_BUDGET} allocated"

        # Monitor usage and provide alerts
        monitor_token_usage "$SESSION_TOKENS" "plan" 0

        # MCP tool effectiveness report
        if [[ "$DYNAMIC_CONTEXT_MCP_TOOLS" == *"sequential_thinking"* ]]; then
            echo "🧠 Sequential Thinking: Enhanced planning comprehensiveness"
        fi
    fi

    # ROI calculation for planning efficiency
    TYPICAL_PLANNING_TOKENS=8000  # Baseline for manual planning
    if [ $SESSION_TOKENS -lt $TYPICAL_PLANNING_TOKENS ]; then
        EFFICIENCY_GAIN=$(( (TYPICAL_PLANNING_TOKENS - SESSION_TOKENS) * 100 / TYPICAL_PLANNING_TOKENS ))
        echo "✅ Efficiency Gain: ${EFFICIENCY_GAIN}% token reduction vs baseline"
    fi

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
fi
```

## Next Steps

After planning completion:
1. **Review the plan**: Verify it meets requirements and expectations
2. **Begin implementation**: Run `/next` to start first available task
3. **Track progress**: Use `/system:status` to monitor task completion
4. **Adapt as needed**: Adjust plan based on implementation discoveries

### Performance Insights for Future Planning
- **Optimal Budget**: Planning operations typically need 20k tokens for comprehensive coverage
- **MCP Value**: Sequential Thinking provides systematic analysis with quality over efficiency focus
- **Context Efficiency**: Dynamic context system ensures relevant information loading within budget
- **Monitoring Benefits**: Real-time tracking enables optimization of planning workflows

---

*This command transforms requirements into actionable, dependency-ordered implementation plans with integrated performance monitoring and optimization insights.*