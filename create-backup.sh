#! /usr/bin/env bash
set -euo pipefail

BORG_LOCATION="/hdd/borg-repo0"

function msg() {
  echo
  echo "[$(date -Iseconds)] $1"
}

if pgrep borg > /dev/null; then
  msg "borg is already running - aborting"
  exit 0
fi

# sync to borg
msg "Syncing backups to borg master"
archive_name="$(hostname)-$(date -Iseconds | cut -d '+' -f 1)"
borg create --stats --compression zlib \
  "${BORG_LOCATION}"::"${archive_name}" \
  ~/Pictures \
  ~/Documents

msg "Backup finished"
