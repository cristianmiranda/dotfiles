#!/bin/bash

# Polybar
~/.config/polybar/launch.sh &

# System
docker &
xset -b &
# xsettingsd & # Used to scale GTK apps when going 2K <=> 4K
crontab ~/.crontab &
xfce4-power-manager &
brightnessctl --device='tpacpi::kbd_backlight' set 1 &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# ( xmodmap -e "keycode 49 = F13 ordmasculine ordfeminine ordmasculine ordfeminine backslash backslash backslash" &

# Apps
$HOME/bin/exterminate 1password; 1password --silent &
$HOME/bin/exterminate nm-applet; nm-applet &
$HOME/bin/exterminate blueman-applet; blueman-applet &
$HOME/bin/exterminate copyq; copyq &
$HOME/bin/exterminate pasystray; pasystray &
$HOME/bin/exterminate optimus-manager-qt; optimus-manager-qt &
$HOME/bin/exterminate fusuma; fusuma &
$HOME/bin/exterminate sxhkd; mkfifo /tmp/sxhkd.fifo || true; sxhkd -t 10 -s /tmp/sxhkd.fifo &
$HOME/bin/exterminate sxhkd-listener; $HOME/bin/sxhkd-listener &
$HOME/bin/exterminate alttab; alttab -d 1 -w 1 -i 100x100 -t 100x100 -bg "#222D31" -frame "#1793d1" -s 2 &
if [[ ! $(hostname) =~ 'virt' ]]; then $HOME/bin/exterminate insync; QT_AUTO_SCREEN_SCALE_FACTOR=1 insync start; fi &
if [[ ! $(hostname) =~ 'virt' ]]; then picom -b; fi &

# Lock Screen
killall xidlehook; xidlehook --socket /tmp/xidlehook.sock --not-when-fullscreen --timer 30 "$HOME/bin/lock-screen --recheck-inactivity" "" --timer 600 "$HOME/bin/lock-screen" "" &
killall hot-corner; $HOME/bin/hot-corner &

# Wallpaper
# ( ps aux | grep "variety" | grep -v "grep" || variety &
# ( ~/bin/set-wallpaper --use-config &
# ( ~/bin/set-random-wallpaper ~/wallpapers/single/artistic2 &
nitrogen --restore &

# i3 custom stuff
# ( ~/.config/i3/scripts/autoname_workspaces.py --norenumber_workspaces --icon_list_format mathematician &
# ~/.config/i3/scripts/alternating_layouts.py &
# ( autotiling &

