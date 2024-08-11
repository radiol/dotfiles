# ---------------------------------------------------------
# Setup Pacman
# ---------------------------------------------------------
# Edit /etc/pacman.conf
if grep -q "#Color" /etc/pacman.conf;
then
    sudo sed -i "s/#Color/Color/" /etc/pacman.conf
fi

if ! grep -q "ILoveCandy" /etc/pacman.conf;
then
    sudo sed -i "/VerbosePkgLists/a ILoveCandy" /etc/pacman.conf
fi

# Update
sudo pacman -Syyu -q --noconfirm

# Change dir names to English
sudo pacman -Sy -q xdg-user-dirs-gtk --noconfirm
LANG=C xdg-user-dirs-gtk-update --noconfirm

# Install applications
sudo pacman -Sy -q --noconfirm \
    base-devel \
    bat \
    chezmoi \
    cmake \
    curl \
    fd \
    fzf \
    gcc \
    git \
    gtk2 \
    jq \
    lazygit \
    luarocks \
    neovim \
    noto-fonts-emoji \
    npm \
    openssl \
    ripgrep \
    openssh \
    ufw \
    unzip \
    wezterm \
    zsh
