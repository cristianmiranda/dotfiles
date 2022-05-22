#!/bin/bash

dpkg -l git-delta && echo 'git-delta already installed ' && exit 0 || echo 'Installing git-delta'

cd /tmp

LATEST_VERSION=`get-latest-github-release dandavison/delta`
FILENAME="git-delta_${LATEST_VERSION}_amd64.deb"

wget -qnc https://github.com/dandavison/delta/releases/download/${LATEST_VERSION}/${FILENAME}
sudo dpkg -i ${FILENAME}
