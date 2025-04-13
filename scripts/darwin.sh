#!/bin/bash -xeu

# ---------------------------------------------------------
# Install Homebrew
# ---------------------------------------------------------
echo "::group::Homebrew"

# Check Homebrew
if ! (type "brew" >/dev/null 2>&1); then
	# Install Homebrew
	echo "Installing Homebrew"
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# Activate Homebrew path
	if [[ -d "/opt/homebrew" ]]; then
		HOMEBREW_HOME="/opt/homebrew"
	else
		HOMEBREW_HOME="/usr/local"
	fi
	eval "$("$HOMEBREW_HOME"/bin/brew shellenv)"
fi

# ---------------------------------------------------------
# Install Apps for Mac
# ---------------------------------------------------------
echo "Installing Apps for Mac"
brew install -q --cask font-hack-nerd-font
brew install -q \
	bat \
	chezmoi \
	cmake \
	deno \
	fd \
	fzf \
	gh \
	ghq \
	go \
	lazygit \
	luarocks \
	neovim \
	nodejs \
	openssl@3 \
	readline \
	ripgrep \
	sqlite3 \
	tcl-tk \
	wezterm \
	xclip \
	xz \
	yazi \
	zlib

echo "::endgroup::"
