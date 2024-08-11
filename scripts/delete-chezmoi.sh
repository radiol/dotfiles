#!/bin/bash -xeu

# ----------------------------------------------------------------------------
# Remove chezmoi
# ----------------------------------------------------------------------------
if [ -f "$HOME/bin/chezmoi" ]; then
    echo "Removing ~/bin/chezmoi"
    rm "$HOME/bin/chezmoi"
fi
if [ -d "$HOME/bin" ]; then
    if [ "$(ls -A "$HOME"/bin)" = "" ]; then
        echo "Removing ~/bin"
        rmdir "$HOME/bin"
    fi
fi
