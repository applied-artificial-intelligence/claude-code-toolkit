---
title: continue
aliases: [resume]
---

# Continue from Latest Handoff

Automatically loads and continues from the most recent handoff document, with verification.

## Purpose

This command automates the continuation workflow after `/clear` by:
1. Finding the most recent handoff via dynamic lookup (no symlink needed)
2. Reading and loading context
3. Briefing you on what we're continuing from

## Usage

```bash
# After /clear, simply run:
/continue

# That's it - no manual file paths needed
```

## What It Does

### Step 1: Locate Latest Handoff
Dynamically finds the most recent transition using:

```bash
# Find most recent date directory
LATEST_DATE=$(ls -1 .claude/transitions/ | grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' | sort -r | head -1)

# Find most recent timestamp in that directory
LATEST_TIME=$(ls -1 ".claude/transitions/$LATEST_DATE/" | grep -E '^[0-9]{6}\.md$' | sort -r | head -1)

# Full path to most recent transition
LATEST_TRANSITION=".claude/transitions/$LATEST_DATE/$LATEST_TIME"
```

### Step 2: Load Context
Reads the handoff document and extracts key information.

### Step 3: Brief You
Tells you:
- Which handoff file is being loaded (date + UTC timestamp)
- Session focus from that handoff
- Active work status
- Main next steps

## Example Output

```
📋 Continuing from: .claude/transitions/2025-10-20/124933.md
   Handoff created: 2025-10-20 12:49:33 UTC

Session Focus: Handoff Command Refactoring - UTC Timestamp-based Organization
Active Work: Moved from numbered transitions to UTC timestamp structure
Next Steps: Complete handoff command updates, test new approach

Main Takeaways:
- Removed numbered format (2025-10-19_006) in favor of UTC timestamps
- No more counter management or symlink complexity
- Dynamic lookup using two simple ls commands
- PWD verification added to prevent wrong-directory creation

Ready to continue. What would you like to work on?
```

## Error Handling

If issues detected:
- **No date directories found**: Alerts you to create first handoff with `/handoff`
- **No transitions in latest date**: Indicates corruption or incomplete handoff
- **Wrong directory**: Verifies `.claude/transitions/` exists before proceeding

## Why This Exists

The `/handoff` command creates handoff documents but doesn't load them - that's intentional separation:
- **Create** (`/handoff`): Save current session state
- **Load** (`/continue`): Resume from saved state

This follows the principle of single responsibility and makes the workflow explicit.

## Typical Workflow

```bash
# End of session (context getting high)
/handoff

# Clear conversation
/clear

# Resume in new session
/continue
```

Clean, simple, explicit.

---

*Companion to `/handoff` - completes the handoff workflow loop*
