#!/bin/bash -xeu
mkdir -p ~/.cache
sudo pacman -Sy --noconfirm reflector
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo reflector --country "Japan,Australia" --age 24 --latest 5 --protocol https --sort score --save /etc/pacman.d/mirrorlist

