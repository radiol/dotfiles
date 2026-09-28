#!/bin/bash
# Check that the go app gomi is installed
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

gomi="$HOME/go/bin/gomi"
[ -x "$gomi" ] || check_failed "gomi not found or not executable: $gomi"
echo "gomi is executable"
