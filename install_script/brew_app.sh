#!/bin/bash

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
