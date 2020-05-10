#! /usr/bin/env bash
set -euo pipefail

BORG_LOCATION="/hdd/borg-repo0"
# BORG_LOCATION="username@host:/hdd/borg-repo0" <-- if Borg lives on a different machine
RCLONE_REMOTE_NAME="b2"
B2_BUCKET_NAME="your-bucket-name"

function msg() {
  echo
  echo "[$(date -Iseconds)] $1"
}

if pgrep rclone > /dev/null; then
  msg "rclone is already running - aborting"
  exit 0
fi

msg "Syncing to B2"
rclone sync "${BORG_LOCATION}" "${RCLONE_REMOTE_NAME}":"${B2_BUCKET_NAME}"
rclone cleanup "${RCLONE_REMOTE_NAME}":"${B2_BUCKET_NAME}"

msg "Finished syncing to B2"
