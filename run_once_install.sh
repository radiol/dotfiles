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

/bin/bash -c "$(curl -fsLS chezmoi.io/get)" -- init --apply radiol

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

# Activate Homebrew path
if [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
    HOMEBREW_HOME="/home/linuxbrew/.linuxbrew"
elif [[ -d "/opt/homebrew" ]]; then
    HOMEBREW_HOME="/opt/homebrew"
else
    HOMEBREW_HOME="/usr/local"
fi
eval "($HOMEBREW_HOME/bin/brew shellenv)"

# ---------------------------------------------------------
# Install asdf, cargo, volta
# ---------------------------------------------------------
# Install asdf
if ! (type "asdf" > /dev/null 2>&1); then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.1
    source "$HOME/.asdf/asdf.sh"
fi

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
if [ ! $platform == "darwin" ]; then
    cargo install trashy cargo-update
fi
# Install volta
curl https://get.volta.sh | bash

# Change default shell to zsh
if [ $platform == "arch" ]; then
    sudo chsh -s /bin/zsh $(whoami)
else
    sudo chsh -s $(which zsh) $(whoami)
fi
# Neovim Onece
nvim --headless "+Lazy! sync" +qa

# Create XDG folder
mkdir -p ~/.local/state
