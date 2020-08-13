#!/bin/sh
xrandr --output $1 --off                                                    \
       --output $2 --mode 2560x1440 --pos 0x0 --rotate normal               \
