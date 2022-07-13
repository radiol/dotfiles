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
    sudo apt install zsh build-essential procps curl file git language-pack-ja -y
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
brew install chezmoi sheldon

# Install apps for macOS
if [ $platform == "darwin" ]; then
    brew install coreutils
fi

# Install dotfiles
chezmoi init git@github.com:radiol/dotfiles.git && chezmoi apply
