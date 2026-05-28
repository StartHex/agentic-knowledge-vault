#!/usr/bin/env bash
set -euo pipefail

if [[ -f .webdav.env ]]; then
  # shellcheck disable=SC1091
  source .webdav.env
fi

: "${WEBDAV_URL:?Set WEBDAV_URL}"
: "${WEBDAV_USER:?Set WEBDAV_USER}"
: "${WEBDAV_PASS:?Set WEBDAV_PASS}"

root_url="${WEBDAV_URL%/}"

mkcol() {
  local url="$1"
  local status
  status="$(curl -sS -o /dev/null -w "%{http_code}" \
    -u "$WEBDAV_USER:$WEBDAV_PASS" \
    -X MKCOL \
    "$url")"

  case "$status" in
    201|405) return 0 ;;
    *) echo "MKCOL failed ($status): $url" >&2; return 1 ;;
  esac
}

put_file() {
  local path="$1"
  local url="$root_url/$path"
  curl -fsS \
    -u "$WEBDAV_USER:$WEBDAV_PASS" \
    --upload-file "$path" \
    "$url" >/dev/null
}

mkcol "$root_url"

find . \
  -path './.git' -prune -o \
  -path './private' -prune -o \
  -path './restricted' -prune -o \
  -path './.webdav.env' -prune -o \
  -type d -print |
  sed 's#^\./##' |
  awk 'NF' |
  while IFS= read -r dir; do
    mkcol "$root_url/$dir"
  done

find . \
  -path './.git' -prune -o \
  -path './private' -prune -o \
  -path './restricted' -prune -o \
  -path './.webdav.env' -prune -o \
  -type f -print |
  sed 's#^\./##' |
  sort |
  while IFS= read -r file; do
    echo "PUT $file"
    put_file "$file"
  done

