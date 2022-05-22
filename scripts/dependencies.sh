#!/bin/bash

unameOut="$(uname -a)"
[[ "$unameOut" =~ "MANJARO" ]]; then
    DISTRO="MANJARO"
elif [[ "$unameOut" =~ "Ubuntu" ]]; then
    DISTRO="UBUNTU"
else
    echo "Unsuported Linux distribution" && exit 1
fi

[[ "$DISTRO" == "UBUNTU" ]]; then

    sudo apt-get -y update
    sudo apt-get -y install golang-go gcc git
    sudo apt-get -y install python3-pip git-secret figlet lolcat

elif [[ $DISTRO == "MANJARO"]]; then

    sudo pacman --noconfirm -Syu
    sudo pacman --noconfirm -S go gcc git

    git clone https://aur.archlinux.org/yay.git ~/yay
    cd ~/yay
    makepkg --noconfirm -i
    cd -

    yay --noconfirm -Syyu
    yay --noconfirm -S python-pip git-secret figlet lolcat
    
fi

pip list --format=columns | grep setuptools || pip install setuptools
pip list --format=columns | grep click || pip install click
pip list --format=columns | grep PyYAML || pip install PyYAML
