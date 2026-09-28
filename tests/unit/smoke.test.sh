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
  write_fake_script "$name" "printf '%s' $(printf '%q' "$output")"
}

# Write a fake command with the given script body. Any existing file is
# removed first, so a symlink to a real command is never written through.
write_fake_script() {
  local name="$1" body="$2"
  rm -f "$SANDBOX/bin/$name"
  printf '#!/bin/bash\n%s\n' "$body" >"$SANDBOX/bin/$name"
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

make_sandbox
write_fake_script zsh 'echo "zshrc: command not found: foo" >&2'
mkdir -p "$FAKE_HOME/.local/share/sheldon"
touch "$FAKE_HOME/.local/share/sheldon/plugins.lock"
expect fail "sheldon: fails when zsh startup prints errors" sheldon.sh

# ---------------------------------------------------------
# nvim.sh
# ---------------------------------------------------------
make_sandbox
write_fake nvim
expect fail "nvim: fails without lazy.nvim dir" nvim.sh

make_sandbox
write_fake nvim
mkdir -p "$FAKE_HOME/.local/share/nvim/lazy"
expect fail "nvim: fails when lazy.nvim itself is not installed" nvim.sh

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
expect fail "gomi: fails when gomi is not executable" gomi.sh

make_sandbox
mkdir -p "$FAKE_HOME/go/bin"
touch "$FAKE_HOME/go/bin/gomi"
chmod +x "$FAKE_HOME/go/bin/gomi"
expect pass "gomi: passes with executable gomi binary" gomi.sh

# ---------------------------------------------------------
# yazi-packages.sh
# ---------------------------------------------------------
listed=()
while IFS= read -r pkg; do listed+=("$pkg"); done < <(listed_yazi_packages)

make_sandbox
write_fake ya "$(ya_pkg_list_output "${listed[@]:1}")"
expect fail "yazi-packages: fails when a listed package is missing" yazi-packages.sh

make_sandbox
write_fake ya "$(ya_pkg_list_output "${listed[@]}")"
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

# ---------------------------------------------------------
# chezmoi-verify.sh
# ---------------------------------------------------------
make_sandbox
write_fake_script chezmoi '[ "$1" = verify ] && exit 1; echo "M .zshrc"'
expect fail "chezmoi-verify: fails when targets differ from the source state" chezmoi-verify.sh

make_sandbox
write_fake_script chezmoi 'exit 0'
expect pass "chezmoi-verify: passes when targets match the source state" chezmoi-verify.sh

finish
