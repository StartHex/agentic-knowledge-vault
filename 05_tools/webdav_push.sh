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
webdav_connect_timeout="${WEBDAV_CONNECT_TIMEOUT_SECONDS:-10}"
webdav_max_time="${WEBDAV_MAX_TIME_SECONDS:-300}"
webdav_retries="${WEBDAV_RETRIES:-3}"
webdav_create_dirs="${WEBDAV_CREATE_DIRS:-false}"
curl_config="$(mktemp)"
chmod 600 "$curl_config"

curl_config_value() {
  sed 's/\\/\\\\/g; s/"/\\"/g' <<<"$1"
}

printf 'user = "%s:%s"\n' \
  "$(curl_config_value "$WEBDAV_USER")" \
  "$(curl_config_value "$WEBDAV_PASS")" >"$curl_config"

trap 'rm -f "$curl_config"' EXIT

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
  set +e
  status="$(curl -sS -o /dev/null -w "%{http_code}" \
    --config "$curl_config" \
    --connect-timeout "$webdav_connect_timeout" \
    --max-time "${WEBDAV_MKCOL_MAX_TIME_SECONDS:-5}" \
    -X MKCOL \
    "$url")"
  local code=$?
  set -e
  if [[ "$code" -ne 0 ]]; then
    echo "MKCOL warning ($code): $url" >&2
    return 0
  fi

  case "$status" in
    201|405|409) return 0 ;;
    *) echo "MKCOL warning ($status): $url" >&2; return 0 ;;
  esac
}

put_file() {
  local path="$1"
  local url="$root_url/$(url_path "$path")"
  curl -fsS \
    --config "$curl_config" \
    --connect-timeout "$webdav_connect_timeout" \
    --max-time "$webdav_max_time" \
    --retry "$webdav_retries" \
    --retry-all-errors \
    --retry-delay 2 \
    --upload-file "$path" \
    "$url" >/dev/null
}

if [[ "$webdav_create_dirs" == "true" ]]; then
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
    awk 'NF && $0 != "."' |
    while IFS= read -r dir; do
      mkcol "$root_url/$(url_path "$dir")"
    done
else
  echo "WebDAV directory creation disabled; set WEBDAV_CREATE_DIRS=true to enable MKCOL"
fi

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
