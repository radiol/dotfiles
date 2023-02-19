#!/bin/bash

# If OS is Ubuntu, install require apps(for homebrew, asdf-python)
sudo apt update && sudo apt upgrade -y && \
sudo apt install -y \
build-essential \
curl \
file \
git \
language-pack-ja \
libbz2-dev \
libffi-dev \
liblzma-dev \
libncursesw5-dev \
libreadline-dev \
libsqlite3-dev \
libssl-dev \
libxml2-dev \
libxmlsec1-dev \
llvm \
make \
procps \
tk-dev \
wget \
xz-utils \
zlib1g-dev \
zsh && \
sudo apt autoclean
