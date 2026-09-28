# Common setup for smoke checks. Source this at the top of each check.
# A failed check exits 1.

set -euo pipefail

# Put tools installed by mise on PATH, if mise is installed
activate_mise() {
  local mise="$HOME/.local/bin/mise"
  if [ -x "$mise" ]; then
    eval "$("$mise" activate bash)"
  fi
}

# Report a failed check and exit 1
check_failed() {
  echo "::error::$*"
  exit 1
}
