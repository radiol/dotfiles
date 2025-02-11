#!/bin/bash -xeu

# ---------------------------------------------------------
# Install Homebrew
# ---------------------------------------------------------
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
	ghq \
	go \
	lazygit \
	neovim \
	nodejs \
	openssl@3 \
	readline \
	ripgrep \
	sqlite3 \
	xclip \
	xz \
	zlib \
	tcl-tk \
	luarocks \
	wezterm
