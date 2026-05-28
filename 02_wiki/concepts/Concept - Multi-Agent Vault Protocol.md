---
type: concept
status: active
updated: 2026-05-28
tags: [concept, multi-agent, protocol]
---

# Concept - Multi-Agent Vault Protocol

## Summary

The multi-agent vault protocol defines how Codex, Claude Code, Hermes, OpenClaw, OpenCode, and future agents should read, edit, and maintain the same knowledge base without diverging rules.

## Key Points

- `AGENTS.md` is the shared source of truth.
- Agent-specific files delegate back to `AGENTS.md`.
- Agents should default to reader/editor mode unless explicitly promoted to maintainer mode.
- Bulk edits require lock files under `06_agent_state/locks/`.
- Completed runs should write notes under `06_agent_state/runs/`.

## Related

- [[Project - Agentic Knowledge Vault]]
- [[Concept - Headless Agent Mode]]
- [[Conversation Capture Workflow]]

## Evidence

- [[Source - Conversation - Agentic Knowledge Vault Setup 2026-05-28]]

