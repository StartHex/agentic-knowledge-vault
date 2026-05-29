---
type: question
status: active
updated: 2026-05-29
tags: [question, ingest, usage, workflow]
---

# How Should I Add Material to the Knowledge Base

## Current Answer

Use `00_inbox/` as the entry point for new material. Ask an agent to process it with the ingest workflow. Keep raw sources traceable and write synthesized knowledge into `02_wiki/`.

## Add a New Source

Put the material under:

```text
00_inbox/
```

Then ask:

```text
请处理 00_inbox/<file>，按 AGENTS.md 的 ingest workflow 更新知识库。保留原始资料路径，创建 source note，更新相关 concept/question/synthesis/index/log，不要保存敏感信息。
```

Expected outputs:

- `02_wiki/source-notes/`
- relevant `02_wiki/concepts/`
- relevant `02_wiki/questions/` or `02_wiki/syntheses/`
- `02_wiki/index.md`
- `02_wiki/log.md`
- `06_agent_state/runs/`

## Ask the Knowledge Base a Question

Use:

```text
请基于知识库回答：<你的问题>。先查 02_wiki/index.md，再查相关 wiki 页面，必要时回查 01_raw/。如果答案有长期价值，请沉淀到 questions/ 或 syntheses/。
```

## Add Copywriting or Drafts

If it is raw copy, notes, or a pasted draft, start with:

```text
00_inbox/
```

If it is a final deliverable, store it under:

```text
03_outputs/
```

Suggested mapping:

- raw pasted copy: `00_inbox/`
- reusable writing ideas: `02_wiki/concepts/` or `02_wiki/syntheses/`
- answered content question: `02_wiki/questions/`
- final essay/report/plan: `03_outputs/essays/`, `03_outputs/reports/`, or `03_outputs/plans/`

## Prompt for Copywriting

```text
这是一段文案/草稿，请按 ingest workflow 处理进知识库：

<粘贴内容>

要求：
- 不要只总结，要判断它属于 source、concept、question、synthesis 还是 output。
- 如果是可复用观点，沉淀到 02_wiki/。
- 如果是最终稿，放入 03_outputs/。
- 更新 index 和 log。
```

## Search Before Adding

Before adding duplicate material:

```bash
05_tools/kb_search.sh "<关键词>"
```

Useful keywords:

- project name
- person name
- product name
- problem name
- `source note`
- `synthesis`
- `copywriting`
- `draft`

## Related

- [[How Should I Search the Knowledge Base]]
- [[Project Documentation Index]]
- [[Conversation Capture Workflow]]
- [[Project - Agentic Knowledge Vault]]

