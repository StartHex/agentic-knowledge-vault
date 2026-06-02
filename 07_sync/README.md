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
cp 07_sync/sync.env.example .sync.env
cp 07_sync/webdav.env.example .webdav.env
```

Prefer `.sync.env` for new setups. Legacy `.webdav.env` and `.mac.env` still work as supporting local files, but `05_tools/sync_all.sh` will not sync unless `SYNC_ENABLED=true`.

Local env files are ignored by Git and must not be committed.

## Built-In Scripts

```bash
05_tools/sync_all.sh
05_tools/sync_daemon.sh
05_tools/webdav_list.sh
05_tools/webdav_push.sh
```

These scripts are simple `curl` wrappers. They are useful for initial deployment and server-side automation, but they are not a full conflict-aware bidirectional sync engine.

Requirements:

- `curl`
- `jq`

## Linux WebDAV Auto Push

For a headless Linux server that should only push this vault to WebDAV, install the user-level systemd units:

```bash
mkdir -p ~/.config/systemd/user
cp 07_sync/systemd/knowledgevault-webdav-sync.* ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now knowledgevault-webdav-sync.timer
loginctl enable-linger "$USER"
```

Check status with:

```bash
systemctl --user list-timers knowledgevault-webdav-sync.timer
systemctl --user status knowledgevault-webdav-sync.service
```

This timer runs `05_tools/webdav_push.sh` every 10 minutes. It does not run Git sync or direct Mac SSH sync.

## Mac Sync

Use:

```bash
cp 07_sync/mac.env.example .mac.env
```

Then fill `.mac.env` locally. The file is ignored by Git and must not be committed.

`05_tools/sync_all.sh` is the preferred command after repository changes. It pushes Git, uploads WebDAV, and deploys the working tree to the configured Mac vault path.

## Config Defaults

- Missing `.sync.env`: no sync.
- `SYNC_ENABLED` missing or not `true`: no sync.
- `SYNC_INTERVAL_SECONDS` missing: `7200` seconds.
- `WEBDAV_SYNC_ENABLED=false`: skip WebDAV.
- `MAC_SYNC_ENABLED=false`: skip Mac.
- `GIT_SYNC_ENABLED=false`: skip Git push.
