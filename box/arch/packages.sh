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
    alacritty
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
    bind
    blueman
    bluez
    bluez-utils
    breeze
    brightnessctl
    cargo
    cawbird-git
    chromium
    cloud-sql-proxy-bin
    cmatrix
    copyq
    cronie
    cups
    deluge-gtk
    discord
    docker
    docker-compose
    dunst
    dust
    easyeffects
    ebtables
    edk2-ovmf
    element-desktop
    emojify
    espeak
    fd
    ffmpeg
    filezilla
    firefox
    firefox-developer-edition
    flameshot
    font-manager
    freerdp
    fzf
    git-delta
    github-copilot-cli
    gitkraken
    git-lfs
    glances
    gnome-keyring
    go
    google-cloud-sdk
    gqlplus
    gtkpod
    hplip
    hsetroot
    i3lock-color-git
    i3-wm
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
    man-db
    matcha-gtk-theme
    meld
    mousepad
    mpv
    navi
    ncdu
    neofetch
    neovim
    nerd-fonts-meta
    net-tools
    networkmanager
    network-manager-applet
    networkmanager-openvpn
    nitrogen
    nodejs-gitmoji-cli
    nordvpn-bin
    notion-app
    noto-color-emoji-fontconfig
    noto-fonts
    noto-fonts-emoji
    numlockx
    nvidia
    nvidia-lts
    nvidia-settings
    nvidia-utils
    octopi
    okular
    openresolv
    openssh
    optimus-manager-git
    optimus-manager-qt
    oracle-instantclient-sqlplus
    p7zip
    pacman-contrib
    pamixer
    papirus-icon-theme
    pasystray
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
    screen
    seahorse
    simplescreenrecorder
    slack-desktop
    sof-firmware
    sops
    sox
    spotify
    starship
    steam
    streamlink
    sxhkd
    sysstat
    system-config-printer
    teamviewer
    telegram-desktop
    termdown
    thefuck
    thunar
    thunderbird
    ticktick
    timeshift
    tlp
    tlpui-git
    tmux
    tree
    ueberzug
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
    xidlehook
    xmlstarlet
    xorg-apps
    xorg-server
    xorg-xinit
    xsettingsd
    yarn
    youtube-dl
    yq
    yubikey-manager-qt
    zip
    zoom
    zsh
)

PYTHON_PACKAGES=(
    black
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
