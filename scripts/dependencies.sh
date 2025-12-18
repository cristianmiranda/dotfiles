#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_PATH="${DOTFILES_PATH:-$(dirname "$SCRIPT_DIR")}"

unameOut="$(uname -a)"
if [[ "$unameOut" =~ "MANJARO" || "$unameOut" =~ "arch" ]]; then
    DISTRO="ARCH"
elif [[ "$unameOut" =~ "Ubuntu" ]]; then
    DISTRO="UBUNTU"
else
    echo "Unsuported Linux distribution" && exit 1
fi

if [[ "$DISTRO" == "UBUNTU" ]]; then

    sudo DEBIAN_FRONTEND=noninteractive apt-get -y update
    sudo DEBIAN_FRONTEND=noninteractive apt-get -y install golang-go gcc git
    sudo DEBIAN_FRONTEND=noninteractive apt-get -y install python3-pip git-secret figlet lolcat

elif [[ $DISTRO == "ARCH" ]]; then

    sudo pacman --noconfirm -Syu
    sudo pacman --noconfirm -S go gcc git
    sudo pacman --noconfirm -S iw wpa_supplicant intel-ucode reflector lshw unzip htop
    sudo pacman --noconfirm -S wget pipewire alsa-utils alsa-plugins pavucontrol xdg-user-dirs

    # Create default directories
    xdg-user-dirs-update

    git clone https://aur.archlinux.org/yay.git ~/yay
    cd ~/yay
    makepkg --noconfirm -i
    cd -

    yay --noconfirm -Syyu
    yay --noconfirm -S python-pip git-secret figlet lolcat

fi

# Setup Python virtual environment for dotbot (common for all distros)
VENV_PATH="$HOME/venv"
if [ ! -d "$VENV_PATH" ]; then
    echo "Creating Python virtual environment at $VENV_PATH..."
    python3 -m venv "$VENV_PATH"
fi

# Install Python dependencies
echo "Installing Python dependencies..."
"$VENV_PATH/bin/pip" install --upgrade pip
"$VENV_PATH/bin/pip" install -r "${DOTFILES_PATH}/requirements.txt"

