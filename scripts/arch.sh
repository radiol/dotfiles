#!/bin/bash -xeu

trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR

# ---------------------------------------------------------
# Set Mirror Server for ArchLinux
# ---------------------------------------------------------
echo "::group::ArchLinux Mirror Setup"
echo "Setting ArchLinux mirror servers"
mkdir -p ~/.cache
sudo pacman -Sy -q --noconfirm reflector
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo reflector --country "Japan" --latest 5 --completion-percent 95 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
echo "::endgroup::"
