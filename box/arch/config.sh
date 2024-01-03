#!/bin/bash

. ${UTILS_PATH}/ui.sh
. ${UTILS_PATH}/path.sh

if [[ $APPLY_CONFIG =~ n|N ]]; then
    warning ">>> Skipping config..."
    exit 0
fi

# Sets computer's bell off
xset -b

# Battery
# sudo systemctl enable tlp.service >>$LOG_FILE 2>&1
# sudo systemctl start tlp.service >>$LOG_FILE 2>&1
# sudo systemctl mask systemd-rfkill.service >>$LOG_FILE 2>&1
# sudo systemctl mask systemd-rfkill.socket >>$LOG_FILE 2>&1

# Enable/Start NetworkManager
sudo systemctl enable NetworkManager.service >>$LOG_FILE 2>&1
sudo systemctl start NetworkManager.service >>$LOG_FILE 2>&1

# Enable/Start bluetooth
sudo systemctl enable bluetooth.service >>$LOG_FILE 2>&1
sudo systemctl start bluetooth.service >>$LOG_FILE 2>&1

# Enable/Start ssh server
sudo systemctl enable sshd >>$LOG_FILE 2>&1
sudo systemctl start sshd >>$LOG_FILE 2>&1

# Virtualization (virt-manager)
sudo systemctl enable libvirtd >>$LOG_FILE 2>&1
sudo systemctl start libvirtd >>$LOG_FILE 2>&1
sudo usermod -G libvirt -a cmiranda >>$LOG_FILE 2>&1

# Yubikey Manager
sudo systemctl enable pcscd.service >>$LOG_FILE 2>&1
sudo systemctl start pcscd.service >>$LOG_FILE 2>&1

# SDDM
sudo systemctl enable sddm >>$LOG_FILE 2>&1

# Audio
sudo systemctl enable rtkit-daemon.service >>$LOG_FILE 2>&1
sudo systemctl start rtkit-daemon.service >>$LOG_FILE 2>&1
sudo systemctl --user enable pipewire >>$LOG_FILE 2>&1
sudo systemctl --user start pipewire >>$LOG_FILE 2>&1

# Input (fusuma mouse gestures)
sudo usermod -G input -a cmiranda >>$LOG_FILE 2>&1

# Enable/Start cronie
sudo systemctl enable cronie >>$LOG_FILE 2>&1
sudo systemctl start cronie >>$LOG_FILE 2>&1

# auto-cpufreq
# sudo systemctl enable auto-cpufreq >>$LOG_FILE 2>&1
# sudo systemctl start auto-cpufreq >>$LOG_FILE 2>&1

# xsettingsd daemon
sudo systemctl --user enable xsettingsd.service >>$LOG_FILE 2>&1
sudo systemctl --user start xsettingsd.service >>$LOG_FILE 2>&1

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
