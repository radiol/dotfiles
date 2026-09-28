#!/bin/bash
# Check that every target matches the source state after chezmoi apply,
# i.e. applying again would change nothing
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
activate_mise

if ! chezmoi verify; then
  chezmoi status
  check_failed "targets differ from the source state (see chezmoi status above)"
fi
echo "all targets match the source state"
