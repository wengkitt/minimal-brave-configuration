#!/usr/bin/env bash
set -euo pipefail

if [[ ${EUID} -ne 0 ]]; then
  echo "Run this script with sudo." >&2
  exit 1
fi

TARGET_DIR="/Library/Managed Preferences"
TARGET_FILE="${TARGET_DIR}/com.brave.Browser.plist"
BACKUP_DIR="/Library/Application Support/MinimalBraveConfiguration"
BACKUP_FILE="${BACKUP_DIR}/preinstall.plist"
LEGACY_BACKUP_FILE="/Library/Application Support/BraveOriginLikeConfig/preinstall.plist"
PLIST_BUDDY="/usr/libexec/PlistBuddy"

install -d -m 0755 "${TARGET_DIR}" "${BACKUP_DIR}"
if [[ -f "${LEGACY_BACKUP_FILE}" && ! -f "${BACKUP_FILE}" ]]; then
  cp -p "${LEGACY_BACKUP_FILE}" "${BACKUP_FILE}"
fi
if [[ -f "${TARGET_FILE}" && ! -f "${BACKUP_FILE}" ]]; then
  cp -p "${TARGET_FILE}" "${BACKUP_FILE}"
fi
if [[ ! -f "${TARGET_FILE}" ]]; then
  plutil -create xml1 "${TARGET_FILE}"
fi

set_bool() {
  local key="$1" value="$2"
  if "${PLIST_BUDDY}" -c "Print :${key}" "${TARGET_FILE}" >/dev/null 2>&1; then
    "${PLIST_BUDDY}" -c "Set :${key} ${value}" "${TARGET_FILE}"
  else
    "${PLIST_BUDDY}" -c "Add :${key} bool ${value}" "${TARGET_FILE}"
  fi
}

set_bool TorDisabled true
set_bool BraveRewardsDisabled true
set_bool BraveWalletDisabled true
set_bool BraveVPNDisabled true
set_bool BraveAIChatEnabled false
set_bool BraveNewsDisabled true
set_bool BraveTalkDisabled true
set_bool BraveSpeedreaderEnabled false
set_bool BraveWaybackMachineEnabled false
set_bool BraveP3AEnabled false
set_bool BraveStatsPingEnabled false
set_bool BraveWebDiscoveryEnabled false
set_bool BravePlaylistEnabled false
set_bool MetricsReportingEnabled false

chmod 0644 "${TARGET_FILE}"
killall cfprefsd 2>/dev/null || true
echo "Policies installed. Fully quit and relaunch Brave, then reload brave://policy."
