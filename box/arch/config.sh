#!/bin/bash

. ${UTILS_PATH}/ui.sh
. ${UTILS_PATH}/path.sh

if [[ $APPLY_CONFIG =~ n|N ]];
then
    warning ">>> Skipping config..."
    exit 0
fi

# Sets computer's bell off
xset -b

# Enable/Start NetworkManager
sudo systemctl enable NetworkManager.service >> $LOG_FILE 2>&1
sudo systemctl start NetworkManager.service >> $LOG_FILE 2>&1

# Enable/Start bluetooth
sudo systemctl enable bluetooth.service >> $LOG_FILE 2>&1
sudo systemctl start bluetooth.service >> $LOG_FILE 2>&1

# Enable/Start ssh server
sudo systemctl enable sshd >> $LOG_FILE 2>&1
sudo systemctl start sshd >> $LOG_FILE 2>&1

# Setup libinput gestures
sudo gpasswd -a $USER input >> $LOG_FILE 2>&1
libinput-gestures-setup service >> $LOG_FILE 2>&1

# Virtualization (virt-manager)
sudo systemctl enable libvirtd >> $LOG_FILE 2>&1
sudo systemctl start libvirtd >> $LOG_FILE 2>&1
sudo usermod -G libvirt -a cmiranda

# Yubikey Manager
sudo systemctl enable pcscd.service
sudo systemctl start pcscd.service

# auto-cpufreq
sudo systemctl enable auto-cpufreq
sudo systemctl start auto-cpufreq

# tmux plugin manager
# Run prefix + I to install plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#
# If Spotify or Virt-Manager cannot connect to the internet
# replace the contents of /usr/lib/NetworkManager/conf.d/20-connectivity.conf
# with the following (create the file if doesn't exist):
#
# [connectivity]
# .set.enabled=false
#
# See more @ https://wiki.archlinux.org/title/NetworkManager#Checking_connectivity
# and more @ https://www.reddit.com/r/archlinux/comments/jltdb9/arch_linux_spotify_stuck_offiline/gkxicuy?utm_source=share&utm_medium=web2x&context=3
#
# Then restart NetworkManager service
#

#
# Backup
#
# /opt/escribe
# ~/.config/systemd
# ~/.m2/repository/com/drfirst
#
