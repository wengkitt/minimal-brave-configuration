#!/usr/bin/env bash
set -euo pipefail

if [[ ${EUID} -ne 0 ]]; then
  echo "Run this script with sudo." >&2
  exit 1
fi

TARGET_FILE="/Library/Managed Preferences/com.brave.Browser.plist"
BACKUP_FILE="/Library/Application Support/MinimalBraveConfiguration/preinstall.plist"
LEGACY_BACKUP_FILE="/Library/Application Support/BraveOriginLikeConfig/preinstall.plist"
PLIST_BUDDY="/usr/libexec/PlistBuddy"

if [[ ! -f "${BACKUP_FILE}" && -f "${LEGACY_BACKUP_FILE}" ]]; then
  BACKUP_FILE="${LEGACY_BACKUP_FILE}"
fi
if [[ -f "${BACKUP_FILE}" ]]; then
  cp -p "${BACKUP_FILE}" "${TARGET_FILE}"
  rm -- "${BACKUP_FILE}"
  echo "Restored the pre-install policy file."
elif [[ -f "${TARGET_FILE}" ]]; then
  for key in TorDisabled BraveRewardsDisabled BraveWalletDisabled BraveVPNDisabled BraveAIChatEnabled BraveNewsDisabled BraveTalkDisabled BraveSpeedreaderEnabled BraveWaybackMachineEnabled BraveP3AEnabled BraveStatsPingEnabled BraveWebDiscoveryEnabled BravePlaylistEnabled MetricsReportingEnabled; do
    "${PLIST_BUDDY}" -c "Delete :${key}" "${TARGET_FILE}" 2>/dev/null || true
  done
  echo "Removed project-owned policy keys."
else
  echo "Nothing to remove."
fi

killall cfprefsd 2>/dev/null || true
echo "Fully quit and relaunch Brave, then reload brave://policy."
