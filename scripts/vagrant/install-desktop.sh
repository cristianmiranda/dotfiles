#!/bin/sh
set -ex

# Create cmiranda's user
USER="cmiranda"
PASSWORD="pass"
groupadd --gid 5000 $USER           \
    && useradd                      \
    --home-dir /home/$USER          \
    --create-home --uid 5000        \
    --gid 5000 --shell /bin/bash    \
    --skel /dev/null $USER          \
    && usermod -aG sudo $USER


# Set password for cmiranda
echo "$USER:$PASSWORD" | chpasswd

# Update
sudo apt-get update

# Install desktop environment
sudo apt-get install -y xfce4
#sudo apt-get install -y ubuntu-mate-core

# Network manager
#sudo apt-get install -y network-manager

# Install virtualbox additions
# (Not sure if these packages could be helpful as well: virtualbox-guest-utils-hwe virtualbox-guest-x11-hwe)
sudo apt-get install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

# Optional: Use LightDM login screen (-> not required to run "startx")
sudo apt-get install -y lightdm lightdm-gtk-greeter

# Create required directories
#mkdir -p /home/$USER/Documents/Work/Workspace

# Changing ownership over new user's home (belong to vagrant)
sudo chown -R $USER:$USER /home/$USER
