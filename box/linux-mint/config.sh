#!/bin/bash

. ${UTILS_PATH}/ui.sh
. ${UTILS_PATH}/path.sh

if [[ $APPLY_CONFIG =~ n|N ]];
then
    warning ">>> Skipping config..."
    exit 0
fi

# Allowing SSH connections
info ">>> Allowing SSH connections..."
sudo ufw allow ssh >> $LOG_FILE 2>&1
