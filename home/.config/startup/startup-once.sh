#!/bin/bash

( eval `ssh-agent -s` & )
( $HOME/bin/set-display dual & )
( bluetoothctl power on & )
( setxkbmap es & )
( numlockx & )
( $HOME/bin/tmu --init & )
