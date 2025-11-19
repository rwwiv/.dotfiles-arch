# dotfiles

![Arch Linux](https://img.shields.io/badge/Arch%20Linux-1793D1?style=flat&logo=arch-linux&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-58E1FF?style=flat&logo=wayland&logoColor=black)

Personal dotfiles for Arch Linux + Hyprland.

![Desktop Screenshot](.github/screenshot.png)

## Stack

- **OS**: Arch Linux
- **WM**: Hyprland
- **Shell**: Zsh
- **Terminal**: Ghostty
- **Editor**: Neovim
- **Bar**: Waybar

## Installation

### Interactive (First Time)

```bash
# Prerequisites
sudo pacman -S zsh

# Clone and run installer
git clone https://github.com/rwwiv/.dotfiles-arch.git ~/.dotfiles
cd ~/.dotfiles
./install
```

### Automated (Ansible + Mise)

```bash
# Prerequisites
sudo pacman -S ansible mise
mise run install-collections

# Full setup
cd ~/.dotfiles
mise run install
```

## Tasks

```bash
# List all available tasks
mise tasks

# Common tasks
mise run install        # Full setup (packages + services + stow + system)
mise run packages       # Install packages
mise run stow           # Stow all dotfiles
mise run hypr           # Stow Hyprland + Waybar
mise run desktop        # Stow desktop environment (hypr + waybar)
mise run dotfiles       # Stow common configs (git + ssh + shell + terminal)
```

Tasks use dependencies, so `mise run install` automatically runs: packages → services → stow → system.

## License

Personal dotfiles. Use freely.

