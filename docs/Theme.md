# 🎨 Themes

- [🎨 Themes](#-themes)
  - [🔄 How the Theme System Works](#-how-the-theme-system-works)
  - [🖌️ Available Themes](#️-available-themes)
  - [🔧 Changing Themes](#-changing-themes)
    - [Files That Need Modification](#files-that-need-modification)
    - [Manual Configuration Process](#manual-configuration-process)
    - [Updating Individual Applications](#updating-individual-applications)
      - [1. Alacritty Terminal](#1-alacritty-terminal)
      - [2. Neovim (NvChad)](#2-neovim-nvchad)
      - [3. Polybar](#3-polybar)
      - [4. Rofi Powermenu](#4-rofi-powermenu)
      - [5. i3 Window Manager](#5-i3-window-manager)
      - [6. Dunst Notifications](#6-dunst-notifications)
      - [7. Tmux](#7-tmux)
      - [8. Wallpaper (Nitrogen)](#8-wallpaper-nitrogen)
      - [9. Dark Reader (Firefox Extension)](#9-dark-reader-firefox-extension)
      - [10. Spotify (using Spicetify)](#10-spotify-using-spicetify)
  - [🎨 Using Theme Colors in Scripts](#-using-theme-colors-in-scripts)
  - [🆕 Creating Custom Themes](#-creating-custom-themes)
  - [🔄 Theme Structure](#-theme-structure)
    - [Base Colors](#base-colors)
    - [Text and UI Elements](#text-and-ui-elements)
    - [Background Elements](#background-elements)
  - [🌈 Example: Manual Theme Switching](#-example-manual-theme-switching)


This document explains how the theme system works and how to change themes across the system.

## 🔄 How the Theme System Works

The theme system uses a centralized configuration approach with theme files stored in `~/.config/themes/`. Each theme has its own YAML file (e.g., `catppuccin-mocha.yml`, `one-dark.yml`) that defines color values. The current theme is specified in `~/.config/themes/config.yml`.

The `~/bin/theme` script reads these configuration files and extracts color values, making them available to various applications throughout the system.

## 🖌️ Available Themes

Currently, the following themes are available:

- **Catppuccin Mocha**: A soothing pastel theme with dark background
- **One Dark**: A darker theme based on the Atom editor's One Dark theme

## 🔧 Changing Themes

The theme script no longer supports automatic theme switching. You'll need to manually update configurations for individual applications.

### Files That Need Modification

When switching themes, the following files must be modified:

1. `~/.config/themes/config.yml` - Central theme configuration
2. `~/.config/alacritty/alacritty.toml` - Terminal colors configuration
3. `~/.config/nvim-nvchad-lua/chadrc.lua` - Neovim theme configuration
4. `~/.config/polybar/config.ini` - Status bar theme
5. `~/.config/rofi/powermenu/styles/colors.rasi` - Rofi menu colors
6. `~/.config/i3/config` - i3 window manager colors
7. `~/.config/dunst/dunstrc` - Notification colors and styles
8. `~/.tmux.conf` - Tmux terminal multiplexer colors

### Manual Configuration Process

To manually update the theme:

1. Update the `current` value in `~/.config/themes/config.yml`:

```bash
echo "current: one-dark" > ~/.config/themes/config.yml
```

2. Update individual applications as described below.

### Updating Individual Applications

#### 1. Alacritty Terminal

Edit `~/.config/alacritty/alacritty.toml` and update the import line:

```toml
import = ["/home/cmiranda/.config/alacritty/themes/one-dark.toml"]
```

#### 2. Neovim (NvChad)

Edit `~/.config/nvim-nvchad-lua/chadrc.lua` and update the theme setting:

```lua
M.ui = {
  theme = "onedark",  -- or "catppuccin"
  -- other settings...
}
```

#### 3. Polybar

Edit `~/.config/polybar/config.ini` and update the include-file line:

```ini
include-file = ~/.config/polybar/themes/one-dark.ini
```

Then restart Polybar:

```bash
killall polybar && ~/.config/polybar/launch.sh
```

#### 4. Rofi Powermenu

Edit `~/.config/rofi/powermenu/styles/colors.rasi` and update the color definitions to match your theme.

#### 5. i3 Window Manager

Edit `~/.config/i3/config` and update the theme colors section:

For Catppuccin-Mocha theme:
```
# Catppuccin-Mocha Theme Colors
#
# class                   border      backgr.    text       indic.     child_border
client.focused          #89B4FA   #1E1E2E  #CDD6F4  #F5E0DC  #B4BEFE
client.focused_inactive #313244   #313244  #BAC2DE  #45475A  #1E1E2E
client.unfocused        #313244   #313244  #BAC2DE  #45475A
client.urgent           #F38BA8   #1E1E2E  #F2CDCD  #F38BA8
client.placeholder      #1E1E2E   #1E1E2E  #CDD6F4  #1E1E2E
client.background       #1E1E2E
```

For One-Dark theme (example):
```
# One-Dark Theme Colors
#
# class                   border      backgr.    text       indic.     child_border
client.focused          #61AFEF   #282C34  #ABB2BF  #E06C75  #98C379
client.focused_inactive #3E4452   #3E4452  #ABB2BF  #5C6370  #282C34
client.unfocused        #3E4452   #3E4452  #ABB2BF  #5C6370
client.urgent           #E06C75   #282C34  #E5C07B  #E06C75
client.placeholder      #282C34   #282C34  #ABB2BF  #282C34
client.background       #282C34
```

After modifying, reload i3 configuration:
```bash
i3-msg reload
```

#### 6. Dunst Notifications

Edit `~/.config/dunst/dunstrc` and update the color settings:

For Catppuccin-Mocha theme:
```
# Appearance
frame_color = "#b4befe" # Catppuccin-Mocha lavender

# Urgency levels
[urgency_low]
background = "#1E1E2E"  # base
foreground = "#CDD6F4"  # text

[urgency_normal]
background = "#1E1E2E"  # base
foreground = "#CDD6F4"  # text

[urgency_critical]
background = "#F38BA8"  # red
foreground = "#F5E0DC"  # rosewater
frame_color = "#F38BA8"  # red
```

For One-Dark theme (example):
```
# Appearance
frame_color = "#98C379" # One-Dark green

# Urgency levels
[urgency_low]
background = "#282C34"  # base
foreground = "#ABB2BF"  # text

[urgency_normal]
background = "#282C34"  # base
foreground = "#ABB2BF"  # text

[urgency_critical]
background = "#E06C75"  # red
foreground = "#E5C07B"  # yellow
frame_color = "#E06C75"  # red
```

After updating, restart dunst to apply changes:
```bash
killall dunst && dunst &
```

#### 7. Tmux

Edit `~/.tmux.conf` and update the theme-related color settings.

#### 8. Wallpaper (Nitrogen)

Theme-specific wallpapers can be set using Nitrogen:

```bash
nitrogen --set-zoom-fill ~/wallpapers/one-dark/wallpaper.png
```

Or update the paths in `~/.config/nitrogen/bg-saved.cfg` manually.

#### 9. Dark Reader (Firefox Extension)

You can theme the Dark Reader extension for Firefox following these instructions from the [official Catppuccin Dark Reader repository](https://github.com/catppuccin/dark-reader).

![Dark Reader Preview](https://imgur.com/aVsCILC.png)

> [!IMPORTANT]
> If you only want to use _Mocha_, Dark Reader includes **Catppuccin** by
> default, which is Mocha.

1. Open the Dark Reader.
2. Click on **Dev Tools** > **Advance** > **Preview new design** and close the window.
3. Now click on **See all options** > **Colors**.
4. Open your desired flavor in the table below. Copy and paste values into respective fields.
    - You will have to change the "Selection" setting from `Automatic` to `Custom`.


<details>
<summary>🌻 Latte</summary>
<table>
<tr>
<th>Setting</th>
<th>Color</th>
</tr>
<tr>
<td>Background</td>
<td>#eff1f5 </td>
</tr>
<tr>
<td>Text</td>
<td>#4c4f69 </td>
</tr>
<tr>
<td>Selection</td>
<td>#acb0be </td>
</tr>
</table>
</details>

<details>
<summary>🪴 Frappé</summary>
<table>
<tr>
<th>Setting</th>
<th>Color</th>
</tr>
<tr>
<td>Background</td>
<td>#303446 </td>
</tr>
<tr>
<td>Text</td>
<td>#c6d0f5 </td>
</tr>
<tr>
<td>Selection</td>
<td>#626880 </td>
</tr>
</table>
</details>

<details>
<summary>🌺 Macchiato</summary>
<table>
<tr>
<th>Setting</th>
<th>Color</th>
</tr>
<tr>
<td>Background</td>
<td>#24273a </td>
</tr>
<tr>
<td>Text</td>
<td>#cad3f5 </td>
</tr>
<tr>
<td>Selection</td>
<td>#5b6078 </td>
</tr>
</table>
</details>

<details>
<summary>🌿 Mocha</summary>
<table>
<tr>
<th>Setting</th>
<th>Color</th>
</tr>
<tr>
<td>Background</td>
<td>#1e1e2e </td>
</tr>
<tr>
<td>Text</td>
<td>#cdd6f4 </td>
</tr>
<tr>
<td>Selection</td>
<td>#585b70 </td>
</tr>
</table>
</details>


5. Done! There is no apply or save button.

#### 10. Spotify (using Spicetify)

You can customize the Spotify client using [Spicetify](https://spicetify.app/), a powerful CLI tool that allows you to apply themes, extensions, and custom apps to Spotify.

Follow instructions [here](https://github.com/catppuccin/spicetify) to install Spicetify and apply the Catppuccin theme.

![Spicetify](https://imgur.com/h0lu4H0.png)

## 🎨 Using Theme Colors in Scripts

You can use the `theme` script to extract color values for use in other scripts or applications:

```bash
# Get the red color from the current theme
RED=$(~/bin/theme --key red)

# Get the blue color from a specific theme
BLUE=$(~/bin/theme --theme one-dark --key blue)
```

## 🆕 Creating Custom Themes

To create a custom theme:

1. Create a new YAML file in `~/.config/themes/`, e.g., `~/.config/themes/my-theme.yml`
2. Copy the structure from an existing theme file
3. Modify the color values to your preference
4. Create matching theme files for each application:
   - Polybar: `~/.config/polybar/themes/my-theme.ini`
   - Alacritty: `~/.config/alacritty/themes/my-theme.toml`
   - i3: Update color definitions in `~/.config/i3/config`
   - Dunst: Update color definitions in `~/.config/dunst/dunstrc`
   - Update settings in other configuration files listed above
5. Update the `current` value in `~/.config/themes/config.yml`

## 🔄 Theme Structure

Themes define colors in the following categories:

### Base Colors
- rosewater, flamingo, pink, mauve, red, maroon, peach, yellow, green, teal, sky, sapphire, blue, lavender

### Text and UI Elements
- text, subtext1, subtext0, overlay2, overlay1, overlay0, surface2, surface1, surface0

### Background Elements
- base, mantle, crust

## 🌈 Example: Manual Theme Switching

```bash
# 1. Set the current theme
echo "current: one-dark" > ~/.config/themes/config.yml

# 2. Update Alacritty
sed -i 's/catppuccin-mocha.toml/one-dark.toml/' ~/.config/alacritty/alacritty.toml

# 3. Update Neovim NvChad
sed -i 's/theme = "catppuccin"/theme = "onedark"/' ~/.config/nvim-nvchad-lua/chadrc.lua

# 4. Update Polybar
sed -i 's/include-file = ~\/.config\/polybar\/themes\/catppuccin-mocha.ini/include-file = ~\/.config\/polybar\/themes\/one-dark.ini/' ~/.config/polybar/config.ini
killall polybar && ~/.config/polybar/launch.sh

# 5. Update Rofi Powermenu (requires manual editing)
# Edit ~/.config/rofi/powermenu/styles/colors.rasi

# 6. Update i3 config (requires manual editing)
# Edit ~/.config/i3/config and update the theme colors section
# Then reload i3:
i3-msg reload

# 7. Update Dunst (requires manual editing)
# Edit ~/.config/dunst/dunstrc and update the color settings
# Then restart dunst:
killall dunst && dunst &

# 8. Update Tmux (requires manual editing)
# Edit ~/.tmux.conf

# 9. Update wallpaper (optional)
nitrogen --set-zoom-fill ~/wallpapers/one-dark/wallpaper.png
```
