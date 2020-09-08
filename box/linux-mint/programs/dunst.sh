#!/bin/bash

dunstctl debug && echo 'Dunst notifications already installed ' && exit 0 || echo 'Installing Dunst notifications'

cd /tmp

# Required dependencies
sudo apt-get install -y libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev

git clone https://github.com/dunst-project/dunst.git
cd dunst

make
sudo make install
