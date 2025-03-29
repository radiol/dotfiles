#!/bin/bash -xeu

# ---------------------------------------------------------
# Install apps for Ubuntu
# ---------------------------------------------------------
echo "::group::Ubuntu Install Apps"

echo "Installing apps for Ubuntu"
sudo apt update -qq && sudo apt upgrade -y -qq &&
	sudo apt install -y -qq \
		bat \
		build-essential \
		cmake \
		curl \
		fd-find \
		file \
		fzf \
		git \
		gh \
		golang \
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
		luarocks \
		make \
		procps \
		tk-dev \
		wget \
		xclip \
		xz-utils \
		zlib1g-dev \
		zsh &&
	sudo apt autoclean -qq
# Install apps by snap
echo "Installing apps by snap"
sudo snap install --classic chezmoi
sudo snap install --classic nvim
sudo snap install --classic ripgrep
sudo snap install deno
sudo snap install lazygit

# Create symbolic link
mkdir -p ~/.local/bin
ln -nfs "$(which batcat)" ~/.local/bin/bat
ln -nfs "$(which fdfind)" ~/.local/bin/fd

# Install wezterm for ubuntu
echo "Installing wezterm for Ubuntu"
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update -qq && sudo apt install -y -qq wezterm

echo "::endgroup::"
