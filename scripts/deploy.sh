#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -ne ">> Install anonymously? [y/n]:"
read -r $ANONYMOUS

if [[ $ANONYMOUS =~ y|Y ]]; then
    # Clone repo
    cd ~
    git clone --recursive https://github.com/cristianmiranda/dotfiles.git

    # Install
    . ~/dotfiles/scripts/anonymous-install.sh
else
    # Grabs ssh & gpg keys
    cd $HOME
    BACKUP_DIR=/data/ssd/backups/manual/secrets

    # Install git and unzip based on distro
    unameOut="$(uname -a)"
    if [[ "$unameOut" =~ "Ubuntu" ]]; then
        sudo apt-get update && sudo apt-get install -y git unzip
    else
        sudo pacman -S --noconfirm git unzip
    fi

    printf "%s " "Please import ~/.ssh and ~/.gnupg manually. Once finished press enter to continue."
    read ans

    # scp -r -P 62022 cmiranda@cmiranda.ar:"${BACKUP_DIR}/.gnupg" .
    # scp -r -P 62022 cmiranda@cmiranda.ar:"${BACKUP_DIR}/.ssh" .
    # scp -r -P 62022 cmiranda@cmiranda.ar:"${BACKUP_DIR}/.cert" .

    sudo chmod -R 0700 ~/.ssh
    sudo chmod -R 0700 ~/.gnupg

    # Clone or update repo
    WORKSPACE=$HOME/Documents/Work/Workspace
    mkdir -p $WORKSPACE
    cd $WORKSPACE
    if [ -d "dotfiles" ]; then
        echo ">> Repo exists, pulling latest changes..."
        cd dotfiles
        git pull
    else
        git clone --recursive git@github.com:cristianmiranda/dotfiles.git
        cd dotfiles
    fi

    # Kicks off the installation script
    bash scripts/install.sh
fi
