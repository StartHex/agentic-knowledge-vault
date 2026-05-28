# Personal Knowledge Base Agent Protocol

## Roles

- Human owns source selection, priorities, and final judgment.
- Agent owns wiki maintenance, linking, summaries, contradiction tracking, and logs.

## Directory Rules

- Never modify `01_raw/`.
- Treat `00_inbox/` as unprocessed input.
- Write synthesized knowledge only under `02_wiki/`.
- Put generated deliverables under `03_outputs/`.
- Store reusable prompts under `04_prompts/`.
- Store scripts under `05_tools/`.
- Store agent coordination state under `06_agent_state/`.
- Store sync decisions and conflict notes under `07_sync/`.
- Update `02_wiki/index.md` after every meaningful edit.
- Append to `02_wiki/log.md` after every ingest, query, lint, or major rewrite.

## Ingest Workflow

1. Read the new source from `00_inbox/` or `01_raw/`.
2. If the source is in `00_inbox/`, copy or move the durable original into the right `01_raw/` subdirectory only when the human asks or the task explicitly includes archiving.
3. Create or update one source note under `02_wiki/source-notes/`.
4. Update relevant concept, person, project, domain, question, or synthesis pages.
5. Add backlinks using Obsidian `[[Page Name]]` syntax.
6. Record contradictions, weak evidence, and uncertainty explicitly.
7. Update `02_wiki/index.md`.
8. Append one log entry to `02_wiki/log.md`.

## Query Workflow

1. Search `02_wiki/index.md` first.
2. Read relevant wiki pages.
3. Use raw sources only when verification is needed.
4. Answer with links to wiki pages and source notes.
5. If the answer is reusable, create or update a page under `02_wiki/questions/` or `02_wiki/syntheses/`.

## Lint Workflow

Check for:

- orphan pages
- stale claims
- missing backlinks
- duplicated concepts
- unresolved contradictions
- pages without source references
- inconsistent frontmatter
- broken raw source paths

## Multi-Agent Safety

- Do not delete pages without human confirmation.
- Do not rewrite large areas without first summarizing the intended change.
- Prefer small, reviewable changes.
- If source evidence is weak, mark the claim as uncertain.
- Before bulk edits, create a lock file under `06_agent_state/locks/`.
- After bulk edits, write a run note under `06_agent_state/runs/`.
- Do not edit files if another active lock covers the same area.

## Sync Safety

- Do not assume WebDAV conflict files are safe to delete.
- Do not modify `.git/` through WebDAV.
- If sync conflict files appear, generate a merge recommendation first.
- Avoid filenames that are invalid on Windows: `< > : " / \ | ? *`.
- Avoid filenames with trailing spaces or trailing dots.

