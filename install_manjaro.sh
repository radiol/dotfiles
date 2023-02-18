#!/bin/bash
mkdir -p ~/.cache
# Change mirror server
sudo pacman-mirrors --fasttrack

# Update
sudo pacman -Syyu  --noconfirm

# Change dir names to English
sudo pacman -Sy xdg-user-dirs-gtk --noconfirm
LANG=C xdg-user-dirs-gtk-update --noconfirm

# Change CapsLock to Ctrl
/usr/bin/setxkbmap -option "ctrl:nocaps"

# Install applications
sudo pacman -S --noconfirm \
  base-devel \
  bat \
  chezmoi \
  cmake \
  curl \
  exa \
  fd \
  fzf \
  git \
  gtk2 \
  neovim \
  npm \
  python-poetry \
  ripgrep \
  sheldon \
  ufw \
  unzip \
  wezterm

# Install asdf
git clone https://aur.archlinux.org/asdf-vm.git && \
  cd asdf-vm && \
  makepkg -si --noconfirm &&  \
  cd

# Install AUR applications
# yay -S --noconfirm \
#  visual-studio-code-bin

# Install python by asdf
# asdf plugin add python
# asdf install python latest
# asdf global python latest

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
# chezmoi init git@github.com:radiol/dotfiles.git && chezmoi apply

# Change default shell to zsh
sudo chsh -s $(which zsh) $(whoami)

# Neovim Onece
nvim --headless "+Lazy! sync" +qa

# Create XDG folder
mkdir -p ~/.local/state
