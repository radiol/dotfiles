#!/bin/bash -xeu
mkdir -p ~/.cache
sudo pacman -Sy --noconfirm reflector
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo reflector --country "Japan" --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

