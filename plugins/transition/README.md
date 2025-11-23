# Transition Plugin

**Purpose**: Session boundary management and context handoffs

This plugin handles transitions between Claude Code sessions, managing context preservation and continuation.

---

## Commands (2)

### `/transition:handoff`

**Purpose**: Create session handoff document with context analysis

Creates a comprehensive handoff document capturing:
- Current work state and progress
- Key decisions made during session
- Token usage across all components
- Next steps and pending tasks
- Files modified and their changes

**Usage**:
```bash
/transition:handoff
```

**Output**: Time-stamped handoff document in `.claude/transitions/YYYY-MM-DD/HHMMSS.md`

**When to use**:
- Context usage >80% (quality degrading)
- End of work session (preserve state)
- Before switching tasks
- Regular checkpoints during long work

### `/transition:continue`

**Purpose**: Resume work from previous session handoff

Loads the most recent handoff document and provides:
- Summary of previous session
- Current state recap
- Pending tasks
- Recommended next actions

**Usage**:
```bash
/transition:continue
```

**When to use**:
- Start of new session
- After `/clear` to free conversation tokens
- Switching back to previous work
- Need recap of where you left off

---

## Why Separate from Memory Plugin?

**Session Transitions** (this plugin):
- Short-lived, time-bound documents
- Context window management
- Session-to-session continuity
- Tactical state preservation

**Persistent Memory** (memory plugin):
- Long-lived knowledge base
- Project understanding
- Accumulated insights
- Strategic knowledge capture

**Clear separation**: Transitions handle session boundaries, Memory handles knowledge persistence.

---

## Workflow Integration

**Typical flow**:

1. Work on task until context >80%
2. `/transition:handoff` - Create handoff
3. `/clear` - Free conversation tokens
4. `/transition:continue` - Resume with recap
5. Continue work with fresh context

**Key benefit**: Maintain work continuity across sessions without quality degradation.

---

## File Organization

```
.claude/transitions/
├── 2025-11-20/
│   ├── 171530.md      # Handoff at 5:15:30 PM
│   ├── 194215.md      # Handoff at 7:42:15 PM
│   └── ...
├── 2025-11-21/
│   └── ...
```

**Format**: `YYYY-MM-DD/HHMMSS.md` (date-based directories, time-stamped files)

---

## Related

- **Memory plugin**: Persistent knowledge management
- **Workflow plugin**: Task and work unit management
- **System commands**: `/context` for token usage analysis

---

**Version**: 1.0.0
**License**: MIT
