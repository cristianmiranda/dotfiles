#!/bin/bash

ls /usr/local/firefox_dev && echo 'Firefox DEV already installed ' && exit 0 || echo 'Installing firefox DEV'
 
cd /tmp

curl --location "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US" | tar --extract --verbose --preserve-permissions --bzip2

sudo mv firefox /usr/local/firefox_dev
