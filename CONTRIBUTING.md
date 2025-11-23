# Contributing to Claude Code Plugins

Thank you for your interest in contributing to Claude Code Plugins! This document provides guidelines for contributing to the project.

## Code of Conduct

By participating in this project, you agree to abide by our Code of Conduct:

- **Be respectful**: Treat everyone with respect. No harassment, discrimination, or unprofessional behavior.
- **Be constructive**: Provide helpful feedback. Focus on improving the project.
- **Be collaborative**: Work together. We're building something valuable for the community.

## How to Contribute

### Reporting Bugs

Before submitting a bug report:

1. **Search existing issues** to see if the problem has already been reported
2. **Check the documentation** to ensure you're using the framework correctly
3. **Test with the latest version** to see if the issue has been resolved

When submitting a bug report, include:

- **Clear title and description** of the issue
- **Steps to reproduce** the behavior
- **Expected behavior** vs what actually happened
- **Environment details** (Claude Code version, OS, plugins enabled)
- **Relevant logs or error messages**
- **Screenshots** if applicable

### Suggesting Features

We love feature suggestions! Before submitting:

1. **Search existing issues** to see if it's already been suggested
2. **Check the roadmap** to see if it's planned
3. **Consider if it fits the project scope** (general workflow vs domain-specific)

When suggesting a feature:

- **Describe the problem** you're trying to solve
- **Explain your proposed solution** and why it's the best approach
- **Provide examples** of how it would be used
- **Consider backwards compatibility**

### Submitting Pull Requests

#### Before You Start

1. **Open an issue** first to discuss significant changes
2. **Fork the repository** and create a branch from `main`
3. **Read the architecture docs** to understand the framework design

#### Development Process

1. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**:
   - Follow existing code style and patterns
   - Add tests if applicable
   - Update documentation
   - Ensure all tests pass

3. **Write good commit messages**:
   ```
   feat: add memory-import command for bulk memory loading

   - Supports JSON and Markdown file imports
   - Validates structure before importing
   - Updates memory-review to show imported files
   ```

   Use conventional commits:
   - `feat:` - New feature
   - `fix:` - Bug fix
   - `docs:` - Documentation only
   - `style:` - Formatting, missing semicolons, etc
   - `refactor:` - Code restructuring
   - `test:` - Adding tests
   - `chore:` - Maintenance

4. **Test your changes**:
   ```bash
   # Test in a real project
   cd ~/test-project
   # Enable your modified plugin
   # Test all affected commands
   ```

5. **Submit your pull request**:
   - Provide a clear description of what changed and why
   - Reference any related issues
   - Include screenshots/examples if relevant
   - Ensure CI passes

#### Pull Request Checklist

- [ ] Code follows existing style and patterns
- [ ] Tests added/updated (if applicable)
- [ ] Documentation updated (if applicable)
- [ ] All tests pass
- [ ] Commit messages follow conventional commits
- [ ] Branch is up to date with main
- [ ] No merge conflicts

### Adding Commands to Existing Plugins

Contributing a new command to an existing plugin:

1. **Choose the right plugin**:
   - **system** - System configuration and health (status, setup, audit, cleanup)
   - **workflow** - Development workflow (explore, plan, next, ship, work, spike)
   - **development** - Code quality (analyze, test, fix, run, review, docs)
   - **agents** - Agent invocation (agent, serena)
   - **memory** - Knowledge and context (memory-*, index, handoff, performance)
   - **git** - Version control operations

2. **Create command file**:
   ```bash
   # Create command in appropriate plugin
   touch plugins/workflow/commands/my-command.md
   ```

3. **Follow command structure** (see `src/utils/README.md` for complete guide):
   ```markdown
   ---
   name: my-command
   description: Brief description
   ---

   # Command Implementation

   #!/bin/bash
   set -euo pipefail

   # Copy required utilities inline (see WHY_DUPLICATION_EXISTS.md)
   # - Constants (CLAUDE_DIR, WORK_DIR, etc.)
   # - error_exit(), warn(), debug()
   # - safe_mkdir(), require_tool()

   # Your command logic here
   ```

