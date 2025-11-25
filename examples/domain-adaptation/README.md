# Domain Adaptation: Claude Code Beyond Software

**Key Differentiator**: The toolkit extends Claude Code beyond software development to specialized domains like quantitative finance and professional writing.

This is something Anthropic emphasizes: internal teams use Claude for marketing, finance, legal, and more. Most Claude Code content focuses on software—these examples show broader applications.

---

## The Knowledge Encoding Problem

When adapting Claude Code to a new domain, you face a critical question:

**Where do you encode domain knowledge?**

| Level | What Goes Here | Example |
|-------|---------------|---------|
| **Agent Definition** | General awareness | "Look-ahead bias is a problem. Beware." |
| **Skills/Validators** | Specific checkpoints | "Check: `scaler.fit(X)` BEFORE `train_test_split`" |
| **Commands** | Workflow steps | `explore` → `plan` → `next` → `ship` |

**The insight**: General awareness isn't enough. You need specific, actionable checkpoints that catch real problems.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    DOMAIN KNOWLEDGE                          │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  AGENT DEFINITION (General Awareness)                       │
│  "Look-ahead bias is a problem. Beware."                   │
│                                                              │
│           ↓ Too vague - doesn't catch bugs                  │
│                                                              │
│  SKILLS/VALIDATORS (Specific Checkpoints)                   │
│  "Check: scaler.fit(X) BEFORE train_test_split"            │
│  "Check: sp500.*current for survivorship bias"             │
│  "Check: KFold without TimeSeriesSplit"                     │
│  [Pattern: regex, Impact: quantified, Fix: specific]        │
│                                                              │
│           ↓ Actionable - catches real bugs                  │
│                                                              │
│  COMMANDS (Workflow Steps)                                  │
│  explore → plan → next → ship                               │
│  (Same workflow adapts to any domain)                       │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Example 1: Quantitative Finance

**Domain**: ML-based trading strategies

**The Problem**: Look-ahead bias inflates backtest performance by 10-50%, making strategies look profitable when they'll fail in production.

**General awareness** (not enough):
> "Be careful about look-ahead bias in your backtests."

**Specific checkpoints** (what actually works):

### quant-ml-validator (7 patterns)

| Issue | Detection Pattern | Impact |
|-------|------------------|--------|
| Preprocessing leakage | `scaler\.fit\(X` before `train_test_split` | 5-20% inflation |
| Survivorship bias | `sp500.*current\|constituents.*today` | 2-4% annually |
| Wrong CV | `KFold` without `TimeSeriesSplit` | 20-40% inflation |
| Rolling window leakage | `\.rolling.*center=True` | 15%+ returns |
| Unadjusted prices | `\['Close'\]` without `Adj` | Phantom 50% losses |
| Timezone issues | `pd\.to_datetime` without `utc=True` | Silent data corruption |
| Multiple testing | `GridSearchCV` without held-out test | 99% false positive rate |

### quant-backtest-validator (6 patterns)

| Issue | Detection Pattern | Impact |
|-------|------------------|--------|
| Missing transaction costs | `pnl.*=.*(exit.*-.*entry)` without costs | 20-50% overstatement |
| Unrealistic slippage | `fill.*immediate\|instant` | 30-100 bps per trade |
| Same-bar execution | `signal.*close.*execute.*close` | 10-20% annual inflation |
| No futures roll | `futures\|continuous.*contract` without roll | $1-5k/contract yearly |
| Position errors | `position.*[+=]` without `cash.*[-=]` | Phantom leverage |
| Order book fantasy | `fill.*mid` without spread | 200-500% HF inflation |

### quant-risk-validator (8 patterns)

| Issue | Detection Pattern | Impact |
|-------|------------------|--------|
| Non-reproducible | `np\.random\.rand` without `seed` | Can't debug or verify |
| No drawdown limit | Missing `max_drawdown` checks | Total capital loss |
| Fixed position sizing | `position\s*=\s*\d+` | 5-10x leverage swings |
| No kill switch | `while True:.*trade` | Unstoppable losses |
| No config logging | `main\(\)` without `save_config` | Can't reproduce |
| Unlimited leverage | `leverage` without `max\|limit` | Margin calls |
| No data validation | `price` without `assert\|validate` | Wrong-way trades |
| No data lineage | Loading without `source\|version` | Compliance failure |

**See**: `quant/agents/` for full validator implementations.

---

## Example 2: Professional Writing

**Domain**: Business communication, technical documentation

**The Problem**: AI-generated content is often verbose, poorly structured, and buries the main point.

**General awareness** (not enough):
> "Write clearly and concisely."

**Specific frameworks** (what actually works):

### pyramid-principle skill

Barbara Minto's structure for clear communication:

```
                  [ANSWER / Core Message]
                           |
        ┌──────────────────┼──────────────────┐
        |                  |                  |
   [Argument 1]      [Argument 2]      [Argument 3]
        |                  |                  |
    [Details]          [Details]          [Details]
```

**Rules**:
1. Answer first (don't bury the lede)
2. Group related ideas
3. Use logical order
4. Maintain hierarchy levels

### scqa-framework skill

Situation-Complication-Question-Answer structure:

- **S**ituation: Context the reader already knows
- **C**omplication: What changed or went wrong
- **Q**uestion: What do we need to figure out?
- **A**nswer: The solution (your main point)

### plain-language skill

Federal Plain Language Guidelines for clarity:

- Use active voice
- Use short sentences (average 15-20 words)
- Use common words
- Put the main point first
- Use "you" and "we"

**See**: `writing/skills/` for full skill implementations.

---

## How to Apply This Pattern

### Step 1: Identify Domain-Specific Failure Modes

What mistakes are common in your domain?
- In quant: Look-ahead bias, survivorship bias, unrealistic fills
- In writing: Burying the lede, passive voice, jargon
- In your domain: ???

### Step 2: Create Detection Patterns

For each failure mode, define:
- **Pattern**: How to detect it (grep regex, structural check)
- **Impact**: Quantified consequence of the mistake
- **Fix**: Specific remediation with example

### Step 3: Package as Validators or Skills

- **Validators**: For code/data issues (use agents with grep patterns)
- **Skills**: For process/methodology (use SKILL.md with framework knowledge)

### Step 4: Integrate with Workflow

The `explore → plan → next → ship` workflow adapts to any domain:
- Quant: explore data → plan strategy → next implementation → ship with validation
- Writing: explore topic → plan outline → next draft → ship with review

---

## File Structure

```
domain-adaptation/
├── README.md                    # This file
├── quant/
│   └── agents/
│       ├── quant-ml-validator.md       # 7 ML/data patterns
│       ├── quant-backtest-validator.md # 6 execution patterns
│       └── quant-risk-validator.md     # 8 risk control patterns
└── writing/
    └── skills/
        ├── pyramid-principle/   # Barbara Minto's structure
        ├── scqa-framework/      # Situation-Complication-Question-Answer
        └── plain-language/      # Federal plain language guidelines
```

---

## Why This Matters

**Anthropic emphasizes**: Internal teams use Claude for marketing, finance, legal—not just coding.

**Most Claude Code content**: Focuses on software development.

**Our contribution**: Demonstrates how to adapt Claude Code to ANY domain by encoding domain knowledge in the right places.

The same workflow patterns (`explore` → `plan` → `next` → `ship`) work across domains. The domain-specific knowledge lives in validators and skills, not in the workflow itself.

---

## Related

- Main toolkit README: Explains plugin architecture
- Skills documentation: How to create skills
- Agents documentation: How to create specialized agents

---

**Version**: 1.0
**Created**: 2025-11-25
