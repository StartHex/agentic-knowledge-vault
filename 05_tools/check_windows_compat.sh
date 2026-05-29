#!/usr/bin/env bash
set -euo pipefail

status=0

echo "Windows compatibility check"

echo
echo "Invalid Windows filename characters:"
invalid="$(find . \
  -path './.git' -prune -o \
  -type f -name '*[<>:"\\|?*]*' -print)"
if [[ -n "$invalid" ]]; then
  echo "$invalid"
  status=1
else
  echo "none"
fi

echo
echo "Trailing spaces or dots:"
trailing="$(find . \
  -path './.git' -prune -o \
  -type f -print |
  awk -F/ '{name=$NF; if (name ~ /[. ]$/) print}')"
if [[ -n "$trailing" ]]; then
  echo "$trailing"
  status=1
else
  echo "none"
fi

echo
echo "Reserved Windows basenames:"
reserved="$(find . \
  -path './.git' -prune -o \
  -type f -print |
  awk -F/ '
    {
      name=toupper($NF)
      sub(/\..*/, "", name)
      if (name ~ /^(CON|PRN|AUX|NUL|COM[1-9]|LPT[1-9])$/) print
    }')"
if [[ -n "$reserved" ]]; then
  echo "$reserved"
  status=1
else
  echo "none"
fi

echo
echo "Case-insensitive path collisions:"
collisions="$(find . \
  -path './.git' -prune -o \
  -type f -print |
  awk '{lower=tolower($0); seen[lower]++; paths[lower]=paths[lower] ORS $0} END {for (p in seen) if (seen[p] > 1) print paths[p]}')"
if [[ -n "$collisions" ]]; then
  echo "$collisions"
  status=1
else
  echo "none"
fi

echo
echo "Long paths over 240 characters:"
long_paths="$(find . \
  -path './.git' -prune -o \
  -type f -print |
  awk 'length($0) > 240 {print length($0) " " $0}')"
if [[ -n "$long_paths" ]]; then
  echo "$long_paths"
  status=1
else
  echo "none"
fi

exit "$status"

