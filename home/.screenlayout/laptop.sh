#!/bin/sh
xrandr --output $1 --primary --mode 2880x1800 --pos 0x0 --rotate normal \
       --output eDP-1-2 --off                                           \
       --output HDMI-1 --off                                            \
       --output HDMI-2 --off                                            \
       --output DP-1-6 --off                                            \
       --output DP-1-5 --off                                            \
       --output DP-1-4 --off                                            \
       --output DP-1-3 --off                                            \
       --output DP-2 --off                                              \
       --output DP-1 --off                                              \
       --output DisplayPort-1-2 --off                                   \
       --output DisplayPort-1-3 --off                                   \
       --output DisplayPort-1-4 --off                                   
