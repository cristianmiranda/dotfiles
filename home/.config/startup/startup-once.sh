#!/bin/bash

( eval `ssh-agent -s` & )
( set-display laptop & )
( bluetoothctl power on & )
( setxkbmap es & )
( numlockx & )
( $HOME/bin/tmu --init & )
