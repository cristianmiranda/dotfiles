#!/bin/bash

DESTINATION=~/.local/bin

ls $DESTINATION/Telegram/Telegram && echo 'Telegram already installed ' && exit 0 || echo 'Installing Telegram'
 
cd $DESTINATION
curl --location "https://telegram.org/dl/desktop/linux" | tar -J --extract --verbose --preserve-permissions

chmod +x $DESTINATION/Telegram/Telegram
