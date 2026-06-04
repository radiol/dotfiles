# CI Failure Visibility Improvement Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add `::error::` ERR traps and `::group::` annotations to all scripts under `scripts/` so GitHub Actions highlights the exact failing line and collapses healthy output.

**Architecture:** Each script gets a single `trap '...' ERR` line after the shebang. Scripts missing `::group::` blocks get them added wrapping the entire body. No shared library — each script is self-contained.

**Tech Stack:** Bash, GitHub Actions log annotations (`::error::`, `::group::`, `::endgroup::`)

---

## File Map

| File | Change |
|---|---|
| `scripts/arch.sh` | Add ERR trap + `::group::ArchLinux Mirror Setup` |
| `scripts/brew.sh` | Add ERR trap + `::group::Homebrew` |
| `scripts/manjaro.sh` | Add ERR trap + `::group::Manjaro Mirror Setup` |
| `scripts/darwin.sh` | Add ERR trap only |
| `scripts/delete-chezmoi.sh` | Add ERR trap only |
| `scripts/go.sh` | Add ERR trap only |
| `scripts/mise.sh` | Add ERR trap only |
| `scripts/pacman.sh` | Add ERR trap only |
| `scripts/rust.sh` | Add ERR trap only |
| `scripts/ubuntu.sh` | Add ERR trap only |
| `scripts/udevgothic.sh` | Add ERR trap only |
| `scripts/uv.sh` | Add ERR trap only |

---

## Task 1: Add ERR trap + group to arch.sh

**Files:**
- Modify: `scripts/arch.sh`

- [ ] **Step 1: Rewrite arch.sh with ERR trap and group**

Replace the full content of `scripts/arch.sh` with:

```bash
#!/bin/bash -xeu

trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR

# ---------------------------------------------------------
# Set Mirror Server for ArchLinux
# ---------------------------------------------------------
echo "::group::ArchLinux Mirror Setup"
echo "Setting ArchLinux mirror servers"
mkdir -p ~/.cache
sudo pacman -Sy -q --noconfirm reflector
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo reflector --country "Japan" --latest 5 --completion-percent 95 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
echo "::endgroup::"
```

- [ ] **Step 2: Check syntax**

```bash
bash -n scripts/arch.sh
```

Expected: no output (syntax OK)

- [ ] **Step 3: Commit**

```bash
git add scripts/arch.sh
git commit -m "feat(ci): add error trap and group to arch.sh"
```

---

## Task 2: Add ERR trap + group to manjaro.sh

**Files:**
- Modify: `scripts/manjaro.sh`

- [ ] **Step 1: Rewrite manjaro.sh with ERR trap and group**

Replace the full content of `scripts/manjaro.sh` with:

```bash
#!/bin/bash -xeu

trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR

# ---------------------------------------------------------
# Set Mirror Server for Manjaro
# ---------------------------------------------------------
echo "::group::Manjaro Mirror Setup"
echo "Setting Manjaro mirror servers"
mkdir -p ~/.cache
sudo pacman-mirrors -c Japan
sudo pacman-mirrors --fasttrack
echo "::endgroup::"
```

- [ ] **Step 2: Check syntax**

```bash
bash -n scripts/manjaro.sh
```

Expected: no output (syntax OK)

- [ ] **Step 3: Commit**

```bash
git add scripts/manjaro.sh
git commit -m "feat(ci): add error trap and group to manjaro.sh"
```

---

## Task 3: Add ERR trap + group to brew.sh

**Files:**
- Modify: `scripts/brew.sh`

- [ ] **Step 1: Rewrite brew.sh with ERR trap and group**

Replace the full content of `scripts/brew.sh` with:

