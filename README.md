# dotfiles

![Arch Linux](https://img.shields.io/badge/Arch%20Linux-1793D1?style=flat&logo=arch-linux&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-58E1FF?style=flat&logo=wayland&logoColor=black)
![Zsh](https://img.shields.io/badge/Zsh-F15A24?style=flat&logo=gnu-bash&logoColor=white)
![Helix](https://img.shields.io/badge/Helix-281733?style=flat&logo=helix&logoColor=white)
![Maintained](https://img.shields.io/badge/Maintained%3F-yes-green.svg)

Personal configuration files for my Arch Linux + Hyprland setup.

## Overview

This repository contains my dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Each directory represents a package that can be symlinked independently to `$HOME`.

## Screenshot

![Desktop Screenshot](.github/screenshot.png)

## System

- **OS**: Arch Linux
- **WM**: Hyprland
- **Shell**: Zsh
- **Terminal**: Ghostty
- **Editor**: Helix, Zed
- **Prompt**: Starship
- **Bar**: Waybar

## Dependencies

### Prerequisites

- **zsh** - Required for shell configuration and custom scripts. Install before running the installer:
  ```bash
  sudo pacman -S zsh
  ```

Package lists are provided in `pkglist.txt` (core) and `pkglist-optional.txt` (optional). The [interactive installer](#quick-start-recommended) will handle installing these automatically.

## Installation

### Quick Start (Recommended)

1. Install zsh (if not already installed):
   ```bash
   sudo pacman -S zsh
   ```

2. Install [yay](https://github.com/Jguer/yay) (AUR helper) - see their [installation instructions](https://github.com/Jguer/yay#installation)

3. Clone this repository:
   ```bash
   git clone https://github.com/rwwiv/.dotfiles-arch.git ~/.dotfiles
   cd ~/.dotfiles
   ```

   **Note:** This repository uses Git LFS for images (wallpapers and screenshots).

4. Run the interactive installer:
   ```bash
   ./install
   ```

   The installer will:
   - Install gum (if needed) for interactive prompts
   - Guide you through installing core and optional packages
   - Let you choose which dotfiles to stow to your home directory

### Manual Installation

If you prefer manual installation:

1. Install zsh (if not already installed):
   ```bash
   sudo pacman -S zsh
   ```

2. Install [yay](https://github.com/Jguer/yay) (AUR helper) - see their [installation instructions](https://github.com/Jguer/yay#installation)

3. Install packages manually:
   ```bash
   # Core packages (required)
   yay -S --needed - < pkglist.txt

   # Optional packages
   yay -S --needed - < pkglist-optional.txt
   ```

4. Stow the packages you want:
   ```bash
   # Stow individual packages
   stow zsh
   stow helix
   stow hypr

   # Or stow everything
   stow */
   ```

## Project Structure

```
.
├── bin/              # Custom scripts and utilities
├── fastfetch/        # System information tool config
├── ghostty/          # Ghostty terminal emulator
├── git/              # Git configuration and ignore patterns
├── helix/            # Helix editor configuration
├── hide_icons/       # Desktop file overrides to hide unwanted apps from launcher
├── hypr/             # Hyprland window manager config
├── mise/             # Runtime version manager (formerly rtx)
├── ssh/              # SSH configuration
├── starship/         # Starship prompt configuration
├── systemd/          # User systemd services
├── wallpapers/       # Wallpaper collection
├── waybar/           # Waybar status bar config
├── zed/              # Zed editor configuration
└── zsh/              # Zsh shell configuration and aliases
```

## Features

- **Zsh Configuration**: Custom aliases, functions, and shell setup
- **Hyprland Setup**: Tiling window manager configuration with autostart
- **Modern Development Tools**: Helix and Zed editor configurations
- **Git Workflow**: Custom commit message templates and ignore patterns
- **Terminal Experience**: Ghostty terminal with Starship prompt
- **Version Management**: mise for managing runtime versions

## Quick Reference

### Custom Scripts

- `setup-btrfs-trim` - Configure TRIM support for encrypted btrfs systems
  - Adds `:allow-discards` to LUKS cryptdevice parameter
  - Adds `discard=async` to btrfs rootflags
  - Interactive prompts using `gum` with automatic backup/restore
  - Usage: `sudo setup-btrfs-trim`
- `upgrade-pg` - PostgreSQL database upgrade helper
  - Simplifies major version upgrades
  - Usage: `upgrade-pg`
- `create-postgres-db` - Create PostgreSQL database
  - Usage: `create-postgres-db <user> <pass> [db]`
- `tunnelctl` - Manage named SSH tunnels
  - Usage: `tunnelctl up|down|status <name>`

See `bin/.local/bin/` for script sources.

### Useful Functions

- `compress <dir>` - Create tar.gz archive
- `decompress <file>` - Extract tar.gz archive
- `img2jpg <file>` - Convert image to JPG

See `zsh/.zsh/conf/` for full configuration.


## License

These are my personal dotfiles. Feel free to use, modify, or learn from anything you find useful.