4. **Update plugin.json**:
   ```json
   {
     "capabilities": {
       "myCapability": {
         "description": "What your command does",
         "command": "my-command"
       }
     }
   }
   ```

5. **Update plugin README**:
   - Add command to command list
   - Document usage and examples
   - Note any dependencies or integrations

### Creating New Plugins

Want to contribute a new plugin? Great! Here's the process:

1. **Propose the plugin** by opening an issue:
   - Describe what problem it solves
   - Explain why it needs a new plugin (vs adding to existing plugin)
   - Outline the commands and capabilities
   - Consider existing plugin categories (system, workflow, development, agents, memory, git)

2. **Wait for approval** before starting development

3. **Follow plugin structure**:
   ```
   your-plugin/
   ├── .claude-plugin/
   │   └── plugin.json      # Required manifest
   ├── commands/            # Slash commands
   │   └── *.md
   ├── agents/              # Specialized agents (optional)
   │   └── *.md
   └── README.md            # Plugin documentation
   ```

4. **Create plugin.json** (required):
   ```json
   {
     "name": "claude-code-your-plugin",
     "version": "1.0.0",
     "description": "Clear, concise description",
     "capabilities": {
       "capabilityName": {
         "description": "What this capability does",
         "command": "command-name"
       }
     },
     "dependencies": {
       "claude-code-system": "^1.0.0"
     }
   }
   ```

5. **Test thoroughly**:
   - Test all commands in isolation
   - Test integration with other plugins (especially dependencies)
   - Test in multiple projects
   - Document any dependencies or requirements

6. **Document well**:
   - Clear README with command reference and examples
   - Agent capabilities documentation (if any)
   - Configuration options
   - Integration points with other plugins
   - Known limitations

### Improving Documentation

Documentation improvements are always welcome!

- **Fix typos or unclear language**
- **Add examples** to clarify concepts
- **Improve organization** for better navigation
- **Add tutorials** for common use cases
- **Update outdated information**

For documentation changes:

1. Edit files in `docs/`
2. Test links work correctly
3. Ensure markdown renders properly
4. Submit a pull request

### Code Style

- **Follow existing patterns**: Look at similar code in the project
- **Keep it simple**: Prefer clarity over cleverness
- **Comment when needed**: Explain "why", not "what"
- **Use descriptive names**: Variables, functions, commands should be self-documenting
- **Maintain consistency**: Match the style of the file you're editing

**Command Files** (`.md`):
- Use YAML frontmatter for metadata
- Start with clear description
- Provide usage examples
- Include error handling
- Document all parameters

**Agent Files** (`.md`):
- Clear role definition in frontmatter
- Structured sections with markdown headers
- Examples of agent capabilities
- Clear boundaries (what the agent does/doesn't do)

### Testing

Currently, testing is manual. We're working on automated testing.

**Manual Testing Process**:

1. **Create a test project**:
   ```bash
   mkdir ~/test-claude-code-toolkit
   cd ~/test-claude-code-toolkit
   git init
   ```

2. **Enable your modified plugin**:
   ```json
   // .claude/settings.json
   {
     "extraKnownMarketplaces": {
       "local": {
         "source": {
           "source": "directory",
           "path": "/path/to/your/fork/plugins"
         }
       }
     },
     "enabledPlugins": {
       "your-plugin@local": true
     }
   }
   ```

3. **Test all affected commands**:
   - Run each command with typical inputs
   - Test error cases
   - Test integration with other commands
   - Check state management (if applicable)

4. **Verify backwards compatibility**:
   - Test with existing work units
   - Ensure no breaking changes to APIs
   - Update version if breaking changes required

## Community

- **GitHub Discussions**: For questions and general discussion
- **GitHub Issues**: For bug reports and feature requests
- **Pull Requests**: For code contributions
- **Blog**: Share your plugins and use cases

## Recognition

Contributors will be:

- Listed in [CONTRIBUTORS.md](CONTRIBUTORS.md)
- Mentioned in release notes for their contributions
- Credited in documentation they author

## Questions?

If you have questions about contributing:

- Open a GitHub Discussion
- Check the [documentation](docs/)
- Review existing issues and pull requests

---

Thank you for helping make Claude Code Plugins better!
