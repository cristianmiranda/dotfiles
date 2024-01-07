#!/bin/bash

#
# Set display
#
( $HOME/bin/set-display dual & )

#
# System
#
( eval `ssh-agent -s` & )
( bluetoothctl power on & )
( setxkbmap es & )
( numlockx & )
( $HOME/bin/tmu --init & )
( docker & )
( xset -b & )

#
# Apps
#
( 1password --silent & )
( nm-applet & )
( blueman-applet & )
( pasystray & )
( alttab -d 1 -w 1 -i 100x100 -t 100x100 -bg "#222D31" -frame "#1793d1" -s 2 & )
