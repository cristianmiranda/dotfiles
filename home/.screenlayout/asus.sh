#!/bin/sh
xrandr --output $1 --off                                                    \
       --output $2 --primary --mode 2560x1440 --pos 2560x0 --rotate normal  \
       --output $3 --mode 2560x1440 --pos 0x0 --rotate normal               \
