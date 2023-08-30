#!/bin/bash

rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

ln -sfn ~/.config/nvim-nvchad-custom ~/.config/nvim/lua/custom

