#!/usr/bin/env bash
set -euo pipefail

if [[ ${EUID} -ne 0 ]]; then
  echo "Run this script with sudo." >&2
  exit 1
fi

TARGET_FILE="/etc/brave/policies/managed/brave-origin-like.json"
if [[ -f "${TARGET_FILE}" ]]; then
  rm -- "${TARGET_FILE}"
  echo "Removed ${TARGET_FILE}"
else
  echo "Nothing to remove."
fi
echo "Restart Brave and reload brave://policy."
