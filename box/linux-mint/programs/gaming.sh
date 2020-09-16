#!/bin/bash

function isInstalled {
  dpkg -l $1 &> /dev/null
  echo $?
}


cd /tmp

# Wine
WINE_INSTALLED=`isInstalled winehq-stable`
if [[ $WINE_INSTALLED == 1 ]]; then
  sudo dpkg --add-architecture i386
  wget -nc https://dl.winehq.org/wine-builds/winehq.key
  sudo apt-key add winehq.key
  sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'  # Ubuntu 18.04
  # sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' # Ubuntu 20.04
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DFA175A75104960E
  sudo apt update
  sudo apt install --install-recommends winehq-stable
  # winecfg # Run after installation
fi

# Steam
STEAM_INSTALLED=`isInstalled steam`
if [[ $STEAM_INSTALLED == 1 ]]; then
  wget -O steam.deb "https://cdn.cloudflare.steamstatic.com/client/installer/steam.deb"
  sudo dpkg -i /tmp/steam.deb
fi

# Lutris
# sudo add-apt-repository ppa:lutris-team/lutris
# sudo apt install -y lutris

