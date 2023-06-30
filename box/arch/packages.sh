#!/bin/bash

. ${UTILS_PATH}/ui.sh
. ${UTILS_PATH}/packages.sh
. ${UTILS_PATH}/path.sh

if [[ $INSTALL_PACKAGES =~ n|N ]]; then
    warning ">>> Skipping Packages..."
    exit 0
fi

PACKAGES=(
    1password
    accountsservice
    acpi
    acpi_call
    alacarte
    alsa-firmware
    alsa-ucm-conf
    alsa-utils
    alttab-git
    arandr
    asciinema
    atool
    autoconf
    autojump-git
    base-devel
    bashtop
    bat
    bluez
    bluez-utils
    blueman
    breeze
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
    easyeffects
    ebtables
    edk2-ovmf
    element-desktop
    emojify
    espeak
    bind
    filezilla
    firefox
    firefox-developer-edition
    fd
    ffmpeg
    flameshot
    font-manager
    freerdp
    git-delta
    git-lfs
    github-copilot-cli
    gitkraken
    go
    google-cloud-sdk
    gqlplus
    gtkpod
    hplip
    hsetroot
    i3-wm
    i3lock-color-git
    imagemagick
    inetutils
    insync
    jetbrains-toolbox
    jitsi-meet-desktop-bin
    jq
    kubectl
    kubectx
    lazydocker
    libinput-gestures
    libreoffice-fresh
    lightdm
    lightdm-gtk-greeter
    lxappearance
    matcha-gtk-theme
    meld
    mousepad
    mpv
    navi
    ncdu
    neofetch
    nerd-fonts-meta
    net-tools
    networkmanager
    networkmanager-openvpn
    network-manager-applet
    nitrogen
    nodejs-gitmoji-cli
    nordvpn-bin
    notion-app
    noto-color-emoji-fontconfig
    noto-fonts
    noto-fonts-emoji
    nvidia
    nvidia-lts
    nvidia-settings
    nvidia-utils
    neovim
    octopi
    okular
    openresolv
    openssh
    optimus-manager-git
    optimus-manager-qt
    oracle-instantclient-sqlplus
    p7zip
    pacman-contrib
    pasystray
    pamixer
    papirus-icon-theme
    pavucontrol
    peek
    picom
    pipewire
    pipewire-audio
    pipewire-pulse
    playerctl
    plex-media-player
    polkit-gnome
    polybar
    postman-bin
    powertop
    pulseaudio-control
    pyenv
    pyenv-virtualenv
    python-spotdl
    qalculate-gtk
    qemu
    qt5ct
    ranger
    rebuild-detector
    redli
    rofi
    rofi-calc
    rofi-emoji
    rtkit
    ruby-fusuma
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
    sxhkd
    sysstat
    system-config-printer
    teamviewer
    terminator
    telegram-desktop
    termdown
    ticktick
    timeshift
    thunar
    thunderbird
    tmux
    tlp
    tlpui-git
    tree
    unrar
    unzip
    variety
    viewnior
    virt-manager
    visual-studio-code-bin
    vlc
    whatsapp-nativefier
    wireplumber
    xarchiverx
    xcalib
    xclip
    xdotool
    xf86-input-libinput
    xfce4-power-manager
    xmlstarlet
    xorg-apps
    xorg-server
    xorg-xinit
    xsettingsd
    xss-lock
    yarn
    yq
    youtube-dl
    yubikey-manager-qt
    zip
    zoom
    zsh
)

PYTHON_PACKAGES=(
    bleak
    i3ipc
    pypdf2
)

# Reinstall pambase
# See https://bbs.archlinux.org/viewtopic.php?id=142720
yayInstall pambase >>$LOG_FILE 2>&1

# Update keys
gpg --refresh-keys --keyserver hkps://keys.openpgp.org

for pkg in ${PACKAGES[@]}; do
    yayInstall $pkg
done

for pkg in ${PYTHON_PACKAGES[@]}; do
    yayInstall "python-$pkg"
done
