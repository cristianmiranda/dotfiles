#!/bin/bash

. ${UTILS_PATH}/ui.sh

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ $INSTALL_WORK =~ n|N ]];
then
    warning ">>> Skipping work stuff..."
    exit 0
fi
