#!/bin/bash
 
USER=cmiranda

#This runs so that root can run the following command under the user's environment
source /home/$USER/.Xdbus

grep -q close /proc/acpi/button/lid/*/state
 
if [ $? = 0 ]; then
  su -c  "sleep 1 && xset -display :0.0 dpms force off" - $USER
  /home/$USER/bin/close_lid
fi

grep -q open /proc/acpi/button/lid/*/state
 
if [ $? = 0 ]; then
  su -c  "xset -display :0 dpms force on &> /tmp/screen.lid" - $USER
  /home/$USER/bin/open_lid
fi
