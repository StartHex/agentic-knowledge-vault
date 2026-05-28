---
type: question
status: active
updated: 2026-05-28
tags: [question, workflow, conversation-capture]
---

# Conversation Capture Workflow

## Current Answer

Agent conversations are not automatically stored in the knowledge base. They become knowledge only when explicitly captured as sources.

The capture workflow is:

1. Treat the conversation as a source.
2. Remove secrets and credentials.
3. Create a source note under `02_wiki/source-notes/`.
4. Update relevant project, concept, question, or synthesis pages.
5. Update `02_wiki/index.md`.
6. Append `02_wiki/log.md`.

## Evidence

- [[Source - Conversation - Agentic Knowledge Vault Setup 2026-05-28]]

## Related

- [[Project - Agentic Knowledge Vault]]
- [[Concept - Multi-Agent Vault Protocol]]

