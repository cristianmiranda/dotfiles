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
    1password-cli
    accountsservice
    acpi
    acpi_call
    amdgpu_top-bin
    apcupsd
    alacarte
    alacritty
    alsa-firmware
    alsa-ucm-conf
    alsa-utils
    alttab-git
    arandr
    asciinema
    atool
    authy
    autoconf
    autotiling
    base-devel
    bashtop
    bat
    betterlockscreen
    bind
    blueman
    bluez
    bluez-utils
    breeze
    brightnessctl
    cargo
    cawbird-git
    chili-sddm-theme
    clipboard
    cmatrix
    copyq
    cronie
    cups
    deluge-gtk
    dnsmasq
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
    expect
    eza
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
    google-chrome
    gqlplus
    gtkpod
    gvfs                    # thunar dependency
    hplip
    httpie
    hsetroot
    i3lock-color
    i3-wm
    imagemagick
    inetutils
    insync
    jetbrains-toolbox
    jitsi-meet-desktop-bin
    jq
    kde-cli-tools
    kubectl
    kubectx
    i2c-tools                       # openrgb dependency
    lazydocker
    lazygit
    libinput-gestures
    libreoffice-fresh
    lxappearance
    man-db
    matcha-gtk-theme
    meld
    mesa
    mousepad
    mpv
    mugshot
    navi
    ncdu
    neofetch
    neovim
    net-tools
    networkmanager
    network-manager-applet
    networkmanager-openvpn
    ngrok
    nitrogen
    nodejs-gitmoji-cli
    nordvpn-bin
    notion-app-electron
    noto-color-emoji-fontconfig
    noto-fonts
    noto-fonts-emoji
    numlockx
    obs-studio
    okular
    openresolv
    openrgb
    openssh
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
    pyenv
    pyenv-virtualenv
    qalculate-gtk
    qemu
    qt5ct
    ranger
    rebuild-detector
    ripgrep
    rocm-hip-runtime    # AMD GPU ROCm
    rocm-opencl-runtime # AMD GPU ROCm
    rofi
    rofi-calc
    rofi-emoji
    rtkit
    ruby-fusuma
    screen
    sddm
    seahorse
    shell-color-scripts
    simplescreenrecorder
    slack-desktop
    sof-firmware
    solaar
    sops
    sox
    speedtest-cli
    spotify
    starship
    steam
    streamlink
    sxhkd
    sysstat
    system-config-printer
    tdrop
    telegram-desktop
    termdown
    the_silver_searcher
    thunar
    thunar-archive-plugin
    thunar-custom-actions
    thunar-volman
    thunderbird
    ticktick
    timeshift
    tmux
    tree
    ttf-firacode-nerd
    ttf-noto-nerd
    ueberzug
    unrar
    unzip
    uswsusp-git            # s2ram (suspend)
    variety
    viewnior
    virt-manager
    visual-studio-code-bin
    visual-studio-code-insiders-bin
    vlc
    wasistlos
    wireplumber
    xarchiver
    xcalib
    xclip
    xdotool
    xf86-input-libinput
    xf86-video-amdgpu
    xidlehook
    xmlstarlet
    xorg-apps
    xorg-server
    xorg-server-xephyr
    xorg-xinit
    xsettingsd
    yarn
    yq
    yt-dlp
    yubikey-manager-qt
    zip
    zoom
    zoxide
    zsh
)

PYTHON_PACKAGES=(
    black
    bleak
    i3ipc
    pypdf2
    tinytuya
    spotdl
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
