#!/bin/bash

# https://snwh.org/moka/download
sudo add-apt-repository -y ppa:snwh/ppa

# https://github.com/adapta-project/adapta-gtk-theme
sudo add-apt-repository -y ppa:tista/adapta

sudo apt-get update

sudo apt-get -y install moka-icon-theme     \
                        faba-icon-theme     \
                        faba-mono-icons     \
                        adapta-gtk-theme    \
                        paper-icon-theme    \
                        breeze-cursor-theme \
