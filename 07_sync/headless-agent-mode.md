# Headless Agent Mode

Codex and other command-line agents do not need Obsidian installed locally.

## Principle

The vault is a plain Markdown repository. Obsidian is a visual editor and knowledge browser, not the storage engine.

Agents can safely operate in a headless Linux environment as long as they follow:

- `AGENTS.md`
- directory boundaries
- Markdown file conventions
- Obsidian `[[wikilink]]` syntax
- frontmatter conventions
- Git/WebDAV sync rules

## What Works Without Obsidian

- Read and write Markdown notes.
- Search the knowledge base with `rg`.
- Create source notes, concept pages, question pages, and syntheses.
- Maintain `02_wiki/index.md`.
- Maintain backlinks using `[[Page Name]]`.
- Run lint scripts.
- Export context packs for other agents.
- Commit Git snapshots.

## What Requires Obsidian UI

- Visual graph review.
- Canvas editing.
- Plugin settings through the UI.
- Manual visual inspection of rendered Markdown.
- Human review of layout, themes, and reading experience.

## Query Impact

Headless operation does not reduce knowledge query quality if:

- pages are well linked
- `02_wiki/index.md` is maintained
- source notes cite raw sources
- filenames remain stable
- frontmatter is consistent

For agent queries, Markdown files are the source of truth. Obsidian only improves human navigation and visual review.

## Remote Mac Access

Network checks show that if SSH credentials are available, this environment can reach a Mac and manipulate vault files remotely.

Required:

```text
ssh username@10.106.106.5
target vault path, for example ~/Documents/KnowledgeVault
```

With SSH access, Codex can:

- copy the vault to the Mac
- update Obsidian configuration files
- install plugin files into `.obsidian/plugins/`
- edit `.obsidian/community-plugins.json`
- run file-level validation

Codex cannot visually operate Obsidian unless a separate GUI automation or remote desktop channel is provided.

