#!/bin/bash

. ${UTILS_PATH}/ui.sh
. ${UTILS_PATH}/packages.sh

if [[ $INSTALL_SNAPS =~ n|N ]];
then
    warning ">>> Skipping snaps..."
    exit 0
fi

snapInstall chromium
snapInstall code --classic
snapInstall intellij-idea-ultimate --classic
snapInstall webstorm --classic
