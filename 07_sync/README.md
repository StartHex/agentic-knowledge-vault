# Sync Design

This vault is designed for Mac, Windows, and Linux server deployment.

## Recommended Topology

```text
Mac Obsidian local vault
        <-> WebDAV
Windows Obsidian local vault
        <-> WebDAV
Linux server working copy
        <-> WebDAV
Linux server or Git remote
        <-> Git history
```

## Rules

- WebDAV syncs Markdown, attachments, and portable Obsidian config.
- Git manages history, review, rollback, and branches.
- Do not sync `.git/` through WebDAV.
- Linux server should start with read-only checks and Git snapshots.
- Bulk agent writes should create locks under `06_agent_state/locks/`.

## Local Credential File

Use:

```bash
cp 07_sync/webdav.env.example .webdav.env
```

Then fill `.webdav.env` locally. The file is ignored by Git and must not be committed.

## Built-In Scripts

```bash
05_tools/webdav_list.sh
05_tools/webdav_push.sh
```

These scripts are simple `curl` wrappers. They are useful for initial deployment and server-side automation, but they are not a full conflict-aware bidirectional sync engine.

Requirements:

- `curl`
- `jq`
