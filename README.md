# dotfiles

<!-- Badges section - can be reverted if needed -->
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

### Core
```bash
sudo pacman -S stow git zsh hyprland waybar ghostty helix starship fastfetch ttf-hack-nerd
```

### Optional
```bash
# Development tools
sudo pacman -S zed mise

# Enhanced CLI tools
sudo pacman -S eza fzf bat zoxide lazygit lazydocker

# Python tooling
sudo pacman -S uv

# Database tools
sudo pacman -S postgresql harlequin

# Image processing
sudo pacman -S imagemagick

# Command correction
yay -S thefuck  # AUR package
```

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/rwwiv/.dotfiles-arch.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Install GNU Stow if not already installed:
   ```bash
   sudo pacman -S stow
   ```

3. Stow the packages you want:
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

### Key Bindings (Hyprland)

| Shortcut | Action |
|----------|--------|
| `Super + Enter` | Open terminal |
| `Super + Shift + F` | File manager |
| `Super + Shift + B` | Browser |
| `Super + Shift + N` | Editor |
| `Super + Shift + T` | Activity monitor (btop) |
| `Super + Shift + /` | Password manager |

See `hypr/.config/hypr/bindings.conf` for full list.

### Shell Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `ls` | `eza -lh --group-directories-first --icons=auto` | Enhanced file listing |
| `la` | `ls -a` | List all files |
| `lt` | `eza --tree --level=2 --long --icons --git` | Tree view |
| `ff` | `fzf --preview 'bat ...'` | Fuzzy find with preview |
| `cd` | `zoxide` | Smart directory jumping |
| `lg` | `lazygit` | Git TUI |
| `ld` | `lazydocker` | Docker TUI |
| `hx` | `helix` | Helix editor |
| `hq` | `harlequin` | Database TUI |

### Useful Functions

- `compress <dir>` - Create tar.gz archive
- `decompress <file>` - Extract tar.gz archive
- `img2jpg <file>` - Convert image to JPG
- `create_postgres_db <user> <pass> [db]` - Create PostgreSQL database
- `tunnelctl up|down|status <name>` - Manage named SSH tunnels

See `zsh/.zsh/conf/` for full configuration.

## Customization

Each package is self-contained and can be modified independently. After making changes:

1. Edit the files in the respective package directory
2. Changes are automatically reflected (symlinks)
3. Commit and push your changes

## Unstowing

To remove symlinks for a package:

```bash
stow -D package-name
```

## License

These are my personal dotfiles. Feel free to use, modify, or learn from anything you find useful.

