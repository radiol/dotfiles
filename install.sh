#!/bin/bash

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

# Install applications
brew install chezmoi sheldon

# Install dotfiles
chezmoi init git@github.com:radiol/dotfiles.git && chezmoi apply
