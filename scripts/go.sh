#!/bin/bash -xeu

trap 'echo "::error file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR

echo "::group::Install go apps"

# Check go is available
if ! type go >/dev/null 2>&1; then
  echo "go is not available"
  return
fi

# Install go apps
echo "Installing go apps"
go install github.com/babarot/gomi@latest

echo "::endgroup::"
