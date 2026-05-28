---
type: source-note
source_type: agent-conversation
created: 2026-05-28
source_url:
tags: [source, conversation, agentic-knowledge-vault]
---

# Source - Conversation - Agentic Knowledge Vault Setup 2026-05-28

## Summary

This source note captures the setup conversation for [[Project - Agentic Knowledge Vault]]. The conversation covered the initial design of a Codex + Obsidian personal knowledge base, multi-agent integration, GitHub setup, WebDAV deployment, Mac deployment, and handoff prompts for Claude Code, Hermes, OpenClaw, and OpenCode.

Sensitive credentials shared during setup are intentionally not recorded here.

## Key Decisions

- The repository is named `agentic-knowledge-vault`.
- The vault is Markdown-first and Obsidian-compatible.
- Codex maintains the vault headlessly from Linux.
- Obsidian on Mac and Windows is used for visual browsing, graph review, and manual editing.
- GitHub is used for version history and review.
- WebDAV is used for cross-device file distribution.
- The Mac vault deployment path is `/Users/shx/Documents/Obsidian Vault/agentic-knowledge-vault`.
- `AGENTS.md` is the shared protocol for all agents.
- `CLAUDE.md`, `HERMES.md`, `OPENCLAW.md`, and `OPENCODE.md` adapt specific agents back to the shared protocol.
- Agent conversations are not automatically captured; they need an explicit [[Conversation Capture Workflow]].

## Completed Work

- Created the local vault structure.
- Initialized Git and pushed to GitHub.
- Added setup, validation, sync, and agent integration documentation.
- Added WebDAV deployment scripts that read credentials from local `.webdav.env`.
- Uploaded the vault to WebDAV.
- Deployed the vault to the Mac.
- Verified Obsidian is running on the Mac.
- Added reusable handoff prompts for local agents.

## Open Questions

- Whether Claude Code, Hermes, OpenClaw, or OpenCode are installed on the Mac shell path.
- Whether Mac and Windows should use WebDAV plugin sync, desktop sync, Git clone, or a hybrid model for daily use.
- Whether conversation capture should happen manually on demand or automatically after meaningful sessions.

## Links Created

- [[Project - Agentic Knowledge Vault]]
- [[Concept - Headless Agent Mode]]
- [[Concept - Multi-Agent Vault Protocol]]
- [[Conversation Capture Workflow]]

## Reliability Notes

- This note summarizes the project conversation and operational state as of 2026-05-28.
- It intentionally omits secrets and credentials.

