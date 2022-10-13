# Change mirror server
sudo pacman-mirrors --fasttrack

# Update
sudo pacman -Syyu  --noconfirm

# Change dir names to English
sudo pacman -Sy xdg-user-dirs-gtk --noconfirm
LANG=C xdg-user-dirs-gtk-update

# Change CapsLock to Ctrl
/usr/bin/setxkbmap -option "ctrl:nocaps"

# Install applications
sudo pacman -S --noconfirm \
  base-devel \
  bat \
  chezmoi \
  curl \
  exa \
  fd \
  fzf \
  git \
  gtk2 \
  neovim \
  python-poetry \
  ripgrep \
  sheldon \
  ufw \
  wezterm \
  yay

# Install AUR applications
yay -S --noconfirm \
  asdf \
  visual-studio-code-bin

# Install python by asdf
asdf plugin add python
asdf install python latest
asdf global python latest

# Change default shell to zsh
sudo chsh -s $(which zsh) $(whoami)
