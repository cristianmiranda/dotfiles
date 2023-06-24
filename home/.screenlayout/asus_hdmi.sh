#!/bin/sh

LAPTOP_DISPLAY=`xrandr --query | grep "eDP" | awk '{print $1}'`

xrandr --output DP-0 --off --output DP-1 --off --output HDMI-0 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output $LAPTOP_DISPLAY --off
