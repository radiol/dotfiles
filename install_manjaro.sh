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
  manjaro-asian-input-support-ibus \
  chezmoi \
  gtk2 \
  neovim \
  sheldon \
  ufw \
  wezterm \
  yay \
  
# Change default shell to zsh
sudo chsh -s $(which zsh) $(whoami)
