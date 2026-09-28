# Shared helpers for unit tests. Source this at the top of each test file.

failures=0

pass() { echo "PASS: $1"; }
fail() {
  echo "FAIL: $1"
  shift
  printf '  %s\n' "$@"
  failures=$((failures + 1))
}

# Print the summary and exit non-zero if any test failed
finish() {
  if [ "$failures" -gt 0 ]; then
    echo "$failures test(s) failed"
    exit 1
  fi
  echo "all tests passed"
}

# Print the yazi packages listed in .chezmoidata, one per line.
# Requires SOURCE_DIR.
listed_yazi_packages() {
  chezmoi --source "$SOURCE_DIR" execute-template \
    '{{ range .yazi.packages }}{{ . }}{{ "\n" }}{{ end }}'
}

# Print "ya pkg list" output for the given packages
ya_pkg_list_output() {
  local pkg
  echo "Plugins:"
  for pkg in "$@"; do
    printf '\t%s (f703392)\n' "$pkg"
  done
  echo "Flavors:"
}
