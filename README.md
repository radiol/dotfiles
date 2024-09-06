# Dotfiles

This repository contains my dotfiles for various operating systems, including MacOS, Ubuntu, ArchLinux, and Manjaro. It includes configuration files for various tools and utilities to customize your development environment.

## Tools Used

[![chezmoi](https://img.shields.io/badge/dotfiles%20manager-chezmoi-blue)](https://github.com/twpayne/chezmoi)
[![sheldon](https://img.shields.io/badge/zsh%20plugin%20manager-sheldon-green)](https://github.com/rossmacarthur/sheldon)
[![AstroNvim](https://img.shields.io/badge/Neovim%20configuration-AstroNvim-brightgreen)](https://github.com/AstroNvim/AstroNvim)
[![Volta](https://img.shields.io/badge/Node.js%2C%20Yarn%2C%20pnpm%20version%20manager-Volta-blueviolet)](https://github.com/volta-cli/volta)
[![uv](https://img.shields.io/badge/Python%20version%20manager-uv-red)](https://astral.sh/blog/uv)

- **Dotfiles Manager:** [Chezmoi](https://github.com/twpayne/chezmoi)
- **Zsh Plugin Manager:** [Sheldon](https://github.com/rossmacarthur/sheldon)
- **Neovim Configuration:** [AstroNvim](https://github.com/AstroNvim/AstroNvim)
- **Node Version Manager:** [Volta](https://github.com/volta-cli/volta)
- **Python Version Manager:** [uv](https://astral.sh/blog/uv)
- **Package Managers:**
  - MacOS: [Homebrew](https://brew.sh/)
  - Ubuntu: [apt](https://wiki.debian.org/Apt)
  - ArchLinux, Manjaro: [Pacman](https://archlinux.org/pacman/)

## Installation

To set up these dotfiles on your system, simply use the following command:

```shell
/bin/bash -c "$(curl -fsLS chezmoi.io/get)" -- init --apply radiol
```

Or, if you have already installed chezmoi:

```shell
chezmoi init --apply radiol
```

Follow the prompts to apply the dotfiles to your system.
