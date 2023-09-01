#!/bin/bash

# Setup a minimal profile execution on boot
echo "source ~/dotfiles/home/profiles/anonymous.sh" >> ~/.bash_profile

# Dotbot sync
cd ~/dotfiles
git clone git@github.com:anishathalye/dotbot.git || wget -O dotbot.zip https://github.com/anishathalye/dotbot/archive/refs/heads/master.zip && unzip dotbot.zip && mv dotbot-master dotbot && rm dotbot.zip
bash ~/dotfiles/dotbot/bin/dotbot -v -c ~/dotfiles/home/dotbot.anonymous.conf.yaml

# Apply config
source ~/.bash_profile
