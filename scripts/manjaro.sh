#!/bin/bash -xeu

trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR

# ---------------------------------------------------------
# Set Mirror Server for Manjaro
# ---------------------------------------------------------
echo "::group::Manjaro Mirror Setup"
echo "Setting Manjaro mirror servers"
mkdir -p ~/.cache
sudo pacman-mirrors -c Japan
sudo pacman-mirrors --fasttrack
echo "::endgroup::"
