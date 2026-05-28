---
type: question
status: active
updated: 2026-05-28
tags: [question, sync, multi-agent, codex-self-test]
---

# How Should Agent Changes Be Synchronized

## Current Answer

Agent changes should be synchronized through a three-target workflow:

1. GitHub for version history and review.
2. WebDAV for cross-device file distribution.
3. Mac deployment for Obsidian visual review and local agent access.

Codex should use `05_tools/sync_all.sh` after repository changes so the three targets stay aligned.

Sync is explicitly configurable. If `.sync.env` is missing or `SYNC_ENABLED` is not `true`, sync should not run. If `SYNC_INTERVAL_SECONDS` is missing, scheduled sync defaults to 7200 seconds.

## Operating Rule

Do not treat GitHub push as sufficient. A completed maintainer change should end with:

```bash
05_tools/sync_all.sh
```

This pushes Git, uploads to WebDAV, and deploys the working tree to the configured Mac vault path.

For scheduled sync:

```bash
05_tools/sync_daemon.sh
```

## Agent Implications

- Codex is responsible for final synchronization after maintainer-level changes.
- Claude Code and Hermes may create Mac-side changes, but Codex should pull those changes back into Git-managed history after review.
- Future agents should not be promoted beyond reader/editor until their sync behavior is tested.

## Failure Modes

- A change exists on GitHub but is missing from Mac.
- A Mac-side agent writes useful content that never gets pulled into Git.
- WebDAV contains stale or incomplete files.
- Local environment files accidentally sync to WebDAV.
- Sync runs unexpectedly because defaults are unclear.

## Related

- [[Project - Agentic Knowledge Vault]]
- [[Concept - Multi-Agent Vault Protocol]]
- [[Automatic Conversation Capture]]
