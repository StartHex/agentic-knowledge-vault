---
type: source-note
source_type: agent-conversation
created: 2026-05-28
tags: [source, conversation, agent-role, multi-agent]
---

# Source - Agent Role Policy Test 2026-05-28

## Summary

This source note records a test policy document ingested on 2026-05-28. The document defines a tiered agent role permission model for the [[Project - Agentic Knowledge Vault]]: maintainer, editor, and reader tiers with specific agent-to-role mappings.

## Key Decisions

- Codex is the default maintainer agent — owns protocol files, scripts, sync workflows, and directory structure.
- Claude Code and Hermes are default editor agents — can create and update wiki pages, source notes, questions, syntheses, index, and log, but should not modify directory structure, sync scripts, or protocol files by default.
- Future agents default as reader agents — read and answer only; upgrade to editor only after confirmed stable.
- All agents must check `06_agent_state/locks/` before bulk edits, create a lock when needed, and write a run note to `06_agent_state/runs/` after completion.

## Links Created

- [[Concept - Multi-Agent Vault Protocol]]
- [[Project - Agentic Knowledge Vault]]
- [[Agent Role Policy 2026-05-28]]

## Reliability Notes

- This note captures a test policy document, not a finalized decision.
- No credentials or secrets are included.
