#!/bin/bash

ls ~/.local/bin/dunstify && echo 'dunstify already installed ' && exit 0 || echo 'Installing dunstify'
 
cd /tmp

git clone https://github.com/dunst-project/dunst.git
cd dunst

# Required dependencies
sudo apt-get install -y libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev

make dunstify
sudo cp dunstify ~/.local/bin
sudo chmod 755 ~/.local/bin/dunstify
