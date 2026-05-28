---
type: synthesis
status: draft
created: 2026-05-28
tags: [synthesis, agent-role, policy, multi-agent]
---

# Agent Role Policy 2026-05-28

## Policy Statement

The [[Project - Agentic Knowledge Vault]] adopts a three-tier agent role permission model to balance collaboration safety with editing efficiency.

## Role Tiers

### Maintainer
- **Default assignment**: Codex
- **Permissions**: Full read/write on all vault files, including:
  - Protocol files (`AGENTS.md`, `CLAUDE.md`, `HERMES.md`, `OPENCLAW.md`, `OPENCODE.md`)
  - Shell scripts (`05_tools/`)
  - Sync configuration (`07_sync/`)
  - Directory structure and organizational conventions
- **Responsibility**: Review and approve structural changes, maintain cross-agent consistency

### Editor
- **Default assignment**: Claude Code, Hermes
- **Permissions**: Create and update content within the existing structure:
  - Wiki pages (`02_wiki/`)
  - Source notes (`02_wiki/source-notes/`)
  - Questions, syntheses, concept pages
  - Index and log
- **Restrictions**: Must not modify directory structure, sync scripts, protocol files, or `05_tools/` unless explicitly authorized

### Reader
- **Default assignment**: Future agents not yet confirmed stable
- **Permissions**: Read all vault files, answer questions from existing knowledge
- **Restrictions**: No write access of any kind
- **Upgrade path**: After a confirmed stable period, may be promoted to editor by a maintainer or by human decision

## Safety Rules (All Tiers)

- Before bulk edits: check `06_agent_state/locks/` for active locks
- If no existing lock covers the intended edit area: create a descriptive lock file
- After edits complete: write a run note to `06_agent_state/runs/`
- Do not edit files protected by another agent's active lock

## Related

- [[Concept - Multi-Agent Vault Protocol]]
- [[Project - Agentic Knowledge Vault]]
- [[Source - Agent Role Policy Test 2026-05-28]]

## Uncertainties

- This policy is a draft (test document). Formal adoption requires human confirmation.
- Upgrade criteria for reader → editor are not yet defined.
- The boundary between "structural" and "content" edits may need clarification in practice.
