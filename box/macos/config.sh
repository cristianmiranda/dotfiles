#!/bin/bash

. ${UTILS_PATH}/ui.sh
. ${UTILS_PATH}/path.sh

if [[ $APPLY_CONFIG =~ n|N ]];
then
    warning ">>> Skipping config..."
    exit 0
fi

# ~/.macos — https://mths.be/macos

# Some inspiration
# https://github.com/stephen-huan/macos_dotfiles#configuration

# Ask for the administrator password upfront
sudo -v

info ">>> Disable 'app is damaged and can't be opened' warning"
sudo spctl --master-disable >> $LOG_FILE 2>&1
