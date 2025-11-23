# MCP Server Integration Guide

**Complete guide to Model Context Protocol (MCP) server integration with Claude Code Plugins**

---

## Table of Contents

1. [Overview](#overview)
2. [Quick Start](#quick-start)
3. [MCP Servers](#mcp-servers)
   - [Sequential Thinking](#1-sequential-thinking-built-in)
   - [Serena](#2-serena-semantic-code-understanding)
   - [Context7](#3-context7-documentation-access)
   - [Chrome DevTools](#4-chrome-devtools-browser-automation)
   - [FireCrawl](#5-firecrawl-web-content-extraction)
4. [Installation](#installation)
5. [Configuration](#configuration)
6. [Troubleshooting](#troubleshooting)
7. [Performance](#performance)
8. [Best Practices](#best-practices)

---

## Overview

### What is MCP?

**Model Context Protocol (MCP)** is a standard protocol for connecting AI assistants to external tools and data sources. MCP servers provide specialized capabilities that enhance Claude Code's functionality.

### Graceful Degradation Philosophy

**All Claude Code Plugins work without MCP** - MCP servers provide enhanced features but are **never required**:

- ✅ **Without MCP**: Core functionality always available
- ⚡ **With MCP**: Enhanced performance and capabilities
- 🔄 **Automatic fallback**: Commands detect MCP availability and adapt

### Benefits of MCP Integration

| Feature | Without MCP | With MCP | Improvement |
|---------|-------------|----------|-------------|
| Code operations | File reading + grep | Semantic search (Serena) | 70-90% fewer tokens |
| Documentation | Web search | Real-time access (Context7) | 50%+ faster |
| Complex analysis | Standard reasoning | Structured thinking (Sequential) | 20-30% better quality |
| Web research | Basic fetch | Enhanced extraction (FireCrawl) | 3-5x faster |
| Browser testing | Manual | Automated (Chrome DevTools) | Full automation |

---

## Quick Start

### Do I Need MCP?

**You can use Claude Code Plugins immediately without MCP.**

Consider installing MCP servers if you:

- ✅ Work with large codebases (>10K LOC) → Install **Serena**
- ✅ Frequently look up library documentation → Install **Context7**
- ✅ Debug complex multi-step problems → Use **Sequential Thinking** (built-in)
- ✅ Test web applications → Install **Chrome DevTools**
- ✅ Research and gather web content → Install **FireCrawl**

### Installation Priority

**Recommended installation order** (by impact):

1. **Sequential Thinking** - Already included, no setup needed ✅
2. **Serena** - Biggest performance boost for code work (70-90% token reduction)
3. **Context7** - Fast documentation access (50%+ time savings)
4. **Chrome DevTools** - Web automation and testing
5. **FireCrawl** - Web research and content extraction

---

## MCP Servers

### 1. Sequential Thinking (Built-in)

**Status**: ✅ Built-in to Claude Code (no installation required)

#### What It Does

Provides **structured reasoning** for complex analysis:

- Multi-step problem decomposition
- Systematic decision-making
- Edge case identification
- Trade-off evaluation

#### When It's Used

Automatically activated by commands requiring deep analysis:

- `/workflow:explore` - Requirements analysis
- `/workflow:plan` - Task breakdown with dependencies
- `/development:analyze` - Architectural analysis
- `/development:review --systematic` - Comprehensive code review

#### Example Usage

```bash
# Sequential Thinking activates automatically during exploration
/workflow:explore "Add user authentication"

# Claude will use structured reasoning to:
# 1. Analyze requirements systematically
# 2. Identify dependencies and integration points
# 3. Consider edge cases and failure modes
# 4. Propose implementation approach
```

#### Performance Impact

- **Tokens**: +15-30% (more detailed reasoning)
- **Quality**: +20-30% (better analysis)
- **Time**: Similar (parallel processing)

#### Configuration

None required - works out of the box.

---

### 2. Serena (Semantic Code Understanding)

**Status**: ⚠️ Optional, requires per-project setup

#### What It Does

Provides **semantic code understanding** instead of text-based search:

- **Symbol-level navigation**: Find classes, functions, variables by name
- **Type flow analysis**: Understand type relationships
- **Dependency tracking**: Map code dependencies semantically
- **API verification**: Validate method signatures before code generation

#### Key Benefits

| Operation | Without Serena | With Serena | Token Reduction |
|-----------|----------------|-------------|-----------------|
| Find class definition | Grep entire codebase | Direct symbol lookup | 90% |
| Understand API | Read multiple files | Get exact signatures | 80% |
| Trace dependencies | Manual file reading | Semantic graph | 75% |
| Refactoring impact | Guess and verify | Precise analysis | 85% |

**Average**: 70-90% token reduction for code-heavy tasks

#### Installation

```bash
# Install Serena MCP server globally
npm install -g @context7/serena-mcp

# Or with npx (no global install)
npx @context7/serena-mcp --version
```

#### Per-Project Setup

**Serena requires activation in each project**:

```bash
# Navigate to your project
cd ~/my-project

# Activate Serena for this project
/agents:serena

# What happens:
# 1. Indexes your codebase semantically
# 2. Creates .serena/ directory with index
# 3. Enables semantic code operations
```

#### Verification

```bash
# Check if Serena is active
/agents:serena --status

# Expected output:
# ✅ Serena MCP: Active
# 📊 Indexed: 1,234 symbols
# 📁 Project: /path/to/project
```

#### When It's Used

Automatically activated for code operations:

- `/development:analyze` - Semantic codebase analysis
- `/development:review` - Symbol-level code review
- `/development:fix` - API verification before fixes
- All file reading when working with code

#### Example Usage

```bash
# Without Serena: Grep search across all files
# With Serena: Direct symbol lookup

# Find a class definition
"Show me the User class implementation"
# Serena finds symbol directly (no file scanning)

# Understand method signatures
"What are the parameters for authenticate()?"
# Serena returns exact signature with types

# Trace dependencies
"What calls the process_payment() function?"
# Serena maps dependency graph semantically
```

#### Troubleshooting

**Issue**: "Serena not found"

**Solution**: Activate Serena per-project:
```bash
cd /path/to/project
/agents:serena
```

**Issue**: "Outdated index"

**Solution**: Re-index after major code changes:
```bash
/agents:serena --reindex
```

**Issue**: "Serena slow on large project"

**Solution**: Index only relevant directories:
```bash
# Create .serena/config.json
{
  "include": ["src/", "lib/"],
  "exclude": ["node_modules/", "build/", "tests/"]
}
```

---

### 3. Context7 (Documentation Access)

**Status**: ⚠️ Optional, requires API key

#### What It Does

Provides **real-time library documentation access**:

- Latest API documentation for popular libraries
- Code examples and usage patterns
- Version-specific documentation
- Cached for offline access

#### Key Benefits

- **50%+ faster** than manual web search
- **Always current** - Real-time docs, not training data
- **Cached** - Works offline after first fetch
- **Accurate** - Official documentation sources

#### Installation

```bash
# Install Context7 MCP server globally
npm install -g @context7/context7-mcp

# Or with npx
npx @context7/context7-mcp --version
```

#### API Key Setup

1. **Get API Key**: Sign up at https://context7.com
2. **Set Environment Variable**:

```bash
# Add to ~/.bashrc or ~/.zshrc
export CONTEXT7_API_KEY="your_api_key_here"

# Or add to Claude Code settings
# ~/.claude/settings.json:
{
  "mcpServers": {
    "context7": {
      "env": {
        "CONTEXT7_API_KEY": "your_api_key_here"
      }
    }
  }
}
```

3. **Restart Claude Code** to load environment

#### Verification

```bash
# Test Context7 access
"Show me the latest FastAPI documentation"

# Expected output:
# ✅ Context7: Found docs for FastAPI v0.104.1
# [Documentation content...]
```

#### When It's Used

Automatically activated for documentation queries:

- `/development:docs search` - Search library documentation
- Any question about library APIs or usage
- Technology selection and comparison

#### Example Usage

```bash
# Look up library documentation
"How do I use React hooks?"
# Context7 fetches latest React docs

# Compare library versions
"What changed in Django 4.2?"
# Context7 retrieves version-specific changelog

# Find usage examples
"Show me FastAPI middleware examples"
# Context7 provides official code examples
```

#### Troubleshooting

**Issue**: "Context7 API key not found"

**Solution**: Set API key in environment or settings (see above)

**Issue**: "Library documentation not found"

**Solution**: Context7 supports popular libraries. For uncommon libraries, falls back to web search.

**Issue**: "Rate limit exceeded"

**Solution**: Context7 has usage limits. Check https://context7.com/pricing for plan details.

---

### 4. Chrome DevTools (Browser Automation)

**Status**: ⚠️ Optional, requires Chrome and MCP server

#### What It Does

Provides **comprehensive browser automation and debugging**:

- **26 specialized tools** for web development
- **Puppeteer-based** automation with Chrome DevTools Protocol
- **Performance analysis** with Core Web Vitals
- **Network debugging** with request inspection
- **Console monitoring** for errors and warnings
- **Device emulation** for responsive testing

#### Key Capabilities

**Navigation & Interaction**:
- Page navigation and history management
- Element clicking, hovering, form filling
- File uploads and downloads
- Screenshot capture (viewport and full-page)

**Performance Analysis**:
- Performance traces with AI-powered insights
- Core Web Vitals (LCP, FID, CLS)
- Network timing and waterfall analysis
- Resource loading bottlenecks

**Debugging**:
- Console message capture (errors, warnings, logs)
- Network request inspection
- CORS debugging
- Element inspection

**Testing**:
- CPU throttling simulation
- Network condition emulation (3G, 4G, offline)
- Device/viewport resizing
- Automated test scenarios

#### Installation

```bash
# Install Chrome DevTools MCP server
npm install -g @modelcontextprotocol/server-puppeteer

# Or with npx
npx @modelcontextprotocol/server-puppeteer --version
```

**Prerequisites**:
- Google Chrome or Chromium browser installed
- Chromium automatically downloaded if not present

#### Configuration

Add to `~/.claude/settings.json`:

```json
{
  "mcpServers": {
    "puppeteer": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-puppeteer"]
    }
  }
}
```

#### Verification

```bash
# Test browser automation
"Navigate to https://example.com and take a screenshot"

# Expected output:
# ✅ Chrome DevTools: Page loaded
# ✅ Screenshot captured
# [Screenshot displayed]
```

#### When It's Used

Available for web development and testing:

- Web application testing and debugging
- Performance analysis and optimization
- Automated UI testing
- Cross-browser compatibility checks

#### Example Usage

```bash
# Navigate and interact
"Go to https://my-app.com/login and fill the form with test credentials"

# Performance analysis
"Analyze the performance of https://my-app.com and identify bottlenecks"

# Network debugging
"Check the network requests when loading https://my-app.com/api/data"

# Responsive testing
"Test https://my-app.com on mobile viewport (375x667)"
```

#### Known Limitations

**Screenshot Bug**: The Chrome DevTools MCP has a known issue with full-page screenshots exceeding 8000px height. Use these alternatives:

- **Viewport screenshots only** (safe, no height limit)
- **JPEG format** with quality parameter (reduces size)
- **Element screenshots** with `uid` parameter (targets specific elements)
- **Text snapshots** via `take_snapshot()` (preferred for debugging)

```bash
# Safe alternatives to full-page screenshots:
"Take a text snapshot of the page"  # Preferred for debugging
"Take a viewport screenshot"         # Safe, no height limit
"Take a screenshot in JPEG format"   # Smaller file size
```

#### Troubleshooting

**Issue**: "Chrome not found"

**Solution**: Install Google Chrome or Chromium:
```bash
# Ubuntu/Debian
sudo apt install chromium-browser

# macOS
brew install --cask google-chrome
```

**Issue**: "Screenshot height exceeds limit"

**Solution**: Use text snapshots or viewport-only screenshots (see limitations above)

**Issue**: "Puppeteer timeout"

**Solution**: Increase timeout or check network connectivity:
```bash
# Set longer timeout
"Navigate to https://slow-site.com with 60 second timeout"
```

---

### 5. FireCrawl (Web Content Extraction)

**Status**: ⚠️ Optional, requires API key

#### What It Does

Provides **intelligent web content extraction**:

- **Smart scraping**: Extracts main content, removes boilerplate
- **Search integration**: Find relevant pages across the web
- **Caching**: Fast repeated access to same URLs
- **Markdown conversion**: Clean, readable output

#### Key Benefits

- **3-5x faster** than manual research
- **Clean extraction**: No ads, navigation, or clutter
- **Cached results**: 15-minute cache for fast re-access
- **Bulk operations**: Crawl multiple pages efficiently

#### Installation

```bash
# Install FireCrawl MCP server
npm install -g @firecrawl/mcp-server

# Or with npx
npx @firecrawl/mcp-server --version
```

#### API Key Setup

1. **Get API Key**: Sign up at https://firecrawl.dev
2. **Set Environment Variable**:

```bash
# Add to ~/.bashrc or ~/.zshrc
export FIRECRAWL_API_KEY="your_api_key_here"

# Or add to Claude Code settings
{
  "mcpServers": {
    "firecrawl": {
      "env": {
        "FIRECRAWL_API_KEY": "your_api_key_here"
      }
    }
  }
}
```

#### Verification

```bash
# Test FireCrawl
"Search the web for recent articles about React Server Components"

# Expected output:
# ✅ FireCrawl: Found 10 results
# [Clean markdown extracts...]
```

#### When It's Used

Automatically activated for web research:

- Gathering information from multiple sources
- Extracting documentation from websites
- Research and competitive analysis
- Content aggregation

#### Example Usage

```bash
# Extract clean content
"Scrape https://blog.example.com/article and summarize"
# FireCrawl returns clean markdown without clutter

# Web search
"Search for best practices for PostgreSQL indexing"
# FireCrawl searches and extracts relevant content

# Bulk research
"Find and summarize top 5 articles about GraphQL performance"
# FireCrawl crawls multiple pages efficiently
```

#### Troubleshooting

**Issue**: "FireCrawl API key not found"

**Solution**: Set API key in environment or settings (see above)

**Issue**: "Rate limit exceeded"

**Solution**: FireCrawl has usage limits. Check https://firecrawl.dev/pricing

**Issue**: "Content extraction incomplete"

**Solution**: Some sites block scrapers. FireCrawl does best-effort extraction.

---

## Installation

### Global Installation (Recommended)

Install all MCP servers globally for use across projects:

```bash
# Sequential Thinking: Already included in Claude Code ✅

# Serena (Semantic Code Understanding)
npm install -g @context7/serena-mcp

# Context7 (Documentation Access)
npm install -g @context7/context7-mcp

# Chrome DevTools (Browser Automation)
npm install -g @modelcontextprotocol/server-puppeteer

# FireCrawl (Web Content Extraction)
npm install -g @firecrawl/mcp-server
```

### Per-Project Installation

For project-specific MCP servers (less common):

```bash
cd ~/my-project

# Install as dev dependencies
npm install --save-dev @context7/serena-mcp

# Configure in project .claude/settings.json
```

### Verification

Check which MCP servers are available:

```bash
# Method 1: Ask Claude directly
"Which MCP servers are currently available?"

# Expected output:
# ✅ Sequential Thinking (built-in)
# ✅ Serena (semantic code)
# ✅ Context7 (documentation)
# ✅ Chrome DevTools (browser)
# ✅ FireCrawl (web research)

# Method 2: Check Claude Code doctor
claude doctor

# Look for MCP section in output
```

---

## Configuration

### Claude Code Settings

Configure MCP servers in `~/.claude/settings.json`:

```json
{
  "mcpServers": {
    "serena": {
      "command": "npx",
      "args": ["-y", "@context7/serena-mcp"]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@context7/context7-mcp"],
      "env": {
        "CONTEXT7_API_KEY": "your_api_key_here"
      }
    },
    "puppeteer": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-puppeteer"]
    },
    "firecrawl": {
      "command": "npx",
      "args": ["-y", "@firecrawl/mcp-server"],
      "env": {
        "FIRECRAWL_API_KEY": "your_api_key_here"
      }
    }
  }
}
```

### Environment Variables

Recommended approach for API keys:

```bash
# Add to ~/.bashrc or ~/.zshrc
export CONTEXT7_API_KEY="your_context7_key"
export FIRECRAWL_API_KEY="your_firecrawl_key"

# Then reload
source ~/.bashrc  # or source ~/.zshrc
```

### Project-Specific Settings

Override global settings per-project in `.claude/settings.json`:

```json
{
  "mcpServers": {
    "serena": {
      "enabled": true,
      "include": ["src/", "lib/"],
      "exclude": ["node_modules/", "build/"]
    }
  }
}
```

---

## Troubleshooting

### General MCP Issues

#### MCP Server Not Found

**Symptoms**: "MCP server X not available" or silent fallback

**Diagnosis**:
```bash
# Check if server is installed
npm list -g @context7/serena-mcp

# Check Claude Code settings
cat ~/.claude/settings.json | grep -A 5 mcpServers

# Test server directly
npx @context7/serena-mcp --version
```

**Solutions**:
1. Install the MCP server globally (see [Installation](#installation))
2. Verify settings.json configuration
3. Restart Claude Code after installation

#### API Key Issues

**Symptoms**: "API key not found" or "Unauthorized"

**Diagnosis**:
```bash
# Check environment variables
echo $CONTEXT7_API_KEY
echo $FIRECRAWL_API_KEY

# Check settings.json
cat ~/.claude/settings.json | grep -A 10 "env"
```

**Solutions**:
1. Set environment variables correctly
2. Add API keys to settings.json `env` section
3. Restart terminal/Claude Code after setting variables
4. Verify API key is valid (check provider dashboard)

#### Performance Issues

**Symptoms**: Slow MCP responses or timeouts

**Diagnosis**:
```bash
# Check network connectivity
ping context7.com
ping firecrawl.dev

# Check MCP server logs (if available)
# Logs location varies by MCP server
```

**Solutions**:
1. Check internet connection
2. Verify API rate limits not exceeded
3. Clear caches (Context7, FireCrawl)
4. Update MCP servers to latest versions:
   ```bash
   npm update -g @context7/serena-mcp
   npm update -g @context7/context7-mcp
   # etc.
   ```

### Server-Specific Issues

#### Serena Issues

**Problem**: "Serena not active in this project"

**Solution**: Run `/agents:serena` in project directory

**Problem**: "Stale index"

**Solution**: Re-index project:
```bash
/agents:serena --reindex
```

**Problem**: "Serena slow on large codebase"

**Solution**: Exclude unnecessary directories in `.serena/config.json`

#### Context7 Issues

**Problem**: "Library documentation not found"

**Solution**: Context7 supports ~1000 popular libraries. Fallback to web search for uncommon libraries.

**Problem**: "Outdated documentation"

**Solution**: Context7 caches docs. Clear cache or wait for automatic update (24 hours).

#### Chrome DevTools Issues

**Problem**: "Browser not launching"

**Solution**: Install Chrome/Chromium (see [Chrome DevTools Installation](#4-chrome-devtools-browser-automation))

**Problem**: "Screenshot height error"

**Solution**: Use viewport screenshots or text snapshots instead of full-page (see [Known Limitations](#known-limitations))

#### FireCrawl Issues

**Problem**: "Content blocked by site"

**Solution**: Some sites block scrapers. FireCrawl does best-effort extraction, but may not work on all sites.

**Problem**: "Rate limit exceeded"

**Solution**: Check FireCrawl plan limits at https://firecrawl.dev/pricing

---

## Performance

### Token Usage Impact

| MCP Server | Token Change | Quality Change | Use Case |
|------------|--------------|----------------|----------|
| Sequential Thinking | +15-30% | +20-30% | Complex analysis |
| Serena | -70-90% | Same | Code operations |
| Context7 | -50% | +10% | Documentation |
| Chrome DevTools | Varies | N/A | Browser tasks |
| FireCrawl | -40% | +15% | Web research |

### Performance Tips

**Maximize Serena Benefits**:
- Use for all code reading operations
- Activate per-project for best performance
- Keep index updated after major changes

**Optimize Context7 Usage**:
- Cache hits are near-instant
- First fetch may be 2-5 seconds
- Use for frequently-referenced libraries

**Efficient Chrome DevTools**:
- Viewport screenshots are faster than full-page
- Text snapshots are faster than screenshots
- Batch operations when possible

**FireCrawl Best Practices**:
- Cache hits avoid API calls
- Bulk operations are more efficient
- Search before scrape (faster)

---

## Best Practices

### When to Use Each MCP Server

**Sequential Thinking** (Automatic):
- ✅ Complex architectural decisions
- ✅ Multi-step problem analysis
- ✅ Trade-off evaluation
- ❌ Simple, straightforward tasks

**Serena** (Code-heavy work):
- ✅ Large codebases (>5K LOC)
- ✅ Frequent refactoring
- ✅ API exploration and discovery
- ❌ Small scripts or config files

**Context7** (Documentation lookup):
- ✅ Learning new libraries
- ✅ API reference needs
- ✅ Version-specific behavior
- ❌ Custom/internal libraries

**Chrome DevTools** (Web development):
- ✅ UI/UX testing
- ✅ Performance optimization
- ✅ Cross-browser debugging
- ❌ Backend-only projects

**FireCrawl** (Research):
- ✅ Competitive analysis
- ✅ Content aggregation
- ✅ Multiple source synthesis
- ❌ Single, simple web page

### Cost Management

**Free Tiers**:
- Sequential Thinking: Free (built-in)
- Serena: Free (local processing)
- Context7: Free tier available
- Chrome DevTools: Free (local)
- FireCrawl: Free tier available

**Paid Considerations**:
- Context7: Check https://context7.com/pricing
- FireCrawl: Check https://firecrawl.dev/pricing

**Cost Optimization**:
1. Use Serena to reduce token usage (saves money on Claude API calls)
2. Leverage caching (Context7, FireCrawl)
3. Only activate needed MCP servers per-project
4. Monitor usage through provider dashboards

### Security Considerations

**API Key Management**:
- ✅ Use environment variables, not hardcoded keys
- ✅ Add API keys to `.gitignore` if in files
- ✅ Rotate keys regularly
- ✅ Use separate keys for testing/production
- ❌ Never commit API keys to git
- ❌ Don't share API keys in screenshots/logs

**Data Privacy**:
- **Serena**: Local processing, no data leaves your machine ✅
- **Sequential Thinking**: Built-in, no external calls ✅
- **Context7**: Sends library names to API (no code) ⚠️
- **FireCrawl**: Sends URLs to API (no sensitive data) ⚠️
- **Chrome DevTools**: Local browser, no external calls ✅

**Network Security**:
- MCP servers with APIs use HTTPS encryption
- Verify provider security policies
- Use VPN for sensitive research (FireCrawl)

---

## Summary

### Quick Reference

| MCP Server | Setup Complexity | Impact | Required? |
|------------|------------------|--------|-----------|
| Sequential Thinking | None (built-in) | Medium-High | No (automatic) |
| Serena | Medium (per-project) | Very High | No (high value for code) |
| Context7 | Low (API key) | Medium | No (helpful for docs) |
| Chrome DevTools | Low (install) | High (web dev) | No (niche use case) |
| FireCrawl | Low (API key) | Medium | No (research tasks) |

### Getting Started Checklist

- [ ] **Sequential Thinking**: Already available ✅
- [ ] **Serena**: Install globally, activate per-project
- [ ] **Context7**: Install, get API key, set environment variable
- [ ] **Chrome DevTools**: Install, verify Chrome is available
- [ ] **FireCrawl**: Install, get API key, set environment variable
- [ ] **Settings**: Configure `~/.claude/settings.json` with MCP servers
- [ ] **Verify**: Test each MCP server with a simple command
- [ ] **Documentation**: Bookmark this guide for troubleshooting

---

## Support

### Getting Help

- **MCP Protocol**: https://modelcontextprotocol.io
- **Serena**: https://github.com/context7-labs/serena-mcp
- **Context7**: https://context7.com/docs
- **Chrome DevTools MCP**: https://github.com/modelcontextprotocol/servers
- **FireCrawl**: https://firecrawl.dev/docs
- **Claude Code**: https://docs.claude.com/claude-code

### Reporting Issues

**For Claude Code Plugins**:
- GitHub Issues: https://github.com/applied-artificial-intelligence/claude-code-toolkit/issues

**For MCP Servers**:
- Report to respective MCP server repositories (see links above)

---

**Last Updated**: 2025-10-26

**Version**: 1.0.0

**Feedback**: Help us improve this guide by reporting issues or suggesting improvements!
