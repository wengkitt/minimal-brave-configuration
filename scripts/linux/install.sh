#!/usr/bin/env bash
set -euo pipefail

if [[ ${EUID} -ne 0 ]]; then
  echo "Run this script with sudo." >&2
  exit 1
fi

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_FILE="${SCRIPT_DIR}/../../policies/linux/brave-origin-like.json"
TARGET_DIR="/etc/brave/policies/managed"
TARGET_FILE="${TARGET_DIR}/brave-origin-like.json"

install -d -m 0755 "${TARGET_DIR}"
install -m 0644 "${SOURCE_FILE}" "${TARGET_FILE}"

echo "Installed ${TARGET_FILE}"
echo "Restart Brave, open brave://policy, and click Reload policies."
