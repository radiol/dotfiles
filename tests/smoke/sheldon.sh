#!/bin/bash
# Check that starting zsh makes sheldon generate plugins.lock
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

zsh -i -l -c exit

lock="$HOME/.local/share/sheldon/plugins.lock"
[ -f "$lock" ] || check_failed "sheldon plugins.lock not found: $lock"
echo "sheldon plugins.lock exists"
