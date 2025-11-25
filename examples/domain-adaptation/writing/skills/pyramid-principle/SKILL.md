---
name: pyramid-principle
description: Hierarchical content structure - answer first, then supporting arguments, then details
foundation: Barbara Minto's Pyramid Principle
use_case: Outlines, business communication, structured explanations
---

# Pyramid Principle Skill

**Foundation**: Barbara Minto's pyramid principle for clear, logical communication

**Core Concept**: Start with the answer, then provide supporting arguments, then add details.

**Why This Works**:
- Reader gets main point immediately (respects their time)
- Supporting structure makes logical sense
- Details are contextualized (not lost)
- Reader can stop at any level and still understand core idea
- Reduces cognitive load (top-down, not bottom-up)

---

## The Pyramid Structure

```
                  [ANSWER / Core Message]
                           |
        ┌──────────────────┼──────────────────┐
        |                  |                  |
   [Argument 1]      [Argument 2]      [Argument 3]
        |                  |                  |
    ┌───┼───┐          ┌───┼───┐          ┌───┼───┐
    |   |   |          |   |   |          |   |   |
  [Details] [Details] [Details] [Details] [Details] [Details]
```

**Levels**:
1. **Level 1**: The answer/conclusion (what they need to know)
2. **Level 2**: Major supporting arguments (why answer is true)
3. **Level 3**: Evidence and examples (what proves arguments)
4. **Level 4**: Details and elaboration (depth as needed)

---

## Core Rules

### Rule 1: Answer First
**Always start with the conclusion**

❌ **Don't do this** (bottom-up):
```markdown
We analyzed 10 frameworks. We tested each for 6 months.
We measured productivity, reliability, and ease of use.
Framework X performed best. Therefore, we recommend Framework X.
```

✅ **Do this** (top-down):
```markdown
**We recommend Framework X** because it delivers 30% higher productivity
with proven reliability over 6 months of testing.

Here's why:
1. Productivity: 30% improvement vs alternatives
2. Reliability: Zero critical failures in production
3. Ease of adoption: 2-week learning curve vs 2-month for alternatives
```

**Why**: Reader knows the answer immediately. Supporting details provide confidence, but aren't prerequisite to understanding recommendation.

### Rule 2: Group Related Ideas
**Ideas in each group must be**:
- Related to each other (same category)
- Support the idea above them
- At same level of abstraction

✅ **Good grouping**:
```
Core Message: "CAF transforms Claude Code into domain-specific agents"
├─ Argument 1: Customization spectrum (out-of-box → CAF → SDK)
├─ Argument 2: Domain transformation examples
└─ Argument 3: Proven patterns and constraints
```

❌ **Bad grouping** (mixed levels):
```
Core Message: "CAF transforms Claude Code into domain-specific agents"
├─ Argument 1: Customization spectrum
├─ Argument 2: File-based persistence (this is a detail, not major argument)
└─ Argument 3: Stefan uses it for ML4T book (this is an example, not argument)
```

### Rule 3: Logical Order
**Arguments must follow logical sequence**:

**Structural order**: Parts of something
- Example: "Framework has 3 components: commands, agents, skills"

**Chronological order**: Time sequence
- Example: "Workflow: positioning → research → outline → draft → review"

**Comparative order**: Ranking or comparison
- Example: "Benefits ranked: reliability > productivity > ease"

**Problem-solution order**: Issue then resolution
- Example: "Problem: Generic AI agents fail. Solution: Domain-specific customization."

---

## Application to Content Types

### Application 1: Outlines (Architect Agent)

**Structure**:
```markdown
# Outline

## Opening (Level 1: Answer)
- Hook (grab attention)
- Core message (the answer)
- Preview (what's coming)

## Body (Level 2: Arguments)
### Argument 1: [First supporting point]
- Evidence (Level 3)
- Examples (Level 3)
- Details (Level 4)

### Argument 2: [Second supporting point]
- Evidence (Level 3)
- Examples (Level 3)
- Details (Level 4)

### Argument 3: [Third supporting point]
- Evidence (Level 3)
- Examples (Level 3)
- Details (Level 4)

## Closing (Level 1: Reinforce Answer)
- Restate core message
- Call to action
```

**Example for CAF white paper**:
```markdown
Opening: "Transform Claude Code into specialized domain agents"
├─ Argument 1: Customization spectrum (out-of-box → CAF → SDK)
│  ├─ Evidence: What each level provides
│  ├─ Example: Content management workflow
│  └─ Details: When to use each level
├─ Argument 2: Domain transformation mechanism
│  ├─ Evidence: How markdown customization works
│  ├─ Example: Commands, agents, skills
│  └─ Details: Technical architecture
└─ Argument 3: Proven patterns and constraints
   ├─ Evidence: 6 months production use
   ├─ Example: Specific patterns
   └─ Details: How constraints prevent failure
Closing: Reinforce transformation message + CTA
```

