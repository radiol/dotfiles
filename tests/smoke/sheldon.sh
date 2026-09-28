#!/bin/bash
# Check that starting zsh makes sheldon generate plugins.lock, and that a
# normal zsh startup prints no errors
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

# The first startup may print sheldon's install progress, so only the
# second one is checked for errors
zsh -i -l -c exit

lock="$HOME/.local/share/sheldon/plugins.lock"
[ -f "$lock" ] || check_failed "sheldon plugins.lock not found: $lock"
echo "sheldon plugins.lock exists"

errors="$(zsh -i -l -c exit 2>&1 >/dev/null)"
[ -z "$errors" ] || check_failed "zsh startup printed errors: $errors"
echo "zsh starts without errors"
