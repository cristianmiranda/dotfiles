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
    accountsservice
    acpi_call
    alsa-firmware
    alsa-ucm-conf
    alsa-utils
    alttab-git
    arandr
    authy
    auto-cpufreq
    autoconf
    autojump
    base-devel
    bashtop
    bat
    bluez
    bluez-utils
    blueman
    brave-bin
    brightnessctl
    caffeine-ng
    cargo
    cawbird-git
    chromium
    cmatrix
    cloud-sql-proxy-bin
    copyq
    cups
    deluge-gtk
    discord
    docker
    docker-compose
    dunst
    ebtables
    edk2-ovmf
    element-desktop
    emojify
    espeak
    extra/bind
    filezilla
    firefox
    firefox-developer-edition
    firefox-nightly
    fd
    ff-theme-util
    ffmpeg
    flameshot
    font-manager
    freerdp
    git-delta-bin
    git-lfs
    gitkraken
    go
    google-cloud-sdk
    gtkpod
    hplip
    hsetroot
    i3-gaps
    i3blocks
    i3blocks-contrib
    i3lock-color-git
    imagemagick
    inetutils
    intellij-idea-ultimate-edition-jre
    insync
    jetbrains-toolbox
    jitsi-meet-desktop-bin
    jq
    keepassxc
    korganizer
    kubectl
    lazydocker
    libinput-gestures
    libreoffice-fresh
    lxappearance
    matcha-gtk-theme
    meld
    mpv
    navi
    neofetch
    nerd-fonts-fira-code
    net-tools
    networkmanager
    networkmanager-openvpn
    network-manager-applet
    nitrogen
    nodejs-gitmoji-cli
    nordvpn-bin
    notion-app-enhanced
    noto-color-emoji-fontconfig
    noto-fonts
    noto-fonts-emoji
    nvidia
    okular
    openssh
    optimus-manager-git
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
    proton-ge-custom-bin
    pyenv
    pyenv-virtualenv
    python-spotdl
    qalculate-gtk
    qemu
    ranger
    redli
    rofi
    rofi-calc
    rofi-emoji
    ruby-colorls
    simplescreenrecorder
    skypeforlinux-stable-bin
    screen
    slack-desktop
    sof-firmware
    sops
    sox
    spotify
    steam
    streamlink
    sysstat
    system-config-printer
    teamviewer
    terminator
    telegram-desktop
    termdown
    timeshift
    thunar
    thunderbird
    tmux
    tlp
    tlpui-git
    unrar
    unzip
    variety
    virt-manager
    visual-studio-code-bin
    whatsapp-nativefier
    xbindkeys
    xcalib
    xclip
    xcursor-breeze
    xf86-input-libinput
    xfce4-power-manager
    xmlstarlet
    xorg-xev
    xorg-xinput
    xorg-xrandr
    xsettingsd
    yarn
    yq
    youtube-dl
    yubikey-manager-qt
    zip
    zoom
    zsh
)

PIP_PACKAGES=(
    pipenv-shebang
    pipenv
    PyPDF2
    osascript
    bpytop
    i3ipc
    fontawesome
    nsz
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
