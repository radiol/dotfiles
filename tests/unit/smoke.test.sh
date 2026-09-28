#!/bin/bash
# Tests for the smoke checks in tests/smoke/.
# Each check must fail when what it checks is missing, and pass otherwise.
# Run from anywhere: bash tests/unit/smoke.test.sh

set -u

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SMOKE_DIR="$SOURCE_DIR/tests/smoke"

source "$SOURCE_DIR/tests/unit/helpers.sh"

# Create a sandbox with a fake HOME. Fake commands in $SANDBOX/bin shadow
# the system ones; ya, mise, nvim and zsh are never taken from the host.
# Sets SANDBOX, FAKE_HOME, SANDBOX_PATH.
make_sandbox() {
  SANDBOX="$(mktemp -d)"
  FAKE_HOME="$SANDBOX/home"
  mkdir -p "$FAKE_HOME" "$SANDBOX/bin"
  ln -s "$(command -v chezmoi)" "$SANDBOX/bin/chezmoi"
  SANDBOX_PATH="$SANDBOX/bin:/usr/bin:/bin"
}

# Write a fake command that prints the given output and succeeds
write_fake() {
  local name="$1" output="${2:-}"
  printf '#!/bin/bash\nprintf "%%s" %q\n' "$output" >"$SANDBOX/bin/$name"
  chmod +x "$SANDBOX/bin/$name"
}

# Run a smoke check in the sandbox. Returns its exit status.
run_smoke() {
  HOME="$FAKE_HOME" PATH="$SANDBOX_PATH" bash "$SMOKE_DIR/$1" >"$SANDBOX/out.log" 2>&1
}

# Assert the exit status of a smoke check. A failed check must exit 1, so
# other errors (e.g. a missing script or command: 127) are not mistaken for it.
expect() {
  local want="$1" desc="$2" script="$3" got=0
  run_smoke "$script" || got=$?
  if { [ "$want" = pass ] && [ "$got" -eq 0 ]; } ||
    { [ "$want" = fail ] && [ "$got" -eq 1 ]; }; then
    pass "$desc"
  else
    fail "$desc" "exit status: $got" "output:" "$(cat "$SANDBOX/out.log")"
  fi
  rm -rf "$SANDBOX"
}

# ---------------------------------------------------------
# sheldon.sh
# ---------------------------------------------------------
make_sandbox
write_fake zsh
expect fail "sheldon: fails without plugins.lock" sheldon.sh

make_sandbox
write_fake zsh
mkdir -p "$FAKE_HOME/.local/share/sheldon"
touch "$FAKE_HOME/.local/share/sheldon/plugins.lock"
expect pass "sheldon: passes with plugins.lock" sheldon.sh

# ---------------------------------------------------------
# nvim.sh
# ---------------------------------------------------------
make_sandbox
write_fake nvim
expect fail "nvim: fails without lazy.nvim dir" nvim.sh

make_sandbox
write_fake nvim
mkdir -p "$FAKE_HOME/.local/share/nvim/lazy/lazy.nvim"
expect pass "nvim: passes with lazy.nvim dir" nvim.sh

# ---------------------------------------------------------
# gomi.sh
# ---------------------------------------------------------
make_sandbox
expect fail "gomi: fails without gomi binary" gomi.sh

make_sandbox
mkdir -p "$FAKE_HOME/go/bin"
touch "$FAKE_HOME/go/bin/gomi"
expect pass "gomi: passes with gomi binary" gomi.sh

# ---------------------------------------------------------
# yazi-packages.sh
# ---------------------------------------------------------
make_sandbox
write_fake ya "$(printf 'Plugins:\n\tyazi-rs/plugins:smart-enter (f703392)\nFlavors:\n')"
expect fail "yazi-packages: fails when a listed package is missing" yazi-packages.sh

make_sandbox
write_fake ya "$(printf 'Plugins:\n\tyazi-rs/plugins:smart-enter (f703392)\n\tyazi-rs/plugins:full-border (f703392)\nFlavors:\n')"
expect pass "yazi-packages: passes when all listed packages are installed" yazi-packages.sh

# ---------------------------------------------------------
# im-conf.sh: must match the environment.d rule in .chezmoiignore
# ---------------------------------------------------------
im_sandbox() {
  local os_id="$1" with_conf="$2"
  make_sandbox
  printf 'ID=%s\n' "$os_id" >"$SANDBOX/os-release"
  if [ "$with_conf" = yes ]; then
    mkdir -p "$FAKE_HOME/.config/environment.d"
    touch "$FAKE_HOME/.config/environment.d/im.conf"
  fi
  export OS_RELEASE="$SANDBOX/os-release"
}

im_sandbox arch yes
expect pass "im-conf: passes on arch with im.conf" im-conf.sh
im_sandbox arch no
expect fail "im-conf: fails on arch without im.conf" im-conf.sh
im_sandbox manjaro yes
expect fail "im-conf: fails on non-arch with im.conf" im-conf.sh
im_sandbox manjaro no
expect pass "im-conf: passes on non-arch without im.conf" im-conf.sh

# macOS has no os-release
make_sandbox
export OS_RELEASE="$SANDBOX/missing-os-release"
mkdir -p "$FAKE_HOME/.config/environment.d"
touch "$FAKE_HOME/.config/environment.d/im.conf"
expect fail "im-conf: fails without os-release when im.conf exists" im-conf.sh
unset OS_RELEASE

finish
