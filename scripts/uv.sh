#!/bin/bash -xeu

# ---------------------------------------------------------
# Install uv
# ---------------------------------------------------------
# Check if uv is already installed
if type uv >/dev/null 2>&1; then
  echo "uv is already installed"
  exit 0
fi

# Install uv
echo "Installing uv..."
if type pacman >/dev/null 2>&1; then
  sudo pacman -S --noconfirm uv
elif type brew >/dev/null 2>&1; then
  brew install -q uv
else
  INSTALLER_NO_MODIFY_PATH=1 bash -c 'curl -LsSf https://astral.sh/uv/install.sh | sh'
fi
