# AI/ML Engineering Skills

**3 comprehensive skills for AI/ML engineering workflows**
**Created:** 2025-10-25
**Maintained by:** Applied Artificial Intelligence

---

## Overview

This collection provides deep, specialized expertise for AI/ML engineering tasks. These skills complement the Claude Code plugin framework by adding technology-specific knowledge that activates only when relevant.

**Key Principle**: Skills provide **specialized expertise** for **specific technologies**, not general workflows. They activate automatically when Claude detects relevant context.

---

## Available Skills

### 1. RAG Implementation (`rag-implementation/`)

**File**: `rag-implementation/SKILL.md` (860 lines, ~42KB)

**What it covers:**
- Vector database selection (Qdrant, Pinecone, Chroma, Weaviate, Milvus)
- Chunking strategies (fixed-size, semantic, hierarchical, sliding window)
- Embedding models (OpenAI, Sentence Transformers, Cohere)
- Retrieval optimization (hybrid search, query expansion, reranking)
- Context management and citation tracking
- Production patterns (caching, async processing, monitoring)

**When it activates:**
- Building RAG systems
- Implementing semantic search
- Working with vector databases
- Optimizing retrieval quality
- Debugging RAG performance

**Example triggers:**
```
"Build a RAG system for customer support docs"
"Implement semantic search with Qdrant"
"Optimize vector database retrieval"
"Debug hallucinations in RAG pipeline"
```

**Integrates with commands:**
- `/workflow:explore` - RAG system architecture
- `/workflow:plan` - RAG implementation tasks
- `/development:analyze` - RAG code review
- `/development:fix` - RAG performance issues

---

### 2. Hugging Face Transformers (`huggingface-transformers/`)

**File**: `huggingface-transformers/SKILL.md` (834 lines, ~43KB)

**What it covers:**
- Model loading patterns (basic, quantized, local, from config)
- Tokenization best practices (padding, truncation, special tokens)
- Fine-tuning workflows (Trainer API, LoRA, custom loops)
- Pipeline usage (classification, QA, generation, zero-shot)
- Inference optimization (batching, AMP, ONNX, quantization)
- Common issues (OOM errors, slow tokenization, attention masks)
- Model-specific patterns (GPT, T5, BERT)

**When it activates:**
- Working with transformer models
- Fine-tuning LLMs
- Implementing NLP tasks
- Optimizing inference
- Debugging tokenization or model loading

**Example triggers:**
```
"Fine-tune BERT for sentiment classification"
"Optimize LLaMA inference with quantization"
"Debug CUDA OOM error with transformers"
"Use Hugging Face pipeline for question answering"
```

**Integrates with commands:**
- `/development:test` - Test transformer models
- `/development:fix` - Debug transformer issues
- `/development:analyze` - Review transformer code
- `/workflow:plan` - Plan fine-tuning workflow

---

### 3. LLM Evaluation (`llm-evaluation/`)

**File**: `llm-evaluation/SKILL.md` (984 lines, ~47KB)

**What it covers:**
- Traditional metrics (ROUGE, BLEU, BERTScore, Perplexity)
- LLM-as-Judge evaluation (rubric scoring, pass/fail, A/B testing)
- Hallucination detection (grounding check, factuality, self-consistency)
- RAG-specific evaluation (retrieval metrics, end-to-end pipeline)
- Prompt testing frameworks (regression tests, A/B tests)
- Production monitoring (continuous evaluation, alerts)
- Best practices (layered evaluation, prompt versioning)

**When it activates:**
- Testing LLM applications
- Validating prompt quality
- Detecting hallucinations
- Creating evaluation benchmarks
- A/B testing prompts or models
- Implementing CI/CD for LLMs

**Example triggers:**
```
"Test LLM output quality"
"Detect hallucinations in RAG responses"
"Create evaluation benchmark for prompts"
"A/B test two prompt versions"
"Implement continuous LLM evaluation"
```

**Integrates with commands:**
- `/development:test` - Test LLM applications
- `/development:review` - Review LLM quality
- `/workflow:explore` - Plan evaluation strategy
- `/development:fix` - Debug LLM issues

---

## How Skills Work

### Progressive Disclosure

Skills use a two-tier loading system:

**Tier 1 - Startup** (Lightweight):
```markdown
# RAG Implementation Patterns

Comprehensive guide to implementing RAG systems...
Use when building RAG systems, implementing semantic search...
```
Only the skill description (first paragraph) is loaded at startup. Claude reads all skill metadata to know when each should be used.

