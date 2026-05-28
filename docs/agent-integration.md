# Agent Integration

## Current Vault-Side Integration

The vault exposes these agent entry files:

- `AGENTS.md` for Codex and shared protocol.
- `CLAUDE.md` for Claude Code.
- `HERMES.md` for Hermes.
- `OPENCLAW.md` for OpenClaw.
- `OPENCODE.md` for OpenCode-compatible workflows.

All agent-specific files delegate to `AGENTS.md` to avoid divergent rules.

## Mac Command Pattern

Run agents from the vault root:

```bash
cd "/Users/shx/Documents/Obsidian Vault/agentic-knowledge-vault"
```

Claude Code:

```bash
claude
```

Hermes:

```bash
hermes
```

OpenClaw:

```bash
openclaw
```

If the command is unavailable, install the tool first or fix the shell `PATH`.

## Recommended First Prompt

Use the reusable handoff prompt:

```text
04_prompts/agent-handoff.md
```

Short version:

```text
Read AGENTS.md and 02_wiki/index.md first. Operate as an editor agent. Do not delete pages. Before bulk edits, create a lock under 06_agent_state/locks/. After the task, update 02_wiki/log.md and write a run note under 06_agent_state/runs/.
```

## Directory vs Skill

Start with the directory and handoff prompt.

Give the agent this directory:

```text
/Users/shx/Documents/Obsidian Vault/agentic-knowledge-vault
```

Then ask it to read `AGENTS.md` and its adapter file.

A skill is useful later, after the workflow is stable and you want the same behavior across many unrelated projects. For this vault, the repo itself already contains the operating protocol, so a separate skill is optional rather than required.

## Role Defaults

Reader:

- answer questions
- search wiki
- do not edit files

Editor:

- create and update wiki pages
- update index and log
- create source notes
- create run notes

Maintainer:

- change protocols
- change templates
- change directory layout
- add scripts

Only Codex should default to maintainer mode for now. Claude Code, Hermes, OpenClaw, and OpenCode should start as reader/editor agents unless explicitly promoted.

## Multi-Agent Locking

Before bulk edits:

```bash
mkdir -p 06_agent_state/locks
cat > 06_agent_state/locks/YYYY-MM-DD-agent-task.lock <<'LOCK'
# Active Agent Task

- Device:
- Agent:
- Task:
- Started:
- Expected files:
LOCK
```

After completion:

1. Write a run note under `06_agent_state/runs/`.
2. Update `02_wiki/log.md`.
3. Remove the lock.
4. Review the diff.

## Current Mac Status

The vault is deployed at:

```text
/Users/shx/Documents/Obsidian Vault/agentic-knowledge-vault
```

If `claude`, `hermes`, or `openclaw` are not found over SSH, verify installation in an interactive Mac terminal:

```bash
command -v claude
command -v hermes
command -v openclaw
```
