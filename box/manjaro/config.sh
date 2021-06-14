#!/bin/bash

. ${UTILS_PATH}/ui.sh
. ${UTILS_PATH}/path.sh

if [[ $APPLY_CONFIG =~ n|N ]];
then
    warning ">>> Skipping config..."
    exit 0
fi

# Allowing SSH connections
# info ">>> Allowing SSH connections..."
# sudo ufw allow ssh >> $LOG_FILE 2>&1

sudo gpasswd -a $USER input >> $LOG_FILE 2>&1
libinput-gestures-setup service >> $LOG_FILE 2>&1
libinput-gestures-setup autostart start >> $LOG_FILE 2>&1

# Sets computer's bell off
xset -b

#
# Improve audio
#
# See more @ https://forum.manjaro.org/t/pulseeffects-issues-with-pipewire/52890
# Presets: https://github.com/JackHack96/PulseEffects-Presets
#
sudo pacman -Rdd pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-ctl pulseaudio-equalizer pulseaudio-jack pulseaudio-lirc pulseaudio-rtp pulseaudio-zeroconf pulseaudio-equalizer-ladspa >> $LOG_FILE 2>&1
sudo pacman -Rdd pulseeffects-legacy >> $LOG_FILE 2>&1
sudo pacman -S manjaro-pipewire gst-plugin-pipewire pulseeffects >> $LOG_FILE 2>&1
sudo pacman -S xdg-desktop-portal xdg-desktop-portal-gtk >> $LOG_FILE 2>&1
systemctl --user unmask pipewire.socket && systemctl --user enable --now pipewire.socket >> $LOG_FILE 2>&1

