#!/bin/bash

. ${UTILS_PATH}/ui.sh
. ${UTILS_PATH}/packages.sh

if [[ $INSTALL_PACKAGES =~ n|N ]];
then
    warning ">>> Skipping Packages..."
    exit 0
fi

# mtrack & dispad dependencies
PACKAGES=(
    build-essential
    pkg-config
    libmtdev-dev
    mtdev-tools
    xserver-xorg-dev
    xutils-dev
    libconfuse-dev
    libxi-dev
)

for pkg in ${PACKAGES[@]}; do
    aptInstall $pkg
done
