#!/bin/bash
# Check that the IME config is deployed only on Arch Linux.
# This must match the .config/environment.d/ rule in .chezmoiignore.
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

os_release="${OS_RELEASE:-/etc/os-release}"
os_id=""
if [ -f "$os_release" ]; then
  os_id="$(. "$os_release" && echo "${ID:-}")"
fi

conf="$HOME/.config/environment.d/im.conf"
if [ "$os_id" = arch ]; then
  [ -f "$conf" ] || check_failed "IME config not found on arch: $conf"
  cat "$conf"
else
  [ ! -e "$conf" ] || check_failed "IME config must not exist on ${os_id:-this OS}: $conf"
  echo "IME config is not deployed"
fi
