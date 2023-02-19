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

# Set mirrors for ArchLinux and Manjaro
if [ $platform == "arch" ]; then
    /bin/bash ./install_script/set_mirror_arch.sh
elif [ $platform == "manjaro" ]; then
    /bin/bash ./install_script/set_mirror_manjaro.sh
fi


# Install apps for Ubuntu
if [ $platform == "ubuntu" ]; then
    /bin/bash ./install_script/ubuntu_app.sh
fi

# Check and Install Homebrew
if [ $platform == "ubuntu" ] || [ $platform == "darwin" ]; then
    /bin/bash ./install_script/brew.sh
fi

