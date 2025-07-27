#!/bin/bash -xeu

# ---------------------------------------------------------
# Install Mise
# ---------------------------------------------------------
echo "::group::Install Mise"

if ! (type "mise" >/dev/null 2>&1); then
	echo "Installing Mise"
	curl https://mise.run | sh
fi

~/.local/bin/mise use --global deno node go lua python github-cli ghq usage

echo "::endgroup::"
