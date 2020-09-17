#!/bin/bash

# https://github.com/sharkdp/fd

dpkg -l fd && echo 'fd already installed ' && exit 0 || echo 'Installing fd'

cd /tmp

LATEST_VERSION=`get-latest-github-release "sharkdp/fd" | sed 's/v//g'`
FILENAME="fd_${LATEST_VERSION}_amd64.deb"

wget -qnc https://github.com/sharkdp/fd/releases/download/v${LATEST_VERSION}/${FILENAME}
sudo dpkg -i ${FILENAME}

