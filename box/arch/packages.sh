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
    1password
    alsa-firmware
    alsa-ucm-conf
    alsa-utils
    alttab-git
    arandr
    autoconf
    base-devel
    bashtop
    bat
    bluez
    bluez-utils
    blueman
    brightnessctl
    cargo
    chromium
    cmatrix
    copyq
    deluge-gtk
    discord
    docker
    docker-compose
    dunst
    ebtables
    element-desktop
    emojify
    filezilla
    firefox
    firefox-developer-edition
    firefox-nightly
    fd
    ff-theme-util
    ffmpeg
    flameshot
    font-manager
    git-delta-bin
    git-lfs
    go
    hsetroot
    i3-gaps
    i3blocks
    i3blocks-contrib
    imagemagick
    inetutils
    intellij-idea-ultimate-edition-jre
    insync
    jetbrains-toolbox
    jitsi-meet-desktop-bin
    jq
    lazydocker
    libinput-gestures
    libreoffice-still
    lxappearance
    matcha-gtk-theme
    mpv
    neofetch
    nerd-fonts-fira-code
    net-tools
    networkmanager
    networkmanager-openvpn
    network-manager-applet
    nitrogen
    nodejs-gitmoji-cli
    nordvpn-bin
    noto-fonts
    noto-fonts-emoji
    nvidia
    openssh
    optimus-manager
    optimus-manager-qt
    p7zip
    pasystray
    pamixer
    papirus-icon-theme
    pavucontrol
    peek
    picom
    playerctl
    plex-media-player
    polkit-gnome
    postman-bin
    qemu
    rofi
    rofi-calc
    simplescreenrecorder
    screen
    sof-firmware
    sox
    spotify
    steam
    streamlink
    sysstat
    terminator
    telegram-desktop
    timeshift
    thunar
    thunderbird
    tmux
    unrar
    unzip
    virt-manager
    visual-studio-code-bin
    whatsapp-nativefier
    xbindkeys
    xcalib
    xclip
    xcursor-breeze
    xf86-input-libinput
    xfce4-power-manager
    xorg-xev
    xorg-xinput
    xorg-xrandr
    xsettingsd
    yarn
    zip
    zoom
    zsh
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
