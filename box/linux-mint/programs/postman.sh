#!/bin/bash

ls /usr/local/postman && echo 'Postman already installed ' && exit 0 || echo 'Installing Postman'
 
cd /tmp

curl --location "https://dl.pstmn.io/download/latest/linux64" | tar -z --extract --verbose --preserve-permissions

sudo mv Postman /usr/local/postman
