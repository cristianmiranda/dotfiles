#!/bin/bash

# i3
sudo apt-get -y install i3 \
                        i3lock \
                        i3lock-fancy \
                        compton \
                        hsetroot \
                        rofi \
                        xsettingsd \
                        lxappearance \
                        scrot \
                        viewnior \
                        acpi \
                        indent \
                        libanyevent-i3-perl # Required for i3 layout saving

# i3-gaps
sudo apt-get -y install i3-gaps-wm i3-gaps-session i3-gaps

# See https://github.com/justbuchanan/i3scripts/blob/master/autoname_workspaces.py
sudo pip3 install i3ipc
sudo pip3 install fontawesome
