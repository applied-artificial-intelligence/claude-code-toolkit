# Screenshot Guide

Complete workflow demonstration from installation through execution.

## Installation Flow (Screenshots 02-07)

**02_plugin_cmd.png** - `/plugin` command menu
Shows the plugin management interface with options to browse, install, add marketplace, etc.

**02a_plugins_available.png** - Plugins available view
Alternative view showing available plugins.

**03_add_market_place.png** - Adding marketplace
Entering the local path to the claude-code-plugins repository.

**04_system_setup.png** - `/system:setup` command
System setup command showing available setup options.

**05_system_setup_choice.png** - Setup type selection
Interactive menu for choosing project type (Python, JavaScript, etc.).

**06_system_setup_settings_edit.png** - Settings.json editing
Editing `.claude/settings.json` with plugin configuration and hooks.

**07_system_setup_result.png** - Setup complete
Confirmation that system setup completed successfully.

## Workflow: Explore (Screenshot 08)

**08_explore.png** - `/workflow:explore` command
Analyzing the Research Paper Q&A PRD and creating exploration document.

## Workflow: Plan (Screenshots 09-16)

**09_plan_creating_tasks.png** - Plan generation starting
Creating state.json and analyzing requirements for task breakdown.

**10_plan_implementation_ready.png** - Implementation plan created
422-line implementation plan document created with 24 tasks across 5 phases.

**11_plan_technical_decisions.png** - Technical decisions
Key technology stack decisions (ChromaDB, sentence-transformers, pdfplumber, etc.) and architecture highlights.

**12_plan_next_steps.png** - Next steps and timeline
Instructions for running `/workflow:next` with estimated timeline by phase.

**13_plan_success_criteria.png** - Success criteria and structure
Project completion criteria, specialist agent recommendations, and work unit structure.

**14_plan_complete.png** - Planning validation complete
Plan status complete, ready for implementation with first task identified.

**15_plan_overview.png** - Phase breakdown overview
5 phases with task counts and hour estimates, plus critical path showing fastest route to MVP (8.5 hours).

**16_plan_specialist_agents.png** - Specialist agents suggestion
Recommendations for using test-engineer and code-reviewer agents on specific tasks.

## Workflow: Next - Task Execution (Screenshots 17-25)

**17_next_status.png** - `/workflow:next --status`
Checking work unit status showing 24 tasks, 0 completed, ready for TASK-001.

**18_next_ready_task001.png** - Ready for TASK-001
Prompt to execute first task: "Update project configuration and dependencies".

**19_next_task001_validation.png** - TASK-001 validation
Validating acceptance criteria (pyproject.toml updated, metadata updated, Python version set, CLI entry point configured).

**20_next_task001_complete.png** - TASK-001 completed
Task summary showing changes made (7 dependencies added, CLI entry point configured) with git commit.

**21_next_progress_task002.png** - Progress update
1/24 tasks complete (4%), Phase 1 Foundation in progress, TASK-002 next.

**22_next_ready_task002.png** - Ready for TASK-002
Prompt to execute TASK-002: "Create project structure and module organization" with 63% context usage note.

**23_next_progress_task003_004.png** - Parallel tasks available
2/24 tasks complete (8%), two tasks now available (TASK-003 config, TASK-004 models).

**24_next_task002_complete.png** - TASK-002 completed
Project structure created: 6 core modules (cli.py, ingestion.py, database.py, rag.py, config.py, models.py), data directories, .env.example, git commit.

**25_phase1_complete.png** - Phase 1 Foundation COMPLETE
All 4 foundation tasks done (100%): project config, structure, configuration, data models. Ready for Phase 2: PDF Ingestion Pipeline.

## Workflow: Handoff (Screenshots 26-28)

**26_handoff_creating.png** - `/memory:handoff` creating transition
Creating handoff document at 82% context usage, preserving session state before Phase 2.

**27_handoff_continue.png** - Using `/clear` and `/memory:continue`
Clearing conversation context and loading the handoff document to continue work.

**28_handoff_loaded.png** - Handoff successfully loaded
Showing work accomplished (Phase 1 complete, 4/24 tasks), next steps (TASK-005: PDF text extraction), and project structure with module status.

## Complete Workflow Summary

This demonstrates the full plugin workflow:

1. **Installation** (02-07): Add marketplace, configure plugins, setup project
2. **Explore** (08): Analyze PRD requirements deeply
3. **Plan** (09-16): Create comprehensive 24-task implementation plan with phases
4. **Execute** (17-25): Incremental task execution with validation and git commits
5. **Handoff** (26-28): Context management for session boundaries

**Key Features Shown**:
- Automatic task breakdown and dependency resolution
- Acceptance criteria validation
- Progress tracking across phases
- Parallel task identification
- Git integration (automatic commits)
- Context management at 82% usage
- Clean session continuation after handoff

**Total Progress**: 4/24 tasks (Phase 1 complete), 82% context at handoff, all changes committed to git.
