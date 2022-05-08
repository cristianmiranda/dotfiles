#!/bin/bash

. ${UTILS_PATH}/ui.sh
. ${UTILS_PATH}/packages.sh
. ${UTILS_PATH}/path.sh

if [[ $INSTALL_PACKAGES =~ n|N ]];
then
    warning ">>> Skipping Packages..."
    exit 0
fi

PACKAGES=(
    bat
    docker
    docker-compose
    emojify
    fd
    git-delta-bin
    git-lfs
    go
    inetutils
    jq
    neofetch
    nodejs-gitmoji-cli
    pyenv
    pyenv-virtualenv
    ranger
    screen
    tmux
    unrar
    unzip
    vim
    xclip
    yq
    zip
    zsh
)

PIP_PACKAGES=(
    pipenv-shebang
    pipenv
)

# Reinstall pambase
# See https://bbs.archlinux.org/viewtopic.php?id=142720
yayInstall pambase >> $LOG_FILE 2>&1

# Update keys
gpg --refresh-keys --keyserver hkps://keys.openpgp.org

for pkg in ${PACKAGES[@]}; do
    yayInstall $pkg
done

for pkg in ${PIP_PACKAGES[@]}; do
    pip3Install $pkg
done
