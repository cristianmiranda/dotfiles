#!/bin/bash

# Setup a minimal profile execution on boot
echo "source ~/dotfiles/home/profiles/esh-server.sh" >> ~/.bash_profile

# Sync with Dotbot
. ~/.bash_profile
dotsync
