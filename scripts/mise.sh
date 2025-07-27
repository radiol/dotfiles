#!/bin/bash -xeu

# ---------------------------------------------------------
# Install Mise
# ---------------------------------------------------------
echo "::group::Install Mise"

if ! (type "mise" >/dev/null 2>&1); then
	echo "Installing Mise"
	curl https://mise.run | sh
	eval "$(~/.local/bin/mise activate zsh)"
fi

echo "::endgroup::"
