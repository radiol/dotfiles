# Dotfiles

This repository contains my dotfiles for various operating systems, including MacOS, Ubuntu, ArchLinux, and Manjaro. It includes configuration files for various tools and utilities to customize your development environment.

## Tools Used

- **Dotfiles Manager:** [Chezmoi](https://github.com/twpayne/chezmoi)
- **Zsh Plugin Manager:** [Sheldon](https://github.com/rossmacarthur/sheldon)
- **Neovim Configuration:** [LunarVim](https://github.com/ChristianChiarulli/LunarVim)
- **Node Version Manager:** [Volta](https://github.com/volta-cli/volta)
- **Python Version Manager:** [Rye](https://github.com/delfick/python-rye)
- **Package Managers:**
  - MacOS, Ubuntu: [Homebrew](https://brew.sh/)
  - ArchLinux, Manjaro: [Pacman](https://archlinux.org/pacman/)

## Installation

To set up these dotfiles on your system, simply use the following command:

```shell
/bin/bash -c "$(curl -fsLS chezmoi.io/get)" -- init --apply radiol
```

Or, if you have already cloned this repository:

```shell
chezmoi init --apply radiol
```

Follow the prompts to apply the dotfiles to your system.
