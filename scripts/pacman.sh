#!/bin/bash -xeu

# ---------------------------------------------------------
# Setup Pacman
# ---------------------------------------------------------
echo "::group:: Pacman Install Apps"

# Edit /etc/pacman.conf
if grep -q "#Color" /etc/pacman.conf; then
	echo "Setting pacman color"
	sudo sed -i "s/#Color/Color/" /etc/pacman.conf
fi

if ! grep -q "ILoveCandy" /etc/pacman.conf; then
	echo "Setting pacman ILoveCandy"
	sudo sed -i "/VerbosePkgLists/a ILoveCandy" /etc/pacman.conf
fi

# Update
sudo pacman -Syyu -q --noconfirm

# Change dir names to English
sudo pacman -Sy -q xdg-user-dirs-gtk --noconfirm
LANG=C xdg-user-dirs-gtk-update --noconfirm

# Install applications
echo "Installing Apps with Pacman"
sudo pacman -Sy -q --noconfirm \
	base-devel \
	bat \
	chezmoi \
	cmake \
	curl \
	fd \
	fzf \
	gcc \
	ghq \
	git \
	github-cli \
	go \
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
	xclip \
	yazi \
	zsh

echo "::endgroup::"
