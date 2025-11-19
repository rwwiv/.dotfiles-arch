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

## Setup

```bash
# Install yadm
sudo pacman -S yadm

# Clone dotfiles
yadm clone https://github.com/rwwiv/.dotfiles-arch.git

# Run bootstrap (installs packages, sets up system)
yadm bootstrap
```

## Notes

- Managed with [yadm](https://yadm.io/)
- Bootstrap script handles packages, services, and `/etc` symlinks
- Use `yadm` commands like git (e.g., `yadm status`, `yadm commit`)
- `ylg` alias for lazygit with yadm

## License

Personal dotfiles. Use freely.