```bash
#!/bin/bash -xeu

trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR

# ---------------------------------------------------------
# Install Homebrew
# ---------------------------------------------------------
echo "::group::Homebrew"

# Check Homebrew
if ! (type "brew" >/dev/null 2>&1); then
  # Install Homebrew
  echo "Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Activate Homebrew path
  if [[ -d "/opt/homebrew" ]]; then
    HOMEBREW_HOME="/opt/homebrew"
  elif [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
    HOMEBREW_HOME="/home/linuxbrew/.linuxbrew"
  else
    HOMEBREW_HOME="/usr/local"
  fi
  eval "$("$HOMEBREW_HOME"/bin/brew shellenv)"
fi

# ---------------------------------------------------------
# Clean up Homebrew
# ---------------------------------------------------------
echo "Cleaning up Homebrew"
brew uninstall --ignore-dependencies cmake || true
brew update-reset && brew update

# ---------------------------------------------------------
# Install Homebrew Apps
# ---------------------------------------------------------
echo "Installing Homebrew Apps"
brew install -q --cask font-hack-nerd-font
brew install -q \
  aicommit2 \
  cmake \
  direnv \
  fd \
  fzf \
  git \
  go \
  gopass \
  jq \
  lazygit \
  luarocks \
  neovim \
  node \
  openssl@3 \
  readline \
  sqlite3 \
  tcl-tk \
  xclip \
  xz \
  zlib \
  zsh

echo "::endgroup::"
```

- [ ] **Step 2: Check syntax**

```bash
bash -n scripts/brew.sh
```

Expected: no output (syntax OK)

- [ ] **Step 3: Commit**

```bash
git add scripts/brew.sh
git commit -m "feat(ci): add error trap and group to brew.sh"
```

---

## Task 4: Add ERR trap to darwin.sh

**Files:**
- Modify: `scripts/darwin.sh`

- [ ] **Step 1: Insert ERR trap after shebang**

In `scripts/darwin.sh`, insert the following line after `#!/bin/bash -xeu` (line 1):

```bash
trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR
```

The file should begin:

```bash
#!/bin/bash -xeu

trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR

# ---------------------------------------------------------
# Install Homebrew
# ---------------------------------------------------------
echo "::group::Homebrew"
```

- [ ] **Step 2: Check syntax**

```bash
bash -n scripts/darwin.sh
```

Expected: no output (syntax OK)

- [ ] **Step 3: Commit**

```bash
git add scripts/darwin.sh
git commit -m "feat(ci): add error trap to darwin.sh"
```

---

## Task 5: Add ERR trap to delete-chezmoi.sh

**Files:**
- Modify: `scripts/delete-chezmoi.sh`

- [ ] **Step 1: Insert ERR trap after shebang**

In `scripts/delete-chezmoi.sh`, insert after `#!/bin/bash -xeu`:

```bash
trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR
```

The file should begin:

```bash
#!/bin/bash -xeu

trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR

# ----------------------------------------------------------------------------
# Remove chezmoi
# ----------------------------------------------------------------------------
```

- [ ] **Step 2: Check syntax**

```bash
bash -n scripts/delete-chezmoi.sh
```

Expected: no output (syntax OK)

- [ ] **Step 3: Commit**

```bash
git add scripts/delete-chezmoi.sh
git commit -m "feat(ci): add error trap to delete-chezmoi.sh"
```

---

## Task 6: Add ERR trap to go.sh

**Files:**
- Modify: `scripts/go.sh`

- [ ] **Step 1: Insert ERR trap after shebang**

In `scripts/go.sh`, insert after `#!/bin/bash -xeu`:

```bash
trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR
```

The file should begin:

```bash
#!/bin/bash -xeu

trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR

echo "::group::Install go apps"
```

- [ ] **Step 2: Check syntax**

```bash
bash -n scripts/go.sh
```

Expected: no output (syntax OK)

- [ ] **Step 3: Commit**

```bash
git add scripts/go.sh
git commit -m "feat(ci): add error trap to go.sh"
```

---

## Task 7: Add ERR trap to mise.sh

**Files:**
- Modify: `scripts/mise.sh`

- [ ] **Step 1: Insert ERR trap after shebang**

In `scripts/mise.sh`, insert after `#!/bin/bash -xeu`:

```bash
trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR
```

The file should begin:

```bash
#!/bin/bash -xeu

trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR

# ---------------------------------------------------------
# Install Mise
# ---------------------------------------------------------
echo "::group::Install Mise"
```

- [ ] **Step 2: Check syntax**

```bash
bash -n scripts/mise.sh
```

Expected: no output (syntax OK)

