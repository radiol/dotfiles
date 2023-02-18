#!/bin/bash -xeu
# Change mirror server
mkdir -p ~/.cache
pacman -Sy --noconfirm reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
reflector --country "Japan" --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Update
pacman -Syyu  --noconfirm

# Change dir names to English
pacman -Sy xdg-user-dirs-gtk --noconfirm
LANG=C xdg-user-dirs-gtk-update --noconfirm

# Change CapsLock to Ctrl
/usr/bin/setxkbmap -option "ctrl:nocaps"

# Install applications
pacman -Sy --noconfirm \
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

# Install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.1
source "$HOME/.asdf/asdf.sh"

# Install python by asdf
asdf plugin add python && \
asdf install python latest && \
asdf global python latest

# Install poetry
if [ ! -e ~/.local/bin/poetry ]; then
    curl -sSL https://install.python-poetry.org | python3 -
fi
~/.local/bin/poetry config virtualenvs.in-project true

# Install Rust
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs > rustup.sh
sh rustup.sh -y && rm rustup.sh
source "$HOME/.cargo/env"

# Install cargo apps
cargo install trashy cargo-update

# Install volta
curl https://get.volta.sh | bash

# Install dotfiles
chezmoi init git@github.com:radiol/dotfiles.git && chezmoi apply

# Change default shell to zsh
chsh -s /bin/zsh $(whoami)

# Neovim Onece
nvim --headless "+Lazy! sync" +qa

# Create XDG folder
mkdir -p ~/.local/state
