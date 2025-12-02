# Nano Banana Pro Prompts - Claude Code Toolkit

**Purpose**: Visual assets for toolkit README and marketing materials
**Style**: Matches Applied AI brand - clean, flat, blue progression, typography-driven

---

## Visualization 1: Workflow Cycle (Hero Image)

### Prompt:
```
Create a horizontal workflow showing the Claude Code task execution cycle.

Title: "Task Execution Workflow"

Layout: Left-to-right flow with 4 connected stages. Flat 2D.

Stages (rounded boxes connected by arrows, left to right):

1. "Explore"
   - Color: #90CAF9 (lightest)
   - Below: "Analyze requirements"
   - Below: "Create work breakdown"

2. "Plan"
   - Color: #64B5F6
   - Below: "Generate tasks"
   - Below: "Map dependencies"

3. "Next"
   - Color: #42A5F5
   - Below: "Execute incrementally"
   - Below: "Auto-commit changes"

4. "Ship"
   - Color: #1E3A5F (darkest)
   - Below: "Validate quality"
   - Below: "Create PR"

Arrows between stages should be clean, indicating sequential flow.
Add a subtle curved arrow from "Ship" back to "Explore" (indicating cycle).

One insight line below (small, gray):
"Each stage produces artifacts that persist across session boundaries."

White background. Generous spacing between stages.

Style:
- Horizontal flow, clean boxes
- Each box is self-contained with its purpose
- Color progression indicates advancement
- Subtle cycle arrow shows iterative nature

Bottom-right corner: "Applied AI" in small gray text

Dimensions: 1200x400px
```

---

## Visualization 2: Six Plugin Architecture

### Prompt:
```
Create a 2x3 grid showing the six Claude Code Toolkit plugins.

Title: "Six Plugins for Complete Workflows"

Layout: 2 rows x 3 columns grid. Flat 2D.

Row 1 (left to right):
1. "workflow"
   - Color: #1E3A5F (navy)
   - Below: "Task lifecycle"
   - Small text: "explore, plan, next, ship"

2. "memory"
   - Color: #2E5A7F
   - Below: "Knowledge persistence"
   - Small text: "index, review, gc"

3. "transition"
   - Color: #3D7EAA
   - Below: "Session boundaries"
   - Small text: "handoff, continue"

Row 2 (left to right):
4. "development"
   - Color: #4A9AC7
   - Below: "Code operations"
   - Small text: "analyze, review, test, fix"

5. "system"
   - Color: #64B5F6
   - Below: "Infrastructure"
   - Small text: "setup, audit, status"

6. "setup"
   - Color: #90CAF9 (lightest)
   - Below: "Project initialization"
   - Small text: "python, javascript, existing"

All boxes same size, equal spacing.

One insight line below (small, gray):
"Each plugin addresses a distinct aspect of development workflow."

White background.

Style:
- Grid layout, equal weight boxes
- Color progression from dark (core) to light (supporting)
- Command names in smaller text
- Clean, organized

Bottom-right corner: "Applied AI" in small gray text

Dimensions: 1100x550px
```

---

## Visualization 3: Progressive Disclosure Pattern

### Prompt:
```
Create a vertical stack showing the three-layer progressive disclosure pattern.

Title: "Progressive Disclosure"

Layout: Three horizontal layers stacked vertically. Flat 2D.

Layers (top to bottom, with size indicating token load):

1. Top layer (thin bar):
   - Label: "Metadata Layer"
   - Color: #90CAF9 (lightest)
   - Right side: "~2KB"
   - Below: "Plugin names, command descriptions"
   - Below: "Always loaded"

2. Middle layer (medium bar):
   - Label: "Core Documentation"
   - Color: #42A5F5
   - Right side: "~10KB"
   - Below: "Full command instructions"
   - Below: "Loads when invoked"

3. Bottom layer (thick bar):
   - Label: "Reference Materials"
   - Color: #1E3A5F (darkest)
   - Right side: "~5KB"
   - Below: "Detailed patterns, examples"
   - Below: "Loads only when needed"

Bars should be different heights (thin → medium → thick) to show relative size.
Add subtle downward arrows between layers indicating "loads when needed".

One insight line below (small, gray):
"Load context incrementally rather than all at once."

White background.

Style:
- Stacked layers show hierarchy
- Bar thickness indicates token weight
- Right-side KB labels show relative size
- Downward arrows show progressive loading

Bottom-right corner: "Applied AI" in small gray text

Dimensions: 900x500px
```

---

## Visualization 4: Context Management Cycle

### Prompt:
```
Create a simple two-stage cycle showing context management.

Title: "Context Management"

Layout: Two boxes with bidirectional flow. Flat 2D.

Left side:
- Box: "Working Session"
- Color: #42A5F5
- Below: "Context accumulates"
- Below: "70-80% threshold"

Right side:
- Box: "Handoff Document"
- Color: #1E3A5F
- Below: "State preserved"
- Below: ".claude/transitions/"

Arrows:
- Top arrow (left to right): "/handoff" label
- Bottom arrow (right to left): "/continue" label

Between the boxes, a small icon or indicator showing:
- "/clear" with downward arrow (context freed)

One insight line below (small, gray):
"Transitions create an automatic project history—decisions and reasoning preserved."

White background.

Style:
- Two-stage cycle, clear flow
- Commands as arrow labels
- Shows the save/restore pattern
- Clean, minimal

Bottom-right corner: "Applied AI" in small gray text

Dimensions: 1000x400px
```

---

## Visualization 5: File-Based State Management

