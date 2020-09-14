#!/bin/bash

dpkg -l discord && echo 'Discord already installed ' && exit 0 || echo 'Installing Discord'

cd /tmp

wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"

sudo dpkg -i /tmp/discord.deb

