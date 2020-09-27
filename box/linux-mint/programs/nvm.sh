#!/bin/bash

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

sudo apt-get install -y nodejs

# https://github.com/carloscuesta/gitmoji-cli
sudo npm i -g gitmoji-cli
