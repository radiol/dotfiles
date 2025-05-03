#!/bin/bash -xeu

# ---------------------------------------------------------
# Install apps for Ubuntu
# ---------------------------------------------------------
echo "::group::Ubuntu Install Apps"

echo "Installing apps for Ubuntu"
sudo apt update -qq && sudo apt upgrade -y -qq &&
	sudo apt install -y -qq \
		build-essential \
		curl \
		file \
		jq \
		language-pack-ja \
		libbz2-dev \
		libffi-dev \
		liblzma-dev \
		libncursesw5-dev \
		libreadline-dev \
		libsqlite3-dev \
		libssl-dev \
		libxml2-dev \
		libxmlsec1-dev \
		llvm \
		make \
		procps \
		tk-dev \
		wget \
		zlib1g-dev &&
	sudo apt autoclean -qq

# Install wezterm for ubuntu
echo "Installing wezterm for Ubuntu"
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update -qq && sudo apt install -y -qq wezterm

echo "::endgroup::"
