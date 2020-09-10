#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ls /usr/local/jitsi-meet && echo 'jitsi-meet already installed ' && exit 0 || echo 'Installing jitsi-meet'
 
cd /tmp
wget https://github.com/jitsi/jitsi-meet-electron/releases/latest/download/jitsi-meet-x86_64.AppImage

sudo mkdir -p /usr/local/jitsi-meet
sudo mv -f jitsi-meet-x86_64.AppImage /usr/local/jitsi-meet/jitsi-meet
sudo cp -f $CURRENT_DIR/icons/jitsi-meet.png /usr/local/jitsi-meet/icon.png
sudo chmod -R 755 /usr/local/jitsi-meet/*
