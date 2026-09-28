#!/bin/bash
# Run all unit tests. Exits non-zero if any test file fails.
# Run from anywhere: bash tests/unit/run.sh

set -u

status=0
for test_file in "$(dirname "${BASH_SOURCE[0]}")"/*.test.sh; do
  echo "== $(basename "$test_file")"
  bash "$test_file" || status=1
done
exit "$status"
