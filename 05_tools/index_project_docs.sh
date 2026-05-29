#!/usr/bin/env bash
set -euo pipefail

project_root="$(pwd -P)"
index_file="02_wiki/projects/Project Documentation Index.md"
manifest_file="03_outputs/reports/project-docs-manifest.tsv"

if [[ -f .webdav.env ]]; then
  # shellcheck disable=SC1091
  source .webdav.env
fi

if [[ -f .mac.env ]]; then
  # shellcheck disable=SC1091
  source .mac.env
fi

if [[ -f .sync.env ]]; then
  # shellcheck disable=SC1091
  source .sync.env
fi

mkdir -p "$(dirname "$index_file")" "$(dirname "$manifest_file")"

mtime_iso() {
  local path="$1"
  local epoch

  if epoch="$(stat -c %Y "$path" 2>/dev/null)"; then
    date -u -d "@$epoch" +%Y-%m-%dT%H:%M:%SZ
  else
    epoch="$(stat -f %m "$path")"
    date -u -r "$epoch" +%Y-%m-%dT%H:%M:%SZ
  fi
}

file_size() {
  local path="$1"

  stat -c %s "$path" 2>/dev/null || stat -f %z "$path"
}

file_hash() {
  local path="$1"

  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$path" | awk '{print $1}'
  else
    shasum -a 256 "$path" | awk '{print $1}'
  fi
}

first_heading() {
  local path="$1"
  local heading

  heading="$(awk '/^# / {sub(/^# /, ""); print; exit}' "$path")"
  if [[ -n "$heading" ]]; then
    printf '%s' "$heading"
  else
    basename "$path"
  fi
}

collect_files() {
  {
    find . -maxdepth 1 -type f \( -name '*.md' -o -name 'README*' \) -print
    find docs 01_raw/project-docs 01_raw/external-projects 04_prompts 04_templates 05_tools 07_sync -type f \
      \( -name '*.md' -o -name '*.sh' -o -name '*.example' \) -print 2>/dev/null || true
  } |
    sed 's#^\./##' |
    sort -u
}

tmp_manifest="$(mktemp)"
trap 'rm -f "$tmp_manifest"' EXIT

{
  printf 'relative_path\tabsolute_path\tmodified_at\tsize_bytes\tsha256\ttitle\n'
  while IFS= read -r path; do
    [[ -f "$path" ]] || continue
    printf '%s\t%s/%s\t%s\t%s\t%s\t%s\n' \
      "$path" \
      "$project_root" \
      "$path" \
      "$(mtime_iso "$path")" \
      "$(file_size "$path")" \
      "$(file_hash "$path")" \
      "$(first_heading "$path")"
  done < <(collect_files)
} > "$tmp_manifest"

cp "$tmp_manifest" "$manifest_file"

index_updated_at="$(tail -n +2 "$tmp_manifest" | cut -f3 | sort | tail -1)"
if [[ -z "$index_updated_at" ]]; then
  index_updated_at="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
fi

git_remote="$(git remote get-url origin 2>/dev/null || true)"
mac_target=""
if [[ -n "${MAC_SSH_USER:-}" && -n "${MAC_SSH_HOST:-}" && -n "${MAC_VAULT_PATH:-}" ]]; then
  mac_target="$MAC_SSH_USER@$MAC_SSH_HOST:$MAC_VAULT_PATH"
fi

{
  cat <<EOF
---
type: project-index
status: generated
updated: $index_updated_at
tags: [project, documentation, generated-index]
---

# Project Documentation Index

## Summary

This generated index makes project documentation searchable from the knowledge base. It records environment paths, relative document paths, modified times, sizes, hashes, and detected titles.

## Project Paths

\`\`\`text
Generated from: $project_root
Git remote: ${git_remote:-not configured}
WebDAV URL: ${WEBDAV_URL:-not configured}
Mac vault: ${mac_target:-not configured}
\`\`\`

## Index State

Latest indexed document modification time: $index_updated_at

## Update Rule

Run:

\`\`\`bash
05_tools/index_project_docs.sh
\`\`\`

If the project directory moves, rerun the script from the new repository root. \`05_tools/sync_all.sh\` can also run this automatically when \`DOC_INDEX_ENABLED=true\`.

## Manifest

- Report: \`03_outputs/reports/project-docs-manifest.tsv\`

## Documents

| Relative Path | Modified At | Size | SHA256 | Title |
|---|---:|---:|---|---|
EOF

  tail -n +2 "$tmp_manifest" |
    while IFS=$'\t' read -r relative_path absolute_path modified_at size_bytes sha256 title; do
      short_hash="${sha256:0:12}"
      escaped_title="${title//|/\\|}"
      printf '| `%s` | %s | %s | `%s` | %s |\n' "$relative_path" "$modified_at" "$size_bytes" "$short_hash" "$escaped_title"
    done

  cat <<EOF

## Related

- [[Project - Agentic Knowledge Vault]]
- [[How Should Agent Changes Be Synchronized]]
EOF
} > "$index_file"

echo "$index_file"
echo "$manifest_file"
