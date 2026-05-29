#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  05_tools/normalize_markdown_encoding.sh [--check] PATH...

Normalizes Markdown/text files to UTF-8.

Rules:
  - Valid UTF-8 files are left unchanged.
  - Non-UTF-8 files are converted from GB18030, which covers common GBK/GB2312
    project documents.
  - --check reports files that are not valid UTF-8 without modifying them.
EOF
}

check_only=false
if [[ "${1:-}" == "--check" ]]; then
  check_only=true
  shift
fi

if [[ "$#" -eq 0 ]]; then
  usage >&2
  exit 2
fi

status=0

python_normalize_file() {
  local file="$1"
  local mode="$2"

  python3 - "$file" "$mode" <<'PY'
import sys
from pathlib import Path

path = Path(sys.argv[1])
mode = sys.argv[2]
data = path.read_bytes()

try:
    data.decode("utf-8")
    print(f"utf8: {path}")
    raise SystemExit(0)
except UnicodeDecodeError:
    if mode == "check":
        print(f"non-utf8: {path}")
        raise SystemExit(1)

try:
    text = data.decode("gb18030")
except UnicodeDecodeError:
    print(f"unsupported-encoding: {path}", file=sys.stderr)
    raise SystemExit(1)

path.write_text(text, encoding="utf-8", newline="")
print(f"converted-gb18030-to-utf8: {path}")
PY
}

normalize_file() {
  local file="$1"
  local tmp

  if [[ ! -f "$file" ]]; then
    echo "missing: $file" >&2
    status=1
    return
  fi

  if command -v python3 >/dev/null 2>&1; then
    if python_normalize_file "$file" "$([[ "$check_only" == "true" ]] && echo check || echo convert)"; then
      return
    fi
    status=1
    return
  fi

  if iconv -f UTF-8 -t UTF-8 "$file" >/dev/null 2>&1; then
    echo "utf8: $file"
    return
  fi

  if [[ "$check_only" == "true" ]]; then
    echo "non-utf8: $file"
    status=1
    return
  fi

  tmp="$(mktemp)"
  if iconv -f GB18030 -t UTF-8 "$file" > "$tmp"; then
    cat "$tmp" > "$file"
    rm -f "$tmp"
    echo "converted-gb18030-to-utf8: $file"
  else
    rm -f "$tmp"
    echo "unsupported-encoding: $file" >&2
    status=1
  fi
}

for path in "$@"; do
  if [[ -d "$path" ]]; then
    while IFS= read -r -d '' file; do
      normalize_file "$file"
    done < <(find "$path" -type f \( -name '*.md' -o -name '*.txt' \) -print0)
  else
    normalize_file "$path"
  fi
done

exit "$status"
