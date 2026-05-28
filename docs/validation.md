# Validation Guide

## Local Checks

Run from the repository root:

```bash
bash -n 05_tools/*.sh
05_tools/lint_links.sh
git status --short --branch
```

Expected for a fresh vault:

- shell scripts pass syntax checks
- `index.md` and `log.md` may initially have no wiki links
- working tree is clean after commit

## Sync Checks

After configuring WebDAV:

1. Create a small test note under `00_inbox/`.
2. Confirm it appears on Mac, Windows, and Linux.
3. Edit it on Mac.
4. Confirm Linux sees the edit.
5. Edit it on Windows only after Mac sync has completed.
6. Record any conflict in `07_sync/conflict-log.md`.

For the built-in WebDAV scripts:

```bash
command -v curl
command -v jq
cp 07_sync/webdav.env.example .webdav.env
$EDITOR .webdav.env
bash -n 05_tools/webdav_*.sh
05_tools/webdav_list.sh
```

Use `05_tools/webdav_push.sh` only when the local Linux copy should overwrite matching files on WebDAV.

## Obsidian Checks

On Mac or Windows:

- open `02_wiki/index.md`
- create a new note and verify it lands in `00_inbox/`
- paste an image and verify it lands in `01_raw/assets/`
- insert a template from `04_templates/`
- open graph view

## Agent Checks

Before bulk edits:

1. Check for active lock files under `06_agent_state/locks/`.
2. Create a new lock for the task.
3. Run the ingest, query, or lint workflow.
4. Update `02_wiki/index.md`.
5. Append to `02_wiki/log.md`.
6. Write a run note under `06_agent_state/runs/`.
7. Remove the lock.
8. Review `git diff`.
