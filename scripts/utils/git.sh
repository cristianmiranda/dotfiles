#!/bin/bash

. ${UTILS_PATH}/ui.sh
. ${UTILS_PATH}/path.sh

function gitClone {
  if [ ! -d $2 ]; then
    info "${RED}>>> Cloning ${1} into ${2} ...${NC}"
    git clone ${1} ${2} >> $LOG_FILE 2>&1
  else
    info ">>> ${2} already exists"
  fi
}
