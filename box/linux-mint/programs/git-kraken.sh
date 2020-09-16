#!/bin/bash

function isInstalled {
  dpkg -l $1 &> /dev/null
  echo $?
}

GIT_KRAKEN_INSTALLED=`isInstalled gitkraken`

if [[ $GIT_KRAKEN_INSTALLED == 1 ]]; then
  sudo apt install -y gconf2
  cd /tmp
  wget -O gitkraken.deb "https://release.gitkraken.com/linux/gitkraken-amd64.deb"
  sudo dpkg -i /tmp/gitkraken.deb
else
  echo "Git Kraken GUI is already installed"
fi

