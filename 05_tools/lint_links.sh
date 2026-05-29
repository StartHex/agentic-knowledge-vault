#!/usr/bin/env bash
set -euo pipefail

echo "Pages without wiki links:"
find 02_wiki -type f -name '*.md' -print0 |
  while IFS= read -r -d '' file; do
    if ! rg -q '\[\[[^]]+\]\]' "$file"; then
      echo "- $file"
    fi
  done

echo
echo "Potential Windows-incompatible filenames:"
05_tools/check_windows_compat.sh

echo
echo "Non-UTF-8 Markdown/text files:"
if 05_tools/normalize_markdown_encoding.sh --check \
  00_inbox 01_raw 02_wiki 03_outputs 04_prompts 04_templates 05_tools 07_sync >/tmp/kb-encoding-check.$$; then
  echo "none"
else
  cat /tmp/kb-encoding-check.$$
  rm -f /tmp/kb-encoding-check.$$
  exit 1
fi
rm -f /tmp/kb-encoding-check.$$
