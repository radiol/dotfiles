#!/bin/bash -xeu

# ---------------------------------------------------------
# Install Volta
# ---------------------------------------------------------
echo "::group::Install Volta"

if ! (type "volta" >/dev/null 2>&1); then
	echo "Installing Volta"
	curl https://get.volta.sh | bash
fi

echo "::endgroup::"
