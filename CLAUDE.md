# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive dotfiles repository for managing system configurations across Linux (Arch), macOS, and server environments. It uses Dotbot for symlink management and includes extensive automation scripts.

## Common Commands

### Sync/Update Dotfiles
```bash
dotsync
```

### Installation
```bash
# Fresh install (interactive)
./scripts/install.sh

# Deploy to new system
curl -L git.io/dot.deploy -o /tmp/cm.files && bash /tmp/cm.files
```

### Testing Changes
```bash
# Test shell configuration changes
source ~/.zshrc    # For zsh changes
source ~/.bashrc   # For bash changes

# Reload i3 window manager config
i3-msg reload      # Reload config
i3-msg restart     # Restart i3

# Test polybar changes
~/.config/polybar/launch.sh
```

## Architecture & Structure

### Core Components

1. **Dotbot Configuration** (`home/dotbot.*.conf.yaml`)
   - Platform-specific symlink configurations
   - Determines which files get linked where based on system type
   - Auto-detected by `scripts/sync.sh` based on hostname/OS

2. **Shell Environment** (`home/profiles/`)
   - `common.sh`: Shared environment variables and functions
   - `work.sh`: Work-specific configurations (SSH keys, VPN)
   - `private.sh`: Personal configurations
   - Sourced by both `.zshrc` and `.bashrc`

3. **Window Manager Stack** (Linux only)
   - i3 window manager with custom keybindings and workspaces
   - Polybar for status bars (multiple monitors supported)
   - Rofi for application launching
   - Dunst for notifications

4. **Custom Scripts** (`home/bin/`)
   - Extensive collection of automation scripts
   - Added to PATH automatically
   - Includes display management, audio controls, system utilities

### Key Design Patterns

1. **Profile-Based Configuration**
   - Work vs personal environments separated via profiles
   - Environment detection happens in shell startup

2. **Platform Detection**
   - Automatic OS/hostname detection in scripts
   - Different dotbot configs for different platforms
   - Conditional loading in shell configs

3. **Modular Config Loading**
   - Shell configs source from `profiles/` directory
   - i3 config uses includes for machine-specific settings
   - Polybar modules loaded dynamically

## Important Files to Know

- `home/.config/i3/config` - Main i3 window manager configuration
- `home/.config/polybar/` - Status bar configurations and modules
- `home/profiles/common.sh` - Core shell environment setup
- `home/bin/` - Custom scripts directory (automatically in PATH)
- `scripts/sync.sh` - Main dotfiles synchronization script
- `box/arch/install.sh` - Arch Linux package installation script

## Working with This Repository

1. **Making Changes**: Edit files in the `home/` directory, then run `./scripts/sync.sh` to update symlinks
2. **Adding New Dotfiles**: Add to appropriate dotbot config file and run sync
3. **Platform-Specific Changes**: Use the appropriate dotbot config file for the target platform
4. **Testing**: Most configs can be reloaded without restarting (see Testing Changes section)
