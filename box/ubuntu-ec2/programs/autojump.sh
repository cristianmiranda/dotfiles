#!/bin/bash

ls ~/.autojump && echo 'autojump already installed ' && exit 0 || echo 'Installing autojump'

cd /tmp
git clone git@github.com:wting/autojump.git
cd autojump
python3 install.py
