#!/bin/bash
# Check that Mason tools install and lazy.nvim plugins are present
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
activate_mise

echo "::group::MasonToolsInstall"
nvim --headless "+MasonToolsInstall" +qa
echo "::endgroup::"

lazy_dir="$HOME/.local/share/nvim/lazy"
[ -d "$lazy_dir" ] || check_failed "lazy.nvim dir not found: $lazy_dir"
ls "$lazy_dir"
