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
    adapta-gtk-theme
    ant
    apt-transport-https
    arandr
    autoconf
    breeze-cursor-theme
    cargo
    curl
    dmenu
    faba-icon-theme
    faba-mono-icons
    filezilla
    firefox
    ffmpeg
    fonts-font-awesome
    flameshot
    git
    google-drive-ocamlfuse
    htop
    hsetroot
    imagemagick
    jq
    libnotify-bin
    lm-sensors
    maven
    moka-icon-theme
    neofetch
    network-manager
    openssh-server
    paper-icon-theme
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
    tmux
    tree
    unrar
    vim
    w3w
    w3m-img
    xcalib
    xclip
    xdotool
    zenity
    zsh
)

for pkg in ${PACKAGES[@]}; do
    aptInstall $pkg
done

# Upgrade already installed packages
aptUpgrade thunderbird
aptUpgrade timeshift
aptUpgrade compton

pip3Install pipenv-shebang
pip3Install termdown
pip3Install PyPDF2
pip3Install osascript
pip3Install bpytop

# SDKMAN
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 11.0.8-amzn
