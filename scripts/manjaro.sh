#!/bin/bash -xeu

# ---------------------------------------------------------
# Set Mirror Server for Manjaro
# ---------------------------------------------------------
echo "Setting Manjaro mirror servers"
mkdir -p ~/.cache
sudo pacman-mirrors -c Japan
sudo pacman-mirrors --fasttrack
