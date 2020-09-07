#!/bin/bash

ls ~/.local/bin/nvim.appimage && echo 'Neovim already installed ' && exit 0 || echo 'Installing Neovim'
 
DESTINATION=~/.local/bin
cd $DESTINATION

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
