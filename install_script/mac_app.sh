#!/bin/bash -xeu

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

# Apps for MacOS
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
brew install openssl readline sqlite3 xz zlib tcl-tk