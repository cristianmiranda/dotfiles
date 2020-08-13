#!/bin/bash

ls /usr/local/bumblebee-status && echo 'bumblebee-status already installed ' && exit 0 || echo 'Installing bumblebee-status'
 
cd /tmp

git clone git@github.com:cristianmiranda/bumblebee-status.git
cd bumblebee-status
git remote add upstream git@github.com:tobi-wan-kenobi/bumblebee-status.git
git fetch upstream

pip3 install setuptools
pip3 install configparser
pip3 install psutil
pip3 install black

sudo mv /tmp/bumblebee-status /usr/local/.

# through pip3
# pip3 install bumblebee-status
