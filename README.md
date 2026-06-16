# KnowledgeVault

Personal knowledge base powered by Obsidian, Markdown, Git, and AI agents.

## Goals

- Keep raw sources immutable under `01_raw/`.
- Maintain synthesized knowledge under `02_wiki/`.
- Use `AGENTS.md` as the shared protocol for Codex and other agents.
- Use WebDAV for cross-device file sync and Git for history, review, and recovery.

## Docs

- [Design](docs/design.md)
- [Setup Guide](docs/setup.md)
- [Validation Guide](docs/validation.md)
- [Agent Integration](docs/agent-integration.md)
- [Mac Test Plan](07_sync/mac-test-plan.md)
- [Headless Agent Mode](07_sync/headless-agent-mode.md)

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

Run the AI news and creator inspiration workflow into this vault:

```bash
05_tools/ai_news_daily.sh --date today
05_tools/sync_all.sh
```

`05_tools/ai_news_daily.sh` uses `~/AINewsTutorialSys` as the collector/processor engine, writes AI handbook pages under `02_wiki/`, and mirrors generated reports under `03_outputs/ai-news/`. Cross-device sync remains owned by the vault-level `05_tools/sync_all.sh`; the AI news workflow disables its own Mac/WebDAV sync when run through the vault wrapper.

## Repository Policy

- Keep raw sources in `01_raw/`.
- Keep synthesized knowledge in `02_wiki/`.
- Keep reusable outputs in `03_outputs/`.
- Use `AGENTS.md` as the agent contract.
- Do not sync `.git/` through WebDAV.
