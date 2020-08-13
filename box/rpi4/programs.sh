#!/bin/bash

. ${UTILS_PATH}/ui.sh
. ${UTILS_PATH}/path.sh

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ $INSTALL_PROGRAMS =~ n|N ]];
then
    warning ">>> Skipping programs..."
    exit 0
fi

for f in $CURRENT_DIR/programs/*.sh; do 
  info ">>> ${f}"
  bash "$f" -H >> $LOG_FILE 2>&1; 
done
