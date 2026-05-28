---
type: question
status: active
updated: 2026-05-28
tags: [question, workflow, conversation-capture]
---

# Automatic Conversation Capture

## Current Answer

The vault supports protocol-level automatic conversation capture.

For every meaningful agent session in this vault, the agent should capture a concise summary before finishing unless the human explicitly says not to.

## What Gets Captured

- architecture or design decisions
- setup or deployment changes
- workflows and operating rules
- source ingest or knowledge synthesis
- debugging outcomes
- agent integration decisions
- future-facing user preferences

## What Does Not Get Captured

- secrets or credentials
- verbatim transcripts by default
- trivial status checks
- off-record content

## Limits

This is not a background recorder. It only works when the agent has filesystem access to the vault and follows `AGENTS.md`.

External agents need to be given:

- the vault directory
- `04_prompts/agent-handoff.md`
- instruction to read `AGENTS.md`

## Related

- [[Conversation Capture Workflow]]
- [[Project - Agentic Knowledge Vault]]
- [[Concept - Multi-Agent Vault Protocol]]

