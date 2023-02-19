#!/bin/bash -xeu

# Get operating system
platform="unknown"
unamestr=$(uname)
if [[ $unamestr == "Linux" ]]; then
    if [[ -e /etc/debian_version ]]; then
        platform="ubuntu"
    elif [[ -e /etc/manjaro-release ]]; then
        platform="manjaro"
    elif [[ -e /etc/arch-release ]]; then
        platform="arch"
    fi
elif [[ $unamestr == "Darwin" ]]; then
    platform="darwin"
fi
echo "Operating System is $platform"
cd ~/.local/share/chezmoi

# ---------------------------------------------------------
# Installation for ArchLinux and Manjaro
# ---------------------------------------------------------
# Set mirrors for ArchLinux and Manjaro
if [ $platform == "arch" ]; then
    /bin/bash ./install_script/set_mirror_arch.sh
elif [ $platform == "manjaro" ]; then
    /bin/bash ./install_script/set_mirror_manjaro.sh
fi

if [ $platform == "arch" ] || [ $platform == "manjaro" ]; then
    /bin/bash ./install_script/pacman_app.sh
fi

# ---------------------------------------------------------
# Installation for MacOS and Ubuntu with Homebrew
# ---------------------------------------------------------
# Install apps for Ubuntu
if [ $platform == "ubuntu" ]; then
    /bin/bash ./install_script/ubuntu_app.sh
fi

# Check and Install Homebrew. Install Apps
if [ $platform == "ubuntu" ] || [ $platform == "darwin" ]; then
    /bin/bash ./install_script/brew.sh
    /bin/bash ./install_script/brew_app.sh
    # Install apps for macOS
    if [ $platform == "darwin" ]; then
        /bin/bash ./install_script/mac_app.sh
    fi
fi

# ---------------------------------------------------------
# Install asdf, cargo, volta
# ---------------------------------------------------------
/bin/bash ./install_script/asdf_poetry.sh
