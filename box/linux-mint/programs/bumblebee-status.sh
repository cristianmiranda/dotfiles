#!/bin/bash

ls /usr/local/bumblebee-status && echo 'bumblebee-status already installed ' && exit 0 || echo 'Installing bumblebee-status'
 
cd ~/bumblebee-status
git remote add upstream git@github.com:tobi-wan-kenobi/bumblebee-status.git
git fetch upstream

sudo ln -s ~/bumblebee-status /usr/local/.
