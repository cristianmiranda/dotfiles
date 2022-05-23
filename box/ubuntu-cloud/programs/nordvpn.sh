#!/bin/bash

# https://support.nordvpn.com/Connectivity/Linux/1325531132/Installing-and-using-NordVPN-on-Debian-Ubuntu-Elementary-OS-and-Linux-Mint.htm

dpkg -l nordvpn && echo 'NordVPN already installed ' && exit 0 || echo 'Installing NordVPN'

cd /tmp

wget -qnc https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
sudo dpkg -i nordvpn-release_1.0.0_all.deb

sudo apt-get update
sudo apt install -y nordvpn
