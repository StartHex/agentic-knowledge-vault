#!/usr/bin/env bash
set -euo pipefail

if [[ -f .webdav.env ]]; then
  # shellcheck disable=SC1091
  source .webdav.env
fi

: "${WEBDAV_URL:?Set WEBDAV_URL}"
: "${WEBDAV_USER:?Set WEBDAV_USER}"
: "${WEBDAV_PASS:?Set WEBDAV_PASS}"

curl -fsS \
  -u "$WEBDAV_USER:$WEBDAV_PASS" \
  -X PROPFIND \
  -H "Depth: 1" \
  "$WEBDAV_URL/"

