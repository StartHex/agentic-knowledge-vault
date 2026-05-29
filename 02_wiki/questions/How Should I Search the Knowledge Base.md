---
type: question
status: active
updated: 2026-05-29
tags: [question, search, retrieval, usage]
---

# How Should I Search the Knowledge Base

## Current Answer

Start with stable nouns, project names, workflow names, agent names, and directory names. The vault is optimized for Markdown search, Obsidian backlinks, and command-line `rg`.

## High-Value Search Keywords

Project:

- `Agentic Knowledge Vault`
- `KnowledgeVault`
- `Project - Agentic Knowledge Vault`
- `个人知识库`
- `Obsidian`

Agents:

- `Codex`
- `Claude Code`
- `Hermes`
- `OpenClaw`
- `OpenCode`
- `agent handoff`
- `multi-agent`
- `reader`
- `editor`
- `maintainer`

Workflows:

- `ingest workflow`
- `query workflow`
- `lint workflow`
- `conversation capture`
- `auto-capture`
- `source note`
- `run note`
- `lock`
- `sync_all`

Sync:

- `WebDAV`
- `GitHub`
- `Mac vault`
- `Windows compatibility`
- `sync daemon`
- `SYNC_ENABLED`
- `SYNC_INTERVAL_SECONDS`
- `Project Documentation Index`

Directories:

- `00_inbox`
- `01_raw`
- `02_wiki`
- `03_outputs`
- `04_prompts`
- `05_tools`
- `06_agent_state`
- `07_sync`

Documents:

- `AGENTS.md`
- `CLAUDE.md`
- `HERMES.md`
- `OPENCLAW.md`
- `README.md`
- `docs/design.md`
- `docs/setup.md`
- `docs/validation.md`

## Search Commands

Command-line search:

```bash
05_tools/kb_search.sh "WebDAV"
05_tools/kb_search.sh "auto-capture"
05_tools/kb_search.sh "Project Documentation Index"
```

Fast direct search:

```bash
rg -n "Hermes|Claude Code|sync_all|WebDAV" .
```

## Obsidian Search Tips

- Search exact page names like `Project Documentation Index`.
- Search concepts with `Concept -`.
- Search questions with `How Should`.
- Search source notes with `Source -`.
- Use graph view from anchor pages such as [[Project - Agentic Knowledge Vault]].

## Related

- [[Project - Agentic Knowledge Vault]]
- [[Project Documentation Index]]
- [[How Should Project Documentation Be Indexed]]
- [[How Should Agent Changes Be Synchronized]]

