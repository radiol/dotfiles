# CI Failure Visibility Improvement

**Date:** 2026-06-03
**Status:** Approved

## Problem

`chezmoi init --apply` runs all installation scripts in a single CI step, producing large log output. When a failure occurs, it is difficult to identify which script and which line caused the failure in the GitHub Actions UI.

## Goal

- Make the failing script and line immediately visible in the GitHub Actions UI
- Collapse healthy script output so failures stand out

## Approach

Add two GitHub Actions annotations to every script under `scripts/`:

1. **`::error::` trap** - outputs a red annotation with the file name, line number, and failing command when `set -e` triggers an exit
2. **`::group::` / `::endgroup::` blocks** - collapses script output so only failing groups remain expanded

## ERR Trap Pattern

Insert immediately after the shebang, before any `::group::` line:

```bash
trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR
```

GitHub Actions renders this as a red annotation:

```
Command failed: sudo reflector --country "Japan" ...
  arch.sh line 9
```

## Per-Script Changes

| Script | ERR trap | ::group:: added |
|---|---|---|
| `arch.sh` | yes | yes - "ArchLinux Mirror Setup" |
| `brew.sh` | yes | yes - "Homebrew" |
| `manjaro.sh` | yes | yes - "Manjaro Mirror Setup" |
| `darwin.sh` | yes | no (already has "Homebrew") |
| `go.sh` | yes | no (already has "Install go apps") |
| `mise.sh` | yes | no (already has two groups) |
| `pacman.sh` | yes | no (already has "Pacman Install Apps") |
| `rust.sh` | yes | no (already has "Install Rust") |
| `ubuntu.sh` | yes | no (already has "Ubuntu Install Apps") |
| `udevgothic.sh` | yes | no (already has "UDEV Gothic Font") |
| `uv.sh` | yes | no (already has "Install uv") |
| `delete-chezmoi.sh` | yes | no (simple cleanup, no group needed) |

## Expected UI Behavior

**On success:** Each script's output is collapsed under its group heading.

**On failure:**
- The failing group stays expanded
- A red `::error::` annotation appears with the exact file and line number
- Healthy groups remain collapsed above

## Out of Scope

- Job Summary output (not needed given the above annotations)
- Workflow restructuring (splitting `chezmoi init --apply` into separate steps)
- Notification changes
