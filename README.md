# Dotfiles

## Introduction

Welcome to my dotfiles setup! This configuration is designed to work seamlessly across various popular operating systems, including MacOS, Ubuntu, ArchLinux, and Manjaro. It's organized and managed using some fantastic tools and utilities to enhance your development environment.

[![Chezmoi](https://img.shields.io/badge/Dotfiles%20Manager-Chezmoi-34D058?style=for-the-badge&logo=chezmoi)](https://chezmoi.io)
[![Sheldon](https://img.shields.io/badge/Zsh%20Plugin%20Manager-Sheldon-775DD0?style=for-the-badge&logo=zsh)](https://github.com/rossmacarthur/sheldon)
[![LunarVim](https://img.shields.io/badge/Neovim%20Configuration-LunarVim-5E81AC?style=for-the-badge&logo=neovim)](https://github.com/LunarVim/LunarVim)
[![Volta](https://img.shields.io/badge/Node%2C%20Yarn%2C%20pnpm%20Manager-Volta-228B22?style=for-the-badge&logo=node.js)](https://volta.sh)
[![Rye](https://img.shields.io/badge/Python%20Manager-Rye-306998?style=for-the-badge&logo=python)](https://github.com/davidhalter/rye)

### Dotfiles Manager - Chezmoi

We use **Chezmoi** as the dotfiles manager, ensuring that your configurations stay organized, version-controlled, and easily transferable between systems.

### Zsh Plugin Manager - Sheldon

**Sheldon** is our choice for managing Zsh plugins. It simplifies plugin management, making it easy to enhance your Zsh experience with various plugins and themes.

### Neovim - LunarVim

For an efficient and feature-rich code editing experience, we've configured **LunarVim** to optimize Neovim for your development needs.

### Node, Yarn, pnpm - Volta

**Volta** is your go-to solution for managing Node.js and its package managers, including Yarn and pnpm. It ensures that your JavaScript and TypeScript projects are always using the correct versions.

### Python - Rye

We rely on **Rye** to manage Python environments and packages, simplifying Python development and ensuring consistency across projects.

## Package Managers

Depending on your operating system, we use different package managers to ensure a smooth installation and management of software packages.

- **MacOS and Ubuntu:** We use **Homebrew** to handle package management, offering a vast array of software readily available for your convenience.

- **ArchLinux and Manjaro:** These systems take advantage of the powerful **pacman** package manager for efficient software installation and updates.

## Installation

To get started with these dotfiles, follow these steps:

1. Open your terminal.

2. Run the following command to install Chezmoi (if you haven't already):

   ```sh
   /bin/bash -c "$(curl -fsLS chezmoi.io/get)" -- init --apply radiol
   ```

   Alternatively, if Chezmoi is already installed, you can simply initialize and apply the dotfiles with:

   ```sh
   chezmoi init --apply radiol
   ```

With this setup, you'll have a beautifully organized and powerful development environment, ready to take on any coding challenge.

[![Tested on MacOS](https://img.shields.io/badge/Tested%20on-MacOS-000000?style=for-the-badge&logo=apple)](https://www.apple.com/macos/)
[![Tested on Ubuntu](https://img.shields.io/badge/Tested%20on-Ubuntu-E95420?style=for-the-badge&logo=ubuntu)](https://ubuntu.com)
[![Tested on ArchLinux](https://img.shields.io/badge/Tested%20on-ArchLinux-1793D1?style=for-the-badge&logo=arch-linux)](https://archlinux.org)
[![Tested on Manjaro](https://img.shields.io/badge/Tested%20on-Manjaro-35BF5C?style=for-the-badge&logo=manjaro-linux)](https://manjaro.org)

Enjoy your enhanced productivity and the aesthetic charm of your customized dotfiles!
