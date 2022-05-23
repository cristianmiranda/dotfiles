#!/bin/bash

dpkg -l bat && echo 'bat already installed ' && exit 0 || echo 'Installing bat'

cd /tmp

LATEST_VERSION=`get-latest-github-release "sharkdp/bat" | sed 's/v//g'`
DEB_FILENAME=bat-musl_${LATEST_VERSION}_amd64.deb

wget https://github.com/sharkdp/bat/releases/download/v${LATEST_VERSION}/$DEB_FILENAME

sudo dpkg -i $DEB_FILENAME
