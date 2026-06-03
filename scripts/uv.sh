#!/bin/bash -xeu

trap 'echo "::error file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR

# ---------------------------------------------------------
# Install uv
# ---------------------------------------------------------

echo "::group::Install uv"

# Check if uv is already installed
if type uv >/dev/null 2>&1; then
  echo "uv is already installed"
  return
fi

# Install uv
echo "Installing uv..."
INSTALLER_NO_MODIFY_PATH=1 bash -c 'curl -LsSf https://astral.sh/uv/install.sh | sh'

echo "::endgroup::"
