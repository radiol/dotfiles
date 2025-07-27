#!/bin/bash -xeu

echo "::group::Install go apps"

# Activate mise
alias mise="~/.local/bin/mise"
eval "$(mise activate bash)"
mise install

# Check go is available
if ! type go >/dev/null 2>&1; then
  echo "go is not available"
  exit 0
fi

# Install go apps
echo "Installing go apps"
go install github.com/babarot/gomi@latest

echo "::endgroup::"
