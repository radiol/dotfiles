#!/bin/bash -xeu

# ---------------------------------------------------------
# Install Mise
# ---------------------------------------------------------
echo "::group::Install Mise"

# Check if Mise is already installed
if type "mise" >/dev/null 2>&1; then
	echo "Mise is already installed"
	return
fi

# Install Mise
echo "Installing Mise"
curl https://mise.run | sh
echo "::endgroup::"
