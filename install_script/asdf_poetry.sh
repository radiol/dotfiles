#!/bin/bash -xeu

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