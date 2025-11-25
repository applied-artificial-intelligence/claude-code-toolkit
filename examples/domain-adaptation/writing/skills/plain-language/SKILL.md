---
name: plain-language
description: Simplification and readability techniques. Use when writing for broad audiences or simplifying complex content. Covers active voice, short sentences, jargon elimination, and accessibility principles from the Plain Language Movement.
---

# Plain Language

**Purpose**: Write clearly and directly using active voice, simple sentences, and minimal jargon.

**Origin**: Plain Writing Act of 2010 (US), Plain Language Movement

**Use When**: Drafting and reviewing content to maximize clarity (Phases 4-5)

---

## Core Principle

**Plain language means readers understand immediately what you're saying - no rereading required.**

### Why It Matters

- **Comprehension**: 80% of readers prefer plain language (Bailey 2017)
- **Efficiency**: Plain language reduces reading time by 25-40% (Redish 1985)
- **Accessibility**: Technical audiences still prefer clarity over jargon

---

## The Four Rules

### 1. Use Active Voice (>80% target)

**Passive**: Subject receives action ("The error was caught by the test")
**Active**: Subject performs action ("The test caught the error")

**Why Active is Better**:
- Shorter (fewer words)
- Clearer (who does what)
- More direct (action-oriented)

**Examples**:
```markdown
❌ PASSIVE:
"The bug was discovered by the QA team"
"Performance improvements were made to the API"
"A decision will be made by the committee"

✅ ACTIVE:
"The QA team discovered the bug"
"We improved API performance"
"The committee will decide"
```

**Detection Pattern**: "was/were/is/are + past participle + by"

**When Passive is Okay**:
- Unknown actor: "The system was compromised"
- Actor irrelevant: "Errors are logged automatically"
- Emphasizing recipient: "The president was elected by landslide"

### 2. Shorten Sentences (<25 words average)

**Principle**: Long sentences increase cognitive load and reduce comprehension.

**Targets**:
- **Average**: <25 words per sentence
- **Maximum**: Avoid >35 word sentences
- **Variety**: Mix short (10-15) and medium (20-25) sentences

**Techniques**:
```markdown
❌ LONG (42 words):
"After extensive research and consideration of multiple
frameworks over several months using various criteria
including performance, ecosystem size, learning curve,
and community support, we determined that React offers
the best balance for our team's needs."

✅ SPLIT (2 sentences, 23 + 14 words):
"Our evaluation of 5 frameworks over 3 months ranked
React highest across 12 criteria, including performance,
ecosystem, and learning curve. React offers the best
balance for our team's needs."
```

**How to Shorten**:
1. Split at "and", "but", "because"
2. Remove redundancy
3. Break into bullets if listing >3 items
4. Move subordinate clauses to new sentence

### 3. Eliminate Jargon (or Explain on First Use)

**Jargon**: Specialized terminology that excludes readers.

**When to Use Jargon**:
- ✅ Technical audience expects it (API docs for developers)
- ✅ No simpler alternative exists (monadic bind operation)
- ✅ Explained on first use with example

**When to Avoid**:
- ❌ Simpler word exists: "utilize" → "use"
- ❌ Buzzword adds no meaning: "leverage synergistic paradigms"
- ❌ Abbreviation unexplained: "RBAC" (first use: Role-Based Access Control)

**Examples**:
```markdown
❌ JARGON HEAVY:
"Leverage microservices to achieve scalable, cloud-native
architecture with seamless integration paradigms"

✅ PLAIN:
"Break your application into small, independent services
that can scale individually and run in the cloud"

✅ JARGON EXPLAINED:
"Use microservices—small, independent services that handle
specific functions—to scale your application efficiently"
```

### 4. Write Clearly (Avoid Common Issues)

**Nominalization** (verb → noun weakens writing):
```markdown
❌ make a decision → ✅ decide
❌ perform an analysis → ✅ analyze
❌ give consideration to → ✅ consider
❌ have a discussion about → ✅ discuss
```

**Weak Verbs** (vague actions):
```markdown
❌ utilize → ✅ use
❌ facilitate → ✅ enable / allow
❌ implement → ✅ build / create
❌ leverage → ✅ use / apply
```

**Redundancy** (unnecessary words):
```markdown
❌ advance planning → ✅ planning
❌ past history → ✅ history
❌ completely eliminate → ✅ eliminate
❌ end result → ✅ result
```

**Weasel Words** (often removable):
```markdown
❌ very important → ✅ critical / important
❌ really significant → ✅ significant
❌ actually improves → ✅ improves
❌ basically works → ✅ works
```

---

## Application by Mode

### Tutorial (Maximum Clarity)
- Active voice: >90%
- Short sentences: <20 words average
- No jargon: Explain everything
- Encouraging tone: "You'll see", "Now you can"

### How-To (Direct and Efficient)
- Active voice: >85%
- Imperative mood: "Run the command", "Configure the setting"
- Minimal prose: Action-focused
- Technical terms okay if audience expects them

### Reference (Precise but Clear)
- Active voice: >70% (passive okay for specifications)
- Longer sentences acceptable: Technical precision matters
- Jargon expected: But define abbreviations
- Neutral tone: No "should" or opinions

### Explanation (Thoughtful Clarity)
- Active voice: >80%
- Medium sentences: <25 words average
- Analogies valued: Make abstract concepts concrete
- Jargon explained: Teach terms through use

---

## Measurement

### Active Voice Percentage

**Calculation**:
1. Count sentences with passive voice markers ("was/were + past participle + by")
2. Count total sentences
3. Active % = (1 - passive_count / total) * 100

**Targets**:
- 90-100%: Excellent (Tutorial)
- 80-89%: Good (How-To, Explanation)
- 70-79%: Acceptable (Reference)
- <70%: Needs improvement

### Sentence Length

**Calculation**:
1. Count words per sentence
2. Calculate average
3. Flag sentences >35 words

**Targets**:
- <20 words: Excellent clarity
- 20-25 words: Good balance
- 25-30 words: Acceptable but monitor
- >30 words: Consider splitting

### Readability (Flesch-Kincaid)

Plain language typically scores:
- **Reading Ease**: 60-70 (Standard)
- **Grade Level**: 8-10 (8th-10th grade)

---

## Quality Checklist

**Plain language compliance**:

- [ ] Active voice >80% (or mode-appropriate target)
- [ ] Average sentence length <25 words
- [ ] No sentences >50 words
- [ ] Jargon explained on first use
- [ ] No nominalization ("make a decision" → "decide")
- [ ] No weak verbs ("utilize" → "use")
- [ ] No redundancy ("advance planning" → "planning")
- [ ] Weasel words removed or justified
- [ ] Abbreviations spelled out on first use
- [ ] Technical terms defined through use

---

## References

- Plain Writing Act of 2010. US federal requirement for clear communication.
- Redish, J.C. (1985). "The Plain English Movement". Technical communication study.
- Bailey, S. (2017). "Plain Language: A Strategic Approach". Comprehension research.
- Flesch, R. (1948). "A New Readability Yardstick". Original readability formula.
- Strunk, W., & White, E.B. (2000). *The Elements of Style*. Clarity principles.
