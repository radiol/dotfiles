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
  neovim \
  openssl@3 \
  readline \
  ripgrep \
  sqlite3 \
  tcl-tk \
  xclip \
  xz \
  yazi \
  zlib \
  zsh