**Tier 2 - Runtime** (Full Knowledge):
When Claude detects a RAG-related task, the full skill content loads (~42KB of deep expertise).

**Token Efficiency**:
- Startup: ~100 tokens per skill (300 tokens total for all 3)
- Runtime: ~8-12KB per skill (only when activated)
- Benefit: Unlimited expertise without context penalty

### Automatic Discovery

Skills activate automatically based on context detection:

```python
# User asks:
"/workflow:explore 'Build RAG system for docs'"

# Claude detects keywords:
# - "RAG"
# - "vector database"
# - "semantic search"

# Skill auto-loads:
# → rag-implementation skill activates
# → Provides vector DB selection guide
# → Suggests chunking strategies
# → Includes production patterns

# Result: Expert RAG architecture, not basic tutorial
```

---

## Integration with Plugins

### Workflow Enhancement

**Without Skill** (Plugin alone):
```bash
/workflow:plan "RAG system for customer support"

# Plugin creates standard workflow:
1. Research RAG approaches
2. Choose vector database
3. Implement chunking
4. Build retrieval
5. Create API

# Generic, lacks depth
```

**With Skill** (Plugin + Skill synergy):
```bash
/workflow:plan "RAG system for customer support"

# Plugin workflow executes
# RAG skill auto-loads during planning
# → Recommends Qdrant (self-hosted, production-ready)
# → Suggests semantic chunking (better for support docs)
# → Proposes hybrid search (keyword + semantic)
# → Includes citation tracking (critical for support)

# Generated plan:
1. Setup Qdrant with Docker (specific commands)
2. Implement semantic chunking pipeline (code examples)
3. Generate embeddings with text-embedding-3-small (cost/quality balance)
4. Build hybrid search API (sparse + dense)
5. Add citation system (track sources)
6. Create evaluation framework (measure accuracy)

# Production-grade, specific, actionable
```

### Command-Skill Mapping

| Command | Activates Skills | Benefit |
|---------|-----------------|---------|
| `/workflow:explore` | RAG, Transformers | Architecture guidance |
| `/workflow:plan` | All 3 | Detailed implementation plans |
| `/development:test` | LLM Evaluation, Transformers | Testing expertise |
| `/development:fix` | All 3 | Debugging assistance |
| `/development:review` | LLM Evaluation | Quality assessment |
| `/development:analyze` | Transformers, RAG | Code analysis |

---

## Installation

### Option 1: Copy to Claude Code Skills Directory

```bash
# Copy all skills
cp -r ~/applied-ai/claude-code-toolkit/skills/* ~/.claude/skills/

# Or copy individually
cp -r ~/applied-ai/claude-code-toolkit/skills/rag-implementation ~/.claude/skills/
cp -r ~/applied-ai/claude-code-toolkit/skills/huggingface-transformers ~/.claude/skills/
cp -r ~/applied-ai/claude-code-toolkit/skills/llm-evaluation ~/.claude/skills/
```

### Option 2: Symlink (For Development)

```bash
# Symlink entire skills directory
ln -s ~/applied-ai/claude-code-toolkit/skills ~/.claude/skills

# Or symlink individually
ln -s ~/applied-ai/claude-code-toolkit/skills/rag-implementation ~/.claude/skills/rag-implementation
ln -s ~/applied-ai/claude-code-toolkit/skills/huggingface-transformers ~/.claude/skills/huggingface-transformers
ln -s ~/applied-ai/claude-code-toolkit/skills/llm-evaluation ~/.claude/skills/llm-evaluation
```

### Verification

```bash
# Check skills installed
ls ~/.claude/skills/

# Should show:
# rag-implementation/
# huggingface-transformers/
# llm-evaluation/

# Verify skill files
cat ~/.claude/skills/rag-implementation/SKILL.md | head -5
```

---

## Demo Scenarios

### Scenario 1: RAG System Development

```bash
# User's task
"Build a RAG system for internal documentation search"

# Commands used
/workflow:explore "RAG for documentation search"
/workflow:plan
/development:next

# Skills activated
✅ rag-implementation (for architecture)
✅ llm-evaluation (for testing strategy)

# Result
- Qdrant-based vector DB (self-hosted)
- Semantic chunking (preserves doc structure)
- Hybrid search (keyword + semantic)
- Built-in evaluation framework
- Citation tracking system
```

### Scenario 2: Transformer Fine-Tuning

```bash
# User's task
"Fine-tune BERT for product review classification"

# Commands used
/workflow:plan "BERT fine-tuning"
/development:test "classification model"

# Skills activated
✅ huggingface-transformers (for fine-tuning)
✅ llm-evaluation (for testing)

# Result
- Correct tokenization (padding, truncation)
- Trainer API with proper config
- LoRA for parameter efficiency
- Evaluation metrics (accuracy, F1)
- ONNX export for production
```

