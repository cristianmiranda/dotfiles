#!/bin/bash

#
# System
#
crontab ~/.crontab &
$HOME/bin/exterminate sxhkd; mkfifo /tmp/sxhkd.fifo || true; sxhkd -t 10 -s /tmp/sxhkd.fifo &
$HOME/bin/exterminate sxhkd-listener; $HOME/bin/sxhkd-listener &

#
# Apps
#
( $HOME/bin/exterminate fusuma; fusuma & )
if [[ ! $(hostname) =~ 'virt' ]]; then picom -b; fi &
killall dunst; dunst -print | tee $HOME/logs/dunst.log &

#
# Lock Screen
#
killall inactivity-watcher; $HOME/bin/inactivity-watcher --debug --check-interval 10 --limit 600 &
killall hot-corner; $HOME/bin/hot-corner &

#
# Wallpaper
#
# ps aux | grep "variety" | grep -v "grep" || variety &
# ~/bin/set-wallpaper --use-config &
# ~/bin/set-random-wallpaper ~/wallpapers/single/artistic2 &
nitrogen --restore &

#
# i3 custom stuff
#
# ~/.config/i3/scripts/autoname_workspaces.py --norenumber_workspaces --icon_list_format mathematician &
# ~/.config/i3/scripts/alternating_layouts.py &
# autotiling &

#
# Misc
#
# xsettingsd & # Used to scale GTK apps when going 2K <=> 4K
# brightnessctl --device='tpacpi::kbd_backlight' set 1 &
# /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# xmodmap -e "keycode 49 = F13 ordmasculine ordfeminine ordmasculine ordfeminine backslash backslash backslash" &

#
# Polybar
#
~/.config/polybar/launch.sh &