- [ ] **Step 3: Commit**

```bash
git add scripts/mise.sh
git commit -m "feat(ci): add error trap to mise.sh"
```

---

## Task 8: Add ERR trap to pacman.sh

**Files:**
- Modify: `scripts/pacman.sh`

- [ ] **Step 1: Insert ERR trap after shebang**

In `scripts/pacman.sh`, insert after `#!/bin/bash -xeu`:

```bash
trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR
```

The file should begin:

```bash
#!/bin/bash -xeu

trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR

# ---------------------------------------------------------
# Setup Pacman
# ---------------------------------------------------------
echo "::group:: Pacman Install Apps"
```

- [ ] **Step 2: Check syntax**

```bash
bash -n scripts/pacman.sh
```

Expected: no output (syntax OK)

- [ ] **Step 3: Commit**

```bash
git add scripts/pacman.sh
git commit -m "feat(ci): add error trap to pacman.sh"
```

---

## Task 9: Add ERR trap to rust.sh

**Files:**
- Modify: `scripts/rust.sh`

- [ ] **Step 1: Insert ERR trap after shebang**

In `scripts/rust.sh`, insert after `#!/bin/bash -xeu`:

```bash
trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR
```

The file should begin:

```bash
#!/bin/bash -xeu

trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR

# ---------------------------------------------------------
# Install Rust
# ---------------------------------------------------------
echo "::group::Install Rust"
```

- [ ] **Step 2: Check syntax**

```bash
bash -n scripts/rust.sh
```

Expected: no output (syntax OK)

- [ ] **Step 3: Commit**

```bash
git add scripts/rust.sh
git commit -m "feat(ci): add error trap to rust.sh"
```

---

## Task 10: Add ERR trap to ubuntu.sh

**Files:**
- Modify: `scripts/ubuntu.sh`

- [ ] **Step 1: Insert ERR trap after shebang**

In `scripts/ubuntu.sh`, insert after `#!/bin/bash -xeu`:

```bash
trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR
```

The file should begin:

```bash
#!/bin/bash -xeu

trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR

# ---------------------------------------------------------
# Install apps for Ubuntu
# ---------------------------------------------------------
echo "::group::Ubuntu Install Apps"
```

- [ ] **Step 2: Check syntax**

```bash
bash -n scripts/ubuntu.sh
```

Expected: no output (syntax OK)

- [ ] **Step 3: Commit**

```bash
git add scripts/ubuntu.sh
git commit -m "feat(ci): add error trap to ubuntu.sh"
```

---

## Task 11: Add ERR trap to udevgothic.sh

**Files:**
- Modify: `scripts/udevgothic.sh`

- [ ] **Step 1: Insert ERR trap after shebang**

In `scripts/udevgothic.sh`, insert after `#!/bin/bash -xeu`:

```bash
trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR
```

The file should begin:

```bash
#!/bin/bash -xeu

trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR

echo "::group::UDEV Gothic Font"
```

- [ ] **Step 2: Check syntax**

```bash
bash -n scripts/udevgothic.sh
```

Expected: no output (syntax OK)

- [ ] **Step 3: Commit**

```bash
git add scripts/udevgothic.sh
git commit -m "feat(ci): add error trap to udevgothic.sh"
```

---

## Task 12: Add ERR trap to uv.sh

**Files:**
- Modify: `scripts/uv.sh`

- [ ] **Step 1: Insert ERR trap after shebang**

In `scripts/uv.sh`, insert after `#!/bin/bash -xeu`:

```bash
trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR
```

The file should begin:

```bash
#!/bin/bash -xeu

trap 'echo "::error::file=${BASH_SOURCE[0]},line=${LINENO}::Command failed: ${BASH_COMMAND}"' ERR

# ---------------------------------------------------------
# Install uv
# ---------------------------------------------------------

echo "::group::Install uv"
```

- [ ] **Step 2: Check syntax**

```bash
bash -n scripts/uv.sh
```

Expected: no output (syntax OK)

- [ ] **Step 3: Commit**

```bash
git add scripts/uv.sh
git commit -m "feat(ci): add error trap to uv.sh"
```
