#!/bin/bash

sudo pacman --noconfirm -Syu
sudo pacman --noconfirm -S go gcc git

git clone https://aur.archlinux.org/yay.git ~/yay
cd ~/yay
makepkg --noconfirm -i
cd -

yay --noconfirm -Syyu
yay --noconfirm -S python-pip git-secret figlet lolcat

pip list --format=columns | grep setuptools || pip install setuptools
pip list --format=columns | grep click || pip install click
pip list --format=columns | grep PyYAML || pip install PyYAML
