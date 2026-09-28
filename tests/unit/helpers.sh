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
