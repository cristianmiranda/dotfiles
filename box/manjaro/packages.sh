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
    acpi_call
    alsa-firmware
    alsa-ucm-conf
    alsa-utils
    alttab-git
    auto-cpufreq
    autoconf
    balena-etcher
    bashtop
    bat
    brightnessctl
    cargo
    cawbird-git
    chromium
    cmatrix
    copyq
    cups
    deluge-gtk
    discord
    docker
    docker-compose
    ebtables
    edk2-ovmf
    element-desktop
    emojify
    espeak
    filezilla
    firefox
    firefox-developer-edition
    firefox-nightly
    fd
    ffmpeg
    flameshot
    font-manager
    git-delta-bin
    git-lfs
    gtkpod
    hsetroot
    hplip
    i3-gaps
    i3blocks
    i3blocks-contrib
    i3lock-color-git
    imagemagick
    intellij-idea-ultimate-edition-jre
    insync
    jetbrains-toolbox
    jitsi-meet-desktop-bin
    jq
    lazydocker
    libinput-gestures
    meld
    mpv
    navi
    neofetch
    nerd-fonts-fira-code
    net-tools
    nitrogen
    nodejs-gitmoji-cli
    nordvpn-bin
    noto-fonts-emoji
    nvidia
    okular
    onlyoffice-bin
    openssh
    optimus-manager-git
    optimus-manager-qt
    p7zip
    pasystray
    pamixer
    pavucontrol
    peek
    playerctl
    plex-media-player
    polkit-gnome
    postman-bin
    proton-ge-custom-bin
    python-spotdl
    qalculate-gtk
    qemu
    rofi
    rofi-calc
    ruby-colorls
    simplescreenrecorder
    skypeforlinux-stable-bin
    screen
    sof-firmware
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
    xf86-input-libinput
    xmlstarlet
    xorg-xev
    xorg-xinput
    xsettingsd
    yarn
    youtube-dl
    yubikey-manager-qt
    zip
    zoom
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

# Uninstall Palemoon browser
sudo rm /home/*/.local/share/applications/userapp-Pale\ Moon-*.desktop /home/*/.local/share/applications/mimeinfo.cache >> $LOG_FILE 2>&1
sudo rm -rf /usr/bin/palemoon ~/palemoon /usr/share/applications/palemoon.desktop /usr/share/icons/hicolor/*/apps/palemoon.png >> $LOG_FILE 2>&1
