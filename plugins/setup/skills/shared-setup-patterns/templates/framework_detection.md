# Framework Detection Patterns

This document provides detection patterns for identifying project languages, frameworks, and tools.

## Language Detection

### Python
**Detection files**:
- `pyproject.toml`
- `setup.py`
- `requirements.txt`

**Version detection**:
```bash
python3 --version 2>&1 | cut -d' ' -f2 | cut -d'.' -f1,2
```

### JavaScript/TypeScript
**Detection files**:
- `package.json`
- `package-lock.json`

**Frameworks**:
- Next.js: `grep -q '"next"' package.json`
- React: `grep -q '"react"' package.json`
- Express: `grep -q '"express"' package.json`

### Go
**Detection files**:
- `go.mod`

**Test tool**: `go test`

### Rust
**Detection files**:
- `Cargo.toml`

**Test tool**: `cargo test`

## Framework Detection Patterns

### Python Frameworks

**FastAPI**:
```bash
grep -q 'fastapi' pyproject.toml
```

**Django**:
```bash
grep -q 'django' pyproject.toml
```

**Flask**:
```bash
grep -q 'flask' pyproject.toml
```

### JavaScript Frameworks

**Next.js**:
```bash
grep -q '"next"' package.json
```

**React**:
```bash
grep -q '"react"' package.json
```

**Express**:
```bash
grep -q '"express"' package.json
```

## Test Tool Detection

### Python Testing

**pytest**:
```bash
grep -q 'pytest' pyproject.toml
```

### JavaScript Testing

**Jest**:
```bash
grep -q '"jest"' package.json
```

**Mocha**:
```bash
grep -q '"mocha"' package.json
```

## Build System Detection

### Python

**Makefile**:
```bash
[ -f "Makefile" ] && DETECTED_BUILD="Make"
```

### Detection Algorithm

```bash
# Language detection
DETECTED_LANG=""
DETECTED_FRAMEWORK=""
DETECTED_TEST_TOOL=""
DETECTED_BUILD=""

if [ -f "package.json" ]; then
    DETECTED_LANG="JavaScript/TypeScript"
    # Check frameworks and tools
elif [ -f "pyproject.toml" ] || [ -f "setup.py" ] || [ -f "requirements.txt" ]; then
    DETECTED_LANG="Python"
    # Check frameworks and tools
elif [ -f "go.mod" ]; then
    DETECTED_LANG="Go"
    DETECTED_TEST_TOOL="go test"
elif [ -f "Cargo.toml" ]; then
    DETECTED_LANG="Rust"
    DETECTED_TEST_TOOL="cargo test"
fi
```

## Usage in Commands

Commands should use these patterns to auto-detect project characteristics and provide appropriate setup configurations.

Example:
```bash
# Auto-detect project type
if [ -f "package.json" ]; then
    SETUP_TYPE="javascript"
elif [ -f "pyproject.toml" ]; then
    SETUP_TYPE="python"
fi
```
