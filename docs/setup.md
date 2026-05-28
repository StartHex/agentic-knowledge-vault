# Setup Guide

## 1. Local Linux Agent Environment

This repository can be maintained without Obsidian installed.

Useful commands:

```bash
05_tools/kb_search.sh "<query>"
05_tools/lint_links.sh
05_tools/export_context.sh "<topic>"
```

## 2. Mac Obsidian Setup

1. Clone or sync this repository to the Mac.
2. Open Obsidian.
3. Select "Open folder as vault".
4. Choose the vault directory.
5. Confirm:
   - new notes go to `00_inbox/`
   - attachments go to `01_raw/assets/`
   - templates use `04_templates/`
   - `02_wiki/index.md` opens
   - graph view works

Recommended Mac role:

- primary human editing device
- primary Obsidian configuration device
- visual review and graph exploration

## 3. Windows Obsidian Setup

1. Sync or clone the same vault.
2. Open it as an Obsidian vault.
3. Use Windows mainly for reading, clipping, and light editing.
4. Avoid bulk renames on Windows.
5. Avoid filenames containing:

```text
< > : " / \ | ? *
```

Also avoid trailing spaces and trailing dots in filenames.

## 4. WebDAV Setup

Recommended model:

```text
Mac local vault <-> WebDAV <-> Windows local vault
                         ^
                         |
                  Linux server sync
```

Rules:

- WebDAV syncs vault files.
- Git manages history and rollback.
- Do not sync `.git/` through WebDAV.
- If your WebDAV client cannot exclude `.git/`, keep Git outside the synced folder or use Linux snapshots.

## 5. Linux Server Setup

The Linux server should start as a read-only or low-risk maintenance node.

Recommended first tasks:

- pull/sync WebDAV content
- run `05_tools/lint_links.sh`
- create Git snapshots
- generate weekly reports

Only enable bulk agent edits after Mac/Windows/WebDAV sync is stable.

## 6. Remote Mac Access

If remote testing is needed, provide:

```text
ssh username@10.106.106.5
target vault path, for example ~/Documents/KnowledgeVault
```

With SSH access, agent-side work can copy files, update Obsidian config, and install plugin files. Visual UI testing still requires manual review or a GUI automation channel.