### Scenario 3: LLM Application Testing

```bash
# User's task
"Create test suite for customer support chatbot"

# Commands used
/development:test "chatbot responses"
/development:review "LLM quality"

# Skills activated
✅ llm-evaluation (primary)
✅ rag-implementation (if RAG-based)

# Result
- Regression test suite
- Hallucination detection
- LLM-as-judge evaluation
- A/B testing framework
- Production monitoring
```

---

## Skill Metrics

| Skill | File Size | Lines | Sections | Code Examples | Decision Trees |
|-------|-----------|-------|----------|---------------|----------------|
| RAG Implementation | 42KB | 860 | 7 | 30+ | 3 |
| Transformers | 43KB | 834 | 8 | 40+ | 2 |
| LLM Evaluation | 47KB | 984 | 8 | 35+ | 2 |
| **Total** | **132KB** | **2,678** | **23** | **105+** | **7** |

---

## Why These Skills?

### 1. Technology-Specific (Not General)

❌ **Bad**: "Testing patterns" (too broad, should be in agent)
✅ **Good**: "LLM Evaluation" (specific to LLM apps)

❌ **Bad**: "Database optimization" (too general)
✅ **Good**: "RAG Implementation" (specific to vector DBs)

### 2. Subset of Use Cases (Not Always Needed)

Skills only activate when that specific technology is detected:
- RAG skill: Only for RAG/semantic search (not all AI work)
- Transformers skill: Only for Hugging Face code (not TensorFlow, JAX)
- Evaluation skill: Only for LLM testing (not traditional ML)

### 3. On-Brand (AI/ML Focus)

Aligns with Applied AI's domain expertise:
- RAG: Cutting-edge production AI pattern
- Transformers: Most popular ML framework
- LLM Evaluation: Emerging critical need

### 4. First-to-Market

**None of these skills exist on claudeskills.info yet!** This showcases:
- Thought leadership in AI/ML engineering
- Deep domain expertise
- Understanding of real production needs

---

## Best Practices

### For Skill Users

1. **Let skills activate automatically** - Don't force activation, Claude will load when needed
2. **Combine with plugins** - Skills enhance plugin workflows, don't replace them
3. **Provide context** - Mention specific technologies ("Qdrant", "BERT", "RAG") for better skill discovery
4. **Iterate based on output** - Skills adapt to your specific use case

### For Skill Developers

1. **Be technology-specific** - Target specific frameworks/tools
2. **Include decision trees** - Help users choose between options
3. **Provide working code** - Real examples, not pseudocode
4. **Document when NOT to use** - Clear boundaries
5. **Keep descriptions rich** - Better discovery through detailed metadata

---

## Future Skills (Roadmap)

Potential additions based on demand:

**Production ML:**
- PyTorch optimization (mixed precision, distributed training)
- MLflow experiment tracking
- Model deployment (ONNX, TensorRT, serving)

**Specialized Domains:**
- Computer vision (ViT, CLIP, Stable Diffusion)
- Time series forecasting (transformers, LSTM)
- Reinforcement learning (PPO, DQN)

**Tools & Frameworks:**
- LangChain patterns
- FastAPI serving optimization
- Kubernetes for ML workloads

---

## Contributing

To contribute new skills or improve existing ones:

1. **Follow skill template** - Use existing skills as reference
2. **Be specific** - Target concrete technologies/frameworks
3. **Include code examples** - Working, tested code
4. **Add decision trees** - Help users choose options
5. **Test with plugins** - Ensure smooth integration

---

## Resources

### Skills Framework
- **Claude Skills Hub**: https://claudeskills.info/
- **Skill Creator Guide**: https://claudeskills.info/skills/skill-creator

### Referenced Technologies
- **Qdrant**: https://qdrant.tech/
- **Pinecone**: https://www.pinecone.io/
- **Hugging Face**: https://huggingface.co/
- **OpenAI**: https://platform.openai.com/
- **LangChain**: https://python.langchain.com/

---

## License

MIT License - Free to use, modify, and distribute.

---

## Support

**Issues**: https://github.com/applied-artificial-intelligence/claude-code-toolkit/issues
**Discussions**: https://github.com/applied-artificial-intelligence/claude-code-toolkit/discussions

---

**Last Updated**: 2025-10-25
**Version**: 1.0.0
**Maintained by**: Applied Artificial Intelligence
