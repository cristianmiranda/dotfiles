#!/bin/bash

ls /usr/local/bumblebee-status && echo 'bumblebee-status already installed ' && exit 0 || echo 'Installing bumblebee-status'
 
cd ~/bumblebee-status
git remote add upstream git@github.com:tobi-wan-kenobi/bumblebee-status.git
git fetch upstream

sudo ln -s ~/bumblebee-status /usr/local/.

pip3 install setuptools
pip3 install configparser
pip3 install psutil
pip3 install black

sudo apt install -y python3-tk
