# Change mirror server
sudo pacman -Sy --noconfirm reflector
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo reflector --country "Japan" --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

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
curl --proto '=https' --tlsv1.2 -sSfy https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

# Install cargo apps
cargo install trashy cargo-update

# Install dotfiles
chezmoi init git@github.com:radiol/dotfiles.git && chezmoi apply

# Change default shell to zsh
sudo chsh -s $(which zsh) $(whoami)

# Neovim Onece
# nvim --noplugin --headless +qa

# Create XDG folder
mkdir ~/.local/state
