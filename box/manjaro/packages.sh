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
    alsa-firmware
    alsa-ucm-conf
    alsa-utils
    autoconf
    balena-etcher
    bat
    cargo
    chromium
    discord
    docker
    docker-compose
    element-desktop
    emojify
    filezilla
    firefox
    firefox-developer-edition
    fd
    ffmpeg
    flameshot
    git-delta-bin
    hsetroot
    i3blocks
    i3blocks-contrib
    imagemagick
    intellij-idea-ultimate-edition-jre
    jetbrains-toolbox
    jitsi-meet-electron
    jq
    neofetch
    nitrogen
    nodejs-gitmoji-cli
    noto-fonts-emoji
    nvm
    p7zip
    pavucontrol
    playerctl
    postman-bin
    rofi
    simplescreenrecorder
    screen
    sof-firmware
    sox
    spotify
    sysstat
    terminator
    telegram-desktop-bin
    thunar
    thunderbird
    tmux
    unrar
    unzip
    visual-studio-code-bin
    whatsapp-nativefier
    xclip
    xorg-xev
    yarn
    zip
    zoom
)

PIP_PACKAGES=(
    pipenv-shebang
    termdown
    PyPDF2
    osascript
    bpytop
    i3ipc
    fontawesome
)

# Upgrade everything
yay -Syyu >> $LOG_FILE 2>&1

# Reinstall pambase
# See https://bbs.archlinux.org/viewtopic.php?id=142720
yayInstall pambase >> $LOG_FILE 2>&1

for pkg in ${PACKAGES[@]}; do
    yayInstall $pkg
done

for pkg in ${PIP_PACKAGES[@]}; do
    pip3Install $pkg
done

# Uninstall Palemoon browser
sudo rm /home/*/.local/share/applications/userapp-Pale\ Moon-*.desktop /home/*/.local/share/applications/mimeinfo.cache >> $LOG_FILE 2>&1
sudo rm -rf /usr/bin/palemoon ~/palemoon /usr/share/applications/palemoon.desktop /usr/share/icons/hicolor/*/apps/palemoon.png >> $LOG_FILE 2>&1
