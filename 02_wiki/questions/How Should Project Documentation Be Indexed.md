---
type: question
status: active
updated: 2026-05-29
tags: [question, documentation, indexing, project-path]
---

# How Should Project Documentation Be Indexed

## Current Answer

Project documentation should stay in its working location and be indexed into the knowledge layer.

The generated page [[Project Documentation Index]] records:

- current project root
- relative document path
- absolute document path in the manifest
- modified time
- file size
- SHA256 hash
- detected document title

The TSV manifest is written to:

```text
03_outputs/reports/project-docs-manifest.tsv
```

## Move Handling

Directory moves can be handled by rerunning:

```bash
05_tools/index_project_docs.sh
```

Because the script computes the project root from the current working directory, the generated index will reflect the new path after a move.

If `.sync.env` has `DOC_INDEX_ENABLED=true`, `05_tools/sync_all.sh` runs the indexer before syncing. If `05_tools/sync_daemon.sh` is running, the path will be refreshed on the next scheduled sync interval.

## Limits

This is not an OS-level file watcher. It updates when one of these runs:

- `05_tools/index_project_docs.sh`
- `05_tools/sync_all.sh`
- `05_tools/sync_daemon.sh`
- another agent explicitly follows the documentation indexing workflow

The current index covers project-local documentation and tools. It does not automatically index unrelated projects outside the vault unless their paths are added to the scanner.

## Potential Gaps

- Rename detection is hash/path based, not semantic.
- Deleted files disappear from the next generated index but are still recoverable from Git history.
- Git commit history per file is not yet included in the manifest.
- External projects need explicit include rules.
- Large binary docs are not indexed; only selected text/script files are included.

## Related

- [[Project Documentation Index]]
- [[Project - Agentic Knowledge Vault]]
- [[How Should Agent Changes Be Synchronized]]

