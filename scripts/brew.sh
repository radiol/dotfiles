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
  elif [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
    HOMEBREW_HOME="/home/linuxbrew/.linuxbrew"
  else
    HOMEBREW_HOME="/usr/local"
  fi
  eval "$("$HOMEBREW_HOME"/bin/brew shellenv)"
fi

# ---------------------------------------------------------
# Clean up Homebrew
# ---------------------------------------------------------
echo "Cleaning up Homebrew"
brew uninstall --ignore-dependencies cmake || true
brew update-reset && brew update

# ---------------------------------------------------------
# Install Homebrew Apps
# ---------------------------------------------------------
echo "Installing Homebrew Apps"
brew install -q --cask font-hack-nerd-font
brew install -q \
  bat \
  chezmoi \
  cmake \
  fd \
  fzf \
  git \
  go \
  jq \
  lazygit \
  luarocks \
  neovim \
  node \
  openssl@3 \
  readline \
  ripgrep \
  sqlite3 \
  starship \
  tcl-tk \
  topgrade \
  xclip \
  xz \
  yazi \
  zlib \
  zsh
