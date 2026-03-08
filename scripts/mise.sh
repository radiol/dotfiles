#!/bin/bash -xeu

# ---------------------------------------------------------
# Install Mise
# ---------------------------------------------------------
echo "::group::Install Mise"

# Check if Mise is already installed
if type "mise" >/dev/null 2>&1; then
	echo "Mise is already installed"
else
	# Install Mise
	echo "Installing Mise"
	curl https://mise.run | sh
fi

echo "::endgroup::"

# ---------------------------------------------------------
# Install tools via Mise
# ---------------------------------------------------------
echo "::group::Install tools via Mise"

# Use full path since PATH may not include mise yet
MISE="${HOME}/.local/bin/mise"

"${MISE}" use --global bat
"${MISE}" use --global bottom
"${MISE}" use --global chezmoi
"${MISE}" use --global ghq
"${MISE}" use --global github-cli
"${MISE}" use --global jujutsu
"${MISE}" use --global lefthook
"${MISE}" use --global lua
"${MISE}" use --global neovim
"${MISE}" use --global ripgrep
"${MISE}" use --global usage
"${MISE}" use --global yazi

echo "::endgroup::"
