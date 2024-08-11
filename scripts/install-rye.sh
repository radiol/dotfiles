#!/bin/bash -xeu

# ---------------------------------------------------------
# Install Rye
# ---------------------------------------------------------
echo "Installing Rye"
curl -sSf https://rye.astral.sh/get | RYE_INSTALL_OPTION="--yes" bash
