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
( solaar -w hide & )
( pasystray & )
( alttab -d 1 -w 1 -i 100x100 -t 100x100 -bg "#222D31" -frame "#1793d1" -s 2 & )
( openrgb --server & ); sleep 10; openrgb --mode static --color ff0000
( copyq --start-server & )
if [[ ! $(hostname) =~ 'virt' ]]; then $HOME/bin/exterminate insync; QT_AUTO_SCREEN_SCALE_FACTOR=1 insync start; fi &
