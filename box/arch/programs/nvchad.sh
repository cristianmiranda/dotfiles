#!/bin/bash

rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
rm -rf ~/.config/nvim/.git

ln -sfn ~/dotfiles/home/.config/nvim-nvchad-lua ~/.config/nvim/lua
