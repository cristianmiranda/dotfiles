#!/bin/bash

. ${UTILS_PATH}/packages.sh
. ${UTILS_PATH}/ui.sh

if [[ $INSTALL_PACKAGES =~ n|N ]];
then
    warning ">>> Skipping Packages..."
    exit 0
fi

aptUpgrade

PACKAGES=(
    figlet
    git
    htop
    jq
    lolcat
    neofetch
    nodejs
    npm
    p7zip-full
    python3-pip
    ranger
    tree
    vim
    zsh
)

for pkg in ${PACKAGES[@]}; do
    aptInstall $pkg
done
