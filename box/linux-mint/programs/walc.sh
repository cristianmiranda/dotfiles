#!/bin/bash

ls ~/.local/bin/walc && echo 'WALC already installed ' && exit 0 || echo 'Installing WALC'
 
DESTINATION=~/.local/bin
LATEST_VERSION=`get-latest-github-release "cstayyab/WALC" | sed 's/v//g'`
FILENAME=walc.AppImage

mkdir -p $DESTINATION
cd $DESTINATION

wget https://github.com/cstayyab/WALC/releases/download/${LATEST_VERSION}/$FILENAME

mv $FILENAME walc
chmod +x walc
