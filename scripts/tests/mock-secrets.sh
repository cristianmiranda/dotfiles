#!/usr/bin/env bash

DOTFILES_DIR=$1

for s in $(cat $DOTFILES_DIR/.gitsecret/paths/mapping.cfg); do 
    SECRET_FILE=`echo $s | awk -F ':' '{ print $1 }'`
    touch $DOTFILES_DIR/$SECRET_FILE
done
