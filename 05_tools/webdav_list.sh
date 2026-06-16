#!/usr/bin/env bash
set -euo pipefail

if [[ -f .webdav.env ]]; then
  # shellcheck disable=SC1091
  source .webdav.env
fi

: "${WEBDAV_URL:?Set WEBDAV_URL}"
: "${WEBDAV_USER:?Set WEBDAV_USER}"
: "${WEBDAV_PASS:?Set WEBDAV_PASS}"

curl_config="$(mktemp)"
chmod 600 "$curl_config"

curl_config_value() {
  sed 's/\\/\\\\/g; s/"/\\"/g' <<<"$1"
}

printf 'user = "%s:%s"\n' \
  "$(curl_config_value "$WEBDAV_USER")" \
  "$(curl_config_value "$WEBDAV_PASS")" >"$curl_config"

trap 'rm -f "$curl_config"' EXIT

curl -fsS \
  --config "$curl_config" \
  --connect-timeout "${WEBDAV_CONNECT_TIMEOUT_SECONDS:-10}" \
  --max-time "${WEBDAV_MAX_TIME_SECONDS:-300}" \
  --retry "${WEBDAV_RETRIES:-3}" \
  --retry-all-errors \
  --retry-delay 2 \
  -X PROPFIND \
  -H "Depth: 1" \
  "$WEBDAV_URL/"
