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
    ant
    apt-transport-https
    arandr
    autoconf
    cargo
    curl
    dmenu
    dunst
    filezilla
    firefox
    ffmpeg
    fonts-font-awesome
    flameshot
    git
    htop
    hsetroot
    imagemagick
    jq
    maven
    neofetch
    network-manager
    libnotify-bin
    lm-sensors
    openjdk-8-jdk
    openssh-server
    p7zip-full
    pavucontrol
    pidgin
    playerctl
    python3-apt
    python3-dev
    python3-pip
    python3-tk
    python3-venv
    ranger
    simplescreenrecorder
    screen
    snapd
    sox
    terminator
    thunar
    tree
    unrar
    vim
    xcalib
    xclip
    zenity
    zsh
)

for pkg in ${PACKAGES[@]}; do
    aptInstall $pkg
done

aptUpgrade thunderbird
aptUpgrade timeshift
aptUpgrade compton

pip3 install pipenv-shebang
pip3 install termdown