### Prompt:
```
Create a directory tree visualization showing state management structure.

Title: "File-Based State Management"

Layout: Directory tree structure. Flat 2D.

Tree structure:
```
.claude/
├── work/
│   └── current/
│       └── [work-unit]/
│           ├── state.json
│           ├── exploration.md
│           └── implementation-plan.md
├── memory/
│   ├── project-context.md
│   └── lessons-learned.md
├── transitions/
│   └── 2025-11-27/
│       └── 143052.md
└── settings.json
```

Use color coding:
- Directories: #42A5F5 (blue text)
- JSON files: #1E3A5F (navy text)
- Markdown files: #3D7EAA (ocean blue text)

Right side annotations (small, gray):
- Next to state.json: "Task tracking"
- Next to exploration.md: "Analysis notes"
- Next to project-context.md: "Persistent knowledge"
- Next to transitions/: "Session handoffs"

One insight line below (small, gray):
"All state in JSON and Markdown. No databases, no background processes."

White background.

Style:
- Monospace font for tree structure
- Color-coded by file type
- Right-side annotations explain purpose
- Clean directory visualization

Bottom-right corner: "Applied AI" in small gray text

Dimensions: 800x550px
```

---

## Visualization 6: Anthropic Alignment Overview

### Prompt:
```
Create a two-column comparison showing toolkit alignment with Anthropic patterns.

Title: "Anthropic Best Practices Alignment"

Layout: Two columns side by side. Flat 2D.

Left column header: "Anthropic Recommendation"
- Color: #90CAF9 background
- Items (stacked vertically):
  1. "Multi-context window workflows"
  2. "JSON + Notes + Git state"
  3. "Progressive disclosure"
  4. "Memory tool patterns"
  5. "Subagent architecture"

Right column header: "Toolkit Implementation"
- Color: #1E3A5F background, white text
- Items (stacked vertically, aligned with left):
  1. "explore → plan → next → ship"
  2. "state.json + .md files + commits"
  3. "Skills load only when relevant"
  4. ".claude/memory/ directory"
  5. "5 specialized agents"

Connect each left item to its right counterpart with subtle horizontal lines or arrows.

One insight line below (small, gray):
"Same problems, same solutions—patterns validated through 6+ months of daily use."

White background.

Style:
- Two-column mapping
- Left light, right dark (recommendation → implementation)
- Alignment lines show direct correspondence
- Professional, credible

Bottom-right corner: "Applied AI" in small gray text

Dimensions: 1100x500px
```

---

## Visualization 7: MCP Integration (Optional Enhancement)

### Prompt:
```
Create a simple diagram showing MCP as optional enhancement layer.

Title: "MCP Integration: Optional Enhancement"

Layout: Two-layer horizontal diagram. Flat 2D.

Bottom layer (full width):
- Label: "Core Toolkit"
- Color: #1E3A5F (navy)
- Text: "All commands work without MCP"
- Subtext: "Stateless markdown, file-based persistence"

Top layer (floating boxes above, with dashed connection lines):
- 4 small boxes representing MCP servers:
  1. "Sequential Thinking" - #64B5F6
     - Below: "Structured reasoning"
  2. "Serena" - #42A5F5
     - Below: "Code understanding"
  3. "Context7" - #90CAF9
     - Below: "Documentation"
  4. "Chrome DevTools" - #90CAF9
     - Below: "Browser automation"

Dashed lines from each MCP box down to core layer (indicating optional connection).

One insight line below (small, gray):
"MCP enhances but never required. Graceful degradation when unavailable."

White background.

Style:
- Two layers: solid base, optional floating additions
- Dashed connections indicate optional nature
- Core layer is prominent, MCP layer is supplementary
- Clean separation

Bottom-right corner: "Applied AI" in small gray text

Dimensions: 1100x450px
```

---

## Usage Notes

### For README.md
Recommended placement:
1. **Workflow Cycle** (Viz 1) - After "Basic Workflow Pattern" section
2. **Six Plugins** (Viz 2) - In "Architecture" section
3. **Progressive Disclosure** (Viz 3) - Near "Token Optimization" discussion
4. **Context Management** (Viz 4) - In "Workflow Examples" near handoff/continue

### For Landing Page / Marketing
- **Workflow Cycle** as hero image
- **Anthropic Alignment** for credibility
- **Six Plugins** for feature overview

### Existing Screenshots to Embed
From `screenshots/` directory, recommend adding:
- `02_workflow_sequence.png` - Shows real terminal output of workflow
- `15_plan_overview.png` - Phase breakdown with estimates
- `25_phase1_complete.png` - Task completion example
- `28_handoff_loaded.png` - Context restoration demo

---

## Visual Design Philosophy

**Core Principles** (matching Applied AI brand):
- **Simplicity over decoration**: If an element doesn't add meaning, remove it
- **Coherent color progression**: Light blue (#90CAF9) to Navy (#1E3A5F)
- **Typography-driven**: Let text do the work, not icons
- **Whitespace is a feature**: Generous spacing signals confidence
- **No 3D effects**: Flat, modern, timeless
- **One takeaway per diagram**: Don't overload
- **One insight line only**: Below the diagram, small gray text

**Brand Colors**:
- Navy #1E3A5F (anchor/foundation)
- Ocean blue #3D7EAA (primary)
- Light blue #90CAF9, #64B5F6, #42A5F5 (progression)
- Gray #666666, #999999 (annotations only)
- White background throughout

**Attribution**:
- Always: `Bottom-right corner: "Applied AI" in small gray text`
