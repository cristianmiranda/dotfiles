#!/bin/bash

# Setup a minimal profile execution on boot
echo "source ~/dotfiles/home/profiles/anonymous.sh" >> ~/.bash_profile

# Dotbot sync
bash ~/dotfiles/dotbot/bin/dotbot -v -c ~/dotfiles/home/dotbot.anonymous.conf.yaml

# Apply config
source ~/.bash_profile
