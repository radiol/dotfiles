#!/bin/bash -xeu

trap 'echo "::error file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR

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
