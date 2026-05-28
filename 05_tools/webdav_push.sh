#!/usr/bin/env bash
set -euo pipefail

if [[ -f .webdav.env ]]; then
  # shellcheck disable=SC1091
  source .webdav.env
fi

if [[ -f .sync.env ]]; then
  # shellcheck disable=SC1091
  source .sync.env
fi

: "${WEBDAV_URL:?Set WEBDAV_URL}"
: "${WEBDAV_USER:?Set WEBDAV_USER}"
: "${WEBDAV_PASS:?Set WEBDAV_PASS}"

root_url="${WEBDAV_URL%/}"

url_path() {
  local path="$1"
  local old_ifs="$IFS"
  local part
  local encoded
  local out=""

  IFS='/'
  for part in $path; do
    encoded="$(jq -rn --arg value "$part" '$value | @uri')"
    if [[ -z "$out" ]]; then
      out="$encoded"
    else
      out="$out/$encoded"
    fi
  done
  IFS="$old_ifs"

  printf '%s' "$out"
}

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
  local url="$root_url/$(url_path "$path")"
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
  -path './.env' -prune -o \
  -path './.sync.env' -prune -o \
  -path './.webdav.env' -prune -o \
  -path './.mac.env' -prune -o \
  -type d -print |
  sed 's#^\./##' |
  awk 'NF' |
  while IFS= read -r dir; do
    mkcol "$root_url/$(url_path "$dir")"
  done

find . \
  -path './.git' -prune -o \
  -path './private' -prune -o \
  -path './restricted' -prune -o \
  -path './.env' -prune -o \
  -path './.sync.env' -prune -o \
  -path './.webdav.env' -prune -o \
  -path './.mac.env' -prune -o \
  -type f -print |
  sed 's#^\./##' |
  sort |
  while IFS= read -r file; do
    echo "PUT $file"
    put_file "$file"
  done
