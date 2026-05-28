# Remote Mac Test Plan

## Required Access

To test on a remote Mac, provide one of these access methods:

1. SSH access:
   - host
   - username
   - SSH key or available agent forwarding
   - target vault path, for example `~/Documents/KnowledgeVault`

2. Shared filesystem access:
   - mounted path visible from this environment
   - target vault path

3. Remote desktop only:
   - Codex cannot directly operate the UI unless command-line or filesystem access is also available.
   - In this case, use this document as a manual checklist.

## Mac Test Steps

1. Copy or sync `KnowledgeVault/` to the Mac.
2. Open Obsidian.
3. Choose "Open folder as vault".
4. Select the copied `KnowledgeVault/` directory.
5. Confirm:
   - `00_inbox/` appears in the file explorer.
   - `02_wiki/index.md` opens.
   - Graph view works.
   - Templates plugin sees `04_templates/`.
   - New notes default to `00_inbox/`.
   - Attachments default to `01_raw/assets/`.
6. Edit a test note under `00_inbox/`.
7. Confirm the edit syncs back through WebDAV or the chosen transfer path.
8. If Git is enabled on Mac, confirm `.git/` is not synced through WebDAV.

## Plugin Installation Notes

Remote plugin installation is possible only if filesystem access to the Mac vault is available.

Obsidian community plugins are installed under:

```text
<Vault>/.obsidian/plugins/<plugin-id>/
```

Typical files:

```text
manifest.json
main.js
styles.css
```

After copying plugin files, the plugin usually still needs to be enabled in Obsidian settings, or by editing `.obsidian/community-plugins.json`. Because plugin IDs and release files can change, verify the plugin source before installing.

Recommended early policy:

- Do not auto-install many plugins at once.
- Start with core plugins and WebDAV sync only.
- Add Dataview after the vault structure is stable.
- Add any AI plugin only after confirming it will not upload private directories.

## WebDAV Test Steps

1. Configure WebDAV on Mac.
2. Sync this vault.
3. Configure the same WebDAV account on Windows.
4. Verify a small edit travels both ways.
5. Add Linux server sync last, initially read-only if possible.
6. Record any conflicts in `07_sync/conflict-log.md`.

