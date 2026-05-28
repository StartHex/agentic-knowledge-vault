---
type: project
status: active
updated: 2026-05-28
tags: [project, knowledge-base, obsidian, codex]
---

# Project - Agentic Knowledge Vault

## Summary

[[Project - Agentic Knowledge Vault]] is a Markdown-first personal knowledge base designed for Obsidian, Codex, and future local AI agents such as Claude Code, Hermes, OpenClaw, and OpenCode.

## Architecture

- `01_raw/` stores immutable raw sources.
- `02_wiki/` stores synthesized knowledge.
- `03_outputs/` stores generated deliverables.
- `04_prompts/` stores reusable workflows and prompts.
- `05_tools/` stores local scripts.
- `06_agent_state/` stores locks, run notes, and decisions.
- `07_sync/` stores sync policy and conflict notes.

## Integrations

- GitHub repository: `StartHex/agentic-knowledge-vault`.
- WebDAV sync path: `agentic-knowledge-vault`.
- Mac deployment path: `/Users/shx/Documents/Obsidian Vault/agentic-knowledge-vault`.
- Obsidian visual access on Mac.

## Agent Protocol

- Shared protocol: `AGENTS.md`.
- Claude Code adapter: `CLAUDE.md`.
- Hermes adapter: `HERMES.md`.
- OpenClaw adapter: `OPENCLAW.md`.
- OpenCode adapter: `OPENCODE.md`.

## Related

- [[Concept - Headless Agent Mode]]
- [[Concept - Multi-Agent Vault Protocol]]
- [[Conversation Capture Workflow]]
- [[How Should Agent Changes Be Synchronized]]
- [[Source - Conversation - Agentic Knowledge Vault Setup 2026-05-28]]

## Next Steps

- Confirm Claude Code, Hermes, OpenClaw, and OpenCode installation on Mac.
- Decide whether conversation capture should be manual or automatic.
- Test daily WebDAV workflow on Mac and Windows.

## Operating Preferences

- After repository changes, sync GitHub, WebDAV, and the Mac deployment, not GitHub alone.
