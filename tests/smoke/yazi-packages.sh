#!/bin/bash
# Check that every package in .chezmoidata/yazi.toml is installed
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
activate_mise

source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

installed="$(ya pkg list)"
echo "$installed"

for pkg in $(chezmoi --source "$source_dir" execute-template '{{ range .yazi.packages }}{{ . }} {{ end }}'); do
  grep -qF -- "$pkg (" <<<"$installed" || check_failed "yazi package $pkg is not installed"
done
