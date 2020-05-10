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

prune_config="--stats --keep-daily 14 --keep-weekly 4 --keep-monthly 6 --keep-yearly -1 --save-space"

msg "Pruning backups for host1"
borg prune --prefix host1 ${prune_config} "${BORG_LOCATION}"

msg "Pruning backups for host2"
borg prune --prefix host2 ${prune_config} "${BORG_LOCATION}"

msg "Finished pruning backups"
