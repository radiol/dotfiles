#!/bin/bash

# Get operating system
platform='unknown'
unamestr=$(uname)
if [[ $unamestr == 'Linux' ]]; then
  platform='linux'
elif [[ $unamestr == 'Darwin' ]]; then
  platform='darwin'
fi

# If OS is Ubuntu, install require apps
if [ $platform == "linux" ]; then
    # For Homebrew
    sudo apt install -y zsh build-essential procps curl file git language-pack-ja
    # For asdf-python
    sudo apt install -y python3.10-venv make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
fi

# Check Homebrew
if !(type "brew" > /dev/null 2>&1); then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Activate Homebrew path
    if [[ -d '/home/linuxbrew/.linuxbrew' ]]
    then
        HOMEBREW_HOME='/home/linuxbrew/.linuxbrew'
    elif [[ -d '/opt/homebrew' ]]
    then
        HOMEBREW_HOME='/opt/homebrew'
    else
        HOMEBREW_HOME='/usr/local'
    fi
    eval "$($HOMEBREW_HOME/bin/brew shellenv)"
fi

# Install apps
brew install \
    chezmoi \
    sheldon \
    bat \
    exa \
    fd 

# Install apps for macOS
if [ $platform == "darwin" ]; then
    # For asdf-python
    brew install openssl readline sqlite3 xz zlib tcl-tk
fi

# Install poetry 
curl -sSL https://install.python-poetry.org | python3 -

# Install dotfiles
chezmoi init git@github.com:radiol/dotfiles.git && chezmoi apply
