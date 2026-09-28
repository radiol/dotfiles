#!/bin/bash
# Check that Mason tools install and lazy.nvim plugins are present
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
activate_mise

echo "::group::MasonToolsInstall"
nvim --headless "+MasonToolsInstall" +qa
echo "::endgroup::"

lazy_dir="$HOME/.local/share/nvim/lazy"
[ -d "$lazy_dir/lazy.nvim" ] || check_failed "lazy.nvim not found in $lazy_dir"
ls "$lazy_dir"
