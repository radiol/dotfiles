#!/bin/bash
# Check that the go app gomi is installed
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

gomi="$HOME/go/bin/gomi"
[ -e "$gomi" ] || check_failed "gomi not found: $gomi"
echo "gomi exists"
