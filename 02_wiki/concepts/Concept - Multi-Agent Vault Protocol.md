---
type: concept
status: active
updated: 2026-05-28
tags: [concept, multi-agent, protocol, agent-role]
---

# Concept - Multi-Agent Vault Protocol

## Summary

The multi-agent vault protocol defines how Codex, Claude Code, Hermes, OpenClaw, OpenCode, and future agents should read, edit, and maintain the same knowledge base without diverging rules.

## Key Points

- `AGENTS.md` is the shared source of truth.
- Agent-specific files delegate back to `AGENTS.md`.
- Agents follow a three-tier role permission model: maintainer, editor, reader.
- Bulk edits require lock files under `06_agent_state/locks/`.
- Completed runs should write notes under `06_agent_state/runs/`.

## Agent Role Tiers

### Maintainer
- **Codex** (default)
- Full permissions on all vault files: protocol, scripts, sync, and directory structure.
- Responsible for structural integrity and cross-agent consistency.

### Editor
- **Claude Code**, **Hermes** (default)
- Can create and update wiki content: pages, source notes, questions, syntheses, index, log.
- Must not modify directory structure, sync scripts, protocol files, or `05_tools/` by default.

### Reader
- **Future agents** (default until confirmed stable)
- Read-only access. May answer questions from existing vault content.
- Upgraded to editor by maintainer or human decision after a stable period.

### Safety Rules (All Tiers)
- Check `06_agent_state/locks/` before bulk edits.
- Create a descriptive lock file if no existing lock covers the intended edit area.
- After edits, write a run note to `06_agent_state/runs/`.

## Related

- [[Project - Agentic Knowledge Vault]]
- [[Concept - Headless Agent Mode]]
- [[Conversation Capture Workflow]]
- [[Agent Role Policy 2026-05-28]]

## Evidence

- [[Source - Conversation - Agentic Knowledge Vault Setup 2026-05-28]]
- [[Source - Agent Role Policy Test 2026-05-28]]

