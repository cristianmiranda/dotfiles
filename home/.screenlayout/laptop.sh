#!/bin/sh

LAPTOP_DISPLAY=`xrandr --query | grep "eDP" | awk '{print $1}'`

xrandr --output DP-0 --off --output DP-1 --off --output HDMI-0 --off --output $LAPTOP_DISPLAY --primary --mode 3840x2160 --pos 0x0 --rotate normal