### Application 2: Business Communication

**Memo structure**:
```markdown
Subject: Recommendation

**Recommendation**: [The answer - one sentence]

**Rationale**: [3-5 supporting arguments]
1. Argument 1
2. Argument 2
3. Argument 3

**Details**: [Evidence for each argument]
[Expand on arguments with data, examples, elaboration]
```

**Why this works**: Executive reads first line, gets answer, decides if they need to read more.

### Application 3: Technical Explanations

**Explain "What is CAF?"**:

❌ **Bottom-up** (reader lost):
```markdown
Claude Code has plugins. Plugins have commands. Commands invoke agents.
Agents use skills. Skills provide patterns. Patterns create frameworks.
Therefore, CAF is a meta-framework for domain-specific agent customization.
```

✅ **Top-down** (pyramid):
```markdown
**CAF transforms Claude Code into domain-specific agents through markdown-based customization.**

How it works:
1. Commands: Encapsulate domain workflows
2. Agents: Provide specialized capabilities
3. Skills: Define behavior patterns

Why it matters:
- Transforms generic AI into domain-expert
- Uses simple markdown (no coding required)
- Proven patterns prevent common failures
```

**Reader benefit**: Understands "what it is" immediately, can drill into details if interested.

---

## Common Mistakes

### Mistake 1: Burying the Lede
❌ **Don't hide the answer**:
```markdown
We conducted extensive research. We analyzed frameworks.
We tested implementations. We gathered feedback.
After 6 months, we discovered that...
```

✅ **Answer first**:
```markdown
**CAF prevents AI chaos through stateless, file-based architecture.**

Evidence from 6 months testing:
- Zero state corruption failures
- 100% reproducible results
- Context preserved across sessions
```

### Mistake 2: Mixed Abstraction Levels
❌ **Arguments at different levels**:
```
1. Customization spectrum (high-level concept)
2. File-based persistence (implementation detail)
3. Domain transformation (high-level concept)
```

✅ **Same level**:
```
1. Customization spectrum (what CAF provides)
2. Domain transformation (how it works)
3. Proven patterns (why it's reliable)
```

### Mistake 3: Illogical Order
❌ **Random order**:
```
1. Benefits
2. How it works
3. What it is
```

✅ **Logical order**:
```
1. What it is (establish understanding)
2. How it works (explain mechanism)
3. Benefits (show value)
```

### Mistake 4: No Hierarchy
❌ **Flat list**:
```
- Point 1
- Point 2
- Point 3
- Point 4
- Point 5
(All at same level, no structure)
```

✅ **Hierarchical**:
```
Core Message
├─ Major Point 1
│  ├─ Supporting detail
│  └─ Example
├─ Major Point 2
│  ├─ Supporting detail
│  └─ Example
└─ Major Point 3
   ├─ Supporting detail
   └─ Example
```

---

## Quality Checklist

**When applying pyramid principle, verify**:

- [ ] Answer/conclusion stated first (Level 1)
- [ ] 3-5 major supporting arguments identified (Level 2)
- [ ] Each argument supports answer above it
- [ ] Evidence/examples provided for arguments (Level 3)
- [ ] Details elaborated as needed (Level 4)
- [ ] Arguments grouped logically (related ideas together)
- [ ] Arguments ordered logically (structural/chronological/comparative/problem-solution)
- [ ] Each level is at consistent abstraction level
- [ ] Reader can stop at any level and still understand core idea
- [ ] No "burying the lede" (answer hidden at end)

---

## Integration with Other Skills

**Pyramid + excellent-writing**:
- Pyramid: What structure to use
- excellent-writing: How to write clearly within that structure

**Pyramid + SCQA**:
- Pyramid: Overall hierarchical structure
- SCQA: How to structure narrative within pyramid (especially opening)

**Pyramid + positioning-first**:
- Positioning: What the core message is (Level 1 of pyramid)
- Pyramid: How to structure arguments supporting that message

---

## References

**Foundation**: Barbara Minto, "The Pyramid Principle: Logic in Writing and Thinking"

**Key insight**: "Any intelligent reader can absorb only one thought at a time, and will automatically assume that any sentence that follows a previous one is intended to explain that thought further."

**Application**: Therefore, organize content to match how readers naturally process information - top-down, hierarchical, answer-first.

---

**Skill Version**: 1.0
**Created**: 2025-10-31
**Used by**: architect agent (outlines), author agent (optional)
**Key Innovation**: Answer-first hierarchical structure that respects reader's cognitive load
