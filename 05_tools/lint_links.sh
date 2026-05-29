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
