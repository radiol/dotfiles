# dotfiles

For MacOS, Ubuntu, ArchLinux, Manjaro。
Apps:
chezmoi
zsh: sheldon
neovim: lazy.nvim
Rust: cargo
Node: volta
Python: asdf, poetry

Package Manager
MaxOS, Ubuntu -> Homebrew
ArchLinux, Manjaro -> pacman

# Install

```
/bin/bash -c "$(curl -fsLS chezmoi.io/get)" -- init --apply radiol && \
/bin/bash ~/.local/share/chezmoi/run_once_install.sh
```

# Update

## dotfiles の設定変更

### dotfiles の編集(.zshrc の場合)

編集だけでは設定に反映されない

```
chezmoi edit .zshrc
```

### 変更の反映

```
chezmoi apply -v
```

## remote(GitHub)の変更を local に適用

```
chezmoi update -v
```

## local の変更を GitHub へ push

```
chezmoi git -- add -A
chezmoi git -- commit
chezmoi git -- push origin main
``
```
