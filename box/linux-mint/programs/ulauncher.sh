#!/bin/bash

dpkg -l ulauncher && echo 'Ulauncher already installed ' && exit 0 || echo 'Installing Ulauncher'

cd /tmp

LATEST_VERSION=`get-latest-github-release "Ulauncher/Ulauncher"`
FILENAME="ulauncher_${LATEST_VERSION}_all.deb"

wget -qnc https://github.com/Ulauncher/Ulauncher/releases/download/${LATEST_VERSION}/${FILENAME}
sudo dpkg -i ${FILENAME}
sudo apt install -y -f
