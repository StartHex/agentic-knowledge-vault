# KnowledgeVault

Personal knowledge base powered by Obsidian, Markdown, Git, and AI agents.

## Goals

- Keep raw sources immutable under `01_raw/`.
- Maintain synthesized knowledge under `02_wiki/`.
- Use `AGENTS.md` as the shared protocol for Codex and other agents.
- Use WebDAV for cross-device file sync and Git for history, review, and recovery.

## First Commands

Ingest a source:

```text
处理 00_inbox/<file>，按 AGENTS.md 的 ingest workflow 更新知识库。
```

Answer and persist a reusable question:

```text
基于 02_wiki 回答这个问题；如果答案有长期价值，写入 questions/。
```

Run maintenance:

```text
对 02_wiki 做一次 lint，找重复、孤立、冲突和缺失链接。
```

