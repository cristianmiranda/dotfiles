#!/bin/bash
 
USER=cmiranda
 
grep -q close /proc/acpi/button/lid/*/state
 
if [ $? = 0 ]; then
  su -c  "sleep 1 && xset -display :0.0 dpms force off" - $USER
fi
 
grep -q open /proc/acpi/button/lid/*/state
 
if [ $? = 0 ]; then
  su -c  "xset -display :0 dpms force on &> /tmp/screen.lid" - $USER
fi
