#!/bin/bash

# Install dependencies
pip3 install click 
pip3 install setuptools
pip3 install -U PyYAML # Upgrade PyYAML

# Restore & verify crontab for root
crontab /home/cmiranda/dotfiles/box/linux-mint/cron/root.cron
crontab -l
