#!/bin/bash

# Get operating system
platform="unknown"
unamestr=$(uname)
if [[ $unamestr == "Linux" ]]; then
    platform="linux"
elif [[ $unamestr == "Darwin" ]]; then
    platform="darwin"
fi

# If OS is Ubuntu, install require apps(for homebrew, asdf-python)
if [ $platform == "linux" ]; then
    sudo apt update && sudo apt upgrade -y && \
    sudo apt install -y \
    build-essential \
    curl \
    file \
    git \
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
    xz-utils \
    zlib1g-dev \
    zsh && \
    sudo apt autoclean
fi

# Check Homebrew
if ! (type "brew" > /dev/null 2>&1); then
    # Install Homebrew
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Activate Homebrew path
    if [[ -d "/home/linuxbrew/.linuxbrew" ]]
    then
        HOMEBREW_HOME="/home/linuxbrew/.linuxbrew"
    elif [[ -d "/opt/homebrew" ]]
    then
        HOMEBREW_HOME="/opt/homebrew"
    else
        HOMEBREW_HOME="/usr/local"
    fi
    eval "$($HOMEBREW_HOME/bin/brew shellenv)"
fi

# Install apps
brew install \
    chezmoi \
    sheldon \
    asdf \
    bat \
    deno \
    exa \
    fd \
    fzf \
    nodejs \
    ripgrep \
    neovim

# Install Nerd font. MacOS only
# WSL and linux need manual installation
if [ $platform == "darwin" ]; then
  brew tap homebrew/cask-fonts
  brew install --cask font-hack-nerd-font
fi
# Install apps for macOS
if [ $platform == "darwin" ]; then
    # For asdf-python
    brew install openssl readline sqlite3 xz zlib tcl-tk
fi

# Install python with asdf
asdf plugin add python && \
asdf install python latest && \
asdf global python latest

# Install poetry 
if [ ! -e ~/.local/bin/poetry ]; then
    curl -sSL https://install.python-poetry.org | python3 -
fi
~/.local/bin/poetry config virtualenvs.in-project true
# Install dotfiles
chezmoi init git@github.com:radiol/dotfiles.git && chezmoi apply

# Change default shell to zsh
sudo chsh -s $(which zsh) $(whoami)
