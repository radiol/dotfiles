#!/bin/bash -xeu
# Update
sudo pacman -Syyu  --noconfirm

# Change dir names to English
sudo pacman -Sy xdg-user-dirs-gtk --noconfirm
LANG=C xdg-user-dirs-gtk-update --noconfirm

# Change CapsLock to Ctrl
/usr/bin/setxkbmap -option "ctrl:nocaps"

# Install applications
sudo pacman -Sy --noconfirm \
    base-devel \
    bat \
    chezmoi \
    cmake \
    curl \
    exa \
    fd \
    fzf \
    gcc \
    git \
    gtk2 \
    neovim \
    npm \
    openssl \
    python-poetry \
    ripgrep \
    sheldon \
    openssh \
    ufw \
    unzip \
    wezterm \
    zsh