#!/bin/bash

. ${UTILS_PATH}/ui.sh
. ${UTILS_PATH}/path.sh

if [[ $APPLY_CONFIG =~ n|N ]];
then
    warning ">>> Skipping config..."
    exit 0
fi

info ">>> Allowing SSH connections..."
sudo ufw allow ssh >> $LOG_FILE 2>&1

info ">>> Disable suspend / hibernate when idle..."
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target >> $LOG_FILE 2>&1
