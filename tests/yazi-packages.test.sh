#!/bin/bash
# Tests for the chezmoi script that installs yazi packages.
# Run from anywhere: bash tests/yazi-packages.test.sh

set -u

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT_NAME="install-yazi-packages.sh.tmpl"

failures=0

pass() { echo "PASS: $1"; }
fail() {
  echo "FAIL: $1"
  shift
  printf '  %s\n' "$@"
  failures=$((failures + 1))
}

# Find the yazi script in the source dir, whatever attributes it has
find_script() {
  find "$SOURCE_DIR" -maxdepth 1 -name "run_*${SCRIPT_NAME}" | head -n 1
}

# Render the script template with chezmoi using the real .chezmoidata
render_script() {
  local out="$1"
  chezmoi --source "$SOURCE_DIR" execute-template <"$(find_script)" >"$out"
}

# Create a sandbox with a fake HOME and a minimal PATH without ya or mise.
# Sets SANDBOX, FAKE_HOME, CALLS, SANDBOX_PATH.
make_sandbox() {
  SANDBOX="$(mktemp -d)"
  FAKE_HOME="$SANDBOX/home"
  CALLS="$SANDBOX/calls.log"
  mkdir -p "$FAKE_HOME" "$SANDBOX/bin"
  : >"$CALLS"
  # Only expose the tools the script needs, so no real ya/mise leaks in
  local tool
  for tool in bash grep; do
    ln -s "$(command -v "$tool")" "$SANDBOX/bin/$tool"
  done
  SANDBOX_PATH="$SANDBOX/bin"
}

# Write a fake command that logs its arguments and reports no packages
# for "pkg list"
write_fake() {
  local path="$1"
  mkdir -p "$(dirname "$path")"
  cat >"$path" <<EOF
#!/bin/bash
echo "\${0##*/} \$*" >>"$CALLS"
case "\$*" in
  *"pkg list"*) printf 'Plugins:\nFlavors:\n' ;;
esac
EOF
  chmod +x "$path"
}

run_rendered() {
  HOME="$FAKE_HOME" PATH="$SANDBOX_PATH" bash "$SANDBOX/script.sh" >"$SANDBOX/out.log" 2>&1
}

# ---------------------------------------------------------
# The script must run after run_once_install, which installs yazi via mise.
# chezmoi runs scripts without before_/after_ in name order, and
# "install-yazi-packages.sh" sorts before "install.sh".
# ---------------------------------------------------------
test_script_runs_after_other_scripts() {
  local script
  script="$(basename "$(find_script)")"
  if [[ "$script" == run_onchange_after_* ]]; then
    pass "script runs in the after phase"
  else
    fail "script runs in the after phase" "script name: $script"
  fi
}

# ---------------------------------------------------------
# On a fresh machine ya is installed by mise but is not on PATH yet.
# ---------------------------------------------------------
test_uses_mise_when_ya_is_not_on_path() {
  make_sandbox
  write_fake "$FAKE_HOME/.local/bin/mise"
  render_script "$SANDBOX/script.sh"
  run_rendered

  if grep -qx "mise exec yazi -- ya pkg add yazi-rs/plugins:smart-enter" "$CALLS" &&
    grep -qx "mise exec yazi -- ya pkg install" "$CALLS"; then
    pass "uses mise to run ya when ya is not on PATH"
  else
    fail "uses mise to run ya when ya is not on PATH" \
      "calls:" "$(cat "$CALLS")" "output:" "$(cat "$SANDBOX/out.log")"
  fi
  rm -rf "$SANDBOX"
}

test_uses_ya_on_path_directly() {
  make_sandbox
  write_fake "$SANDBOX/bin/ya"
  render_script "$SANDBOX/script.sh"
  run_rendered

  if grep -qx "ya pkg add yazi-rs/plugins:smart-enter" "$CALLS" &&
    grep -qx "ya pkg install" "$CALLS"; then
    pass "uses ya on PATH directly"
  else
    fail "uses ya on PATH directly" \
      "calls:" "$(cat "$CALLS")" "output:" "$(cat "$SANDBOX/out.log")"
  fi
  rm -rf "$SANDBOX"
}

test_skips_when_neither_ya_nor_mise_exists() {
  make_sandbox
  render_script "$SANDBOX/script.sh"

  if run_rendered && grep -q "skipping yazi package install" "$SANDBOX/out.log"; then
    pass "skips when neither ya nor mise exists"
  else
    fail "skips when neither ya nor mise exists" "output:" "$(cat "$SANDBOX/out.log")"
  fi
  rm -rf "$SANDBOX"
}

test_script_runs_after_other_scripts
test_uses_mise_when_ya_is_not_on_path
test_uses_ya_on_path_directly
test_skips_when_neither_ya_nor_mise_exists

if [ "$failures" -gt 0 ]; then
  echo "$failures test(s) failed"
  exit 1
fi
echo "all tests passed"
