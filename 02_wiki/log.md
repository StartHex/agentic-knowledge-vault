# Knowledge Base Log

## 2026-05-28

- Initialized vault structure and agent protocol.
- Captured the initial setup conversation as [[Source - Conversation - Agentic Knowledge Vault Setup 2026-05-28]] and added [[Conversation Capture Workflow]].
- Added [[Automatic Conversation Capture]] as the default policy for meaningful agent sessions.
- Added the operating preference that repository changes should sync to GitHub, WebDAV, and Mac together.
- Fixed WebDAV upload exclusions so local environment files are not uploaded.
- Hermes 接入知识库（[[hermes-vault-setup-2026-05-28]]）: 清理旧 memory-os 系统，新建 agentic-knowledge-vault 技能，确认工作规则。
- Reviewed the Hermes auto-capture test and pulled the Mac-side result back into Git-managed history.
- Ingested [[Source - Agent Role Policy Test 2026-05-28]]: defined three-tier agent role policy (maintainer/editor/reader) with specific agent assignments. Updated [[Concept - Multi-Agent Vault Protocol]] and created [[Agent Role Policy 2026-05-28]] as a synthesis page.
- Reviewed the Claude Code ingest test and pulled the Mac-side result back into Git-managed history.
- Codex self-tested query/synthesis workflow by creating [[How Should Agent Changes Be Synchronized]] and recording `06_agent_state/runs/2026-05-28-codex-sync-query-self-test.md`.
- Made sync explicitly configurable with `.sync.env`; missing config disables sync and missing interval defaults to 7200 seconds.

## 2026-05-29

- Added UTF-8 normalization tooling for Markdown/text ingest, documented the encoding rule in AGENTS and ingest usage, and verified imported `github-devpor` documents are UTF-8.
- Added generated [[Project Documentation Index]] so project docs, paths, modified times, hashes, and current project root are searchable.
- Added [[How Should Project Documentation Be Indexed]] to document move handling, indexing limits, and remaining gaps.
- Added Windows compatibility checks, LF line-ending rules, and Windows setup documentation.
- Added [[How Should I Search the Knowledge Base]] with practical keywords for Obsidian and command-line search.
- Added [[How Should I Add Material to the Knowledge Base]] with source ingest, question search, and copywriting workflows.
- Imported `github-devpor` project documentation into [[Project - github-devpor]] and [[Source - github-devpor Project Documents]] after confirming it was missing from the knowledge base.
