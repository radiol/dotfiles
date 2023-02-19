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
echo $platform

if [ $platform == "ubuntu"]; then
    /bin/bash ./install_script/ubuntu_app.sh
fi