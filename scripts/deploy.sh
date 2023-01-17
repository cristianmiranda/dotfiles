#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -ne ">> Install anonymously? [y/n]:"
read -r $ANONYMOUS

if [[ $ANONYMOUS =~ y|Y ]];
then
    # Clone repo
    cd ~
    git clone --recursive https://github.com/cristianmiranda/dotfiles.git

    # Install
    . ~/dotfiles/scripts/anonymous-install.sh
else
    # Grabs ssh & gpg keys
    cd $HOME
    BACKUP_DIR=/data/ssd/backups/manual/secrets
    
    sudo pacman -S git unzip

    printf "%s " "Please import ~/.ssh and ~/.gnupg manually. Once finished press enter to continue."
    read ans

    # scp -r -P 62022 cmiranda@cmiranda.ar:"${BACKUP_DIR}/.gnupg" .
    # scp -r -P 62022 cmiranda@cmiranda.ar:"${BACKUP_DIR}/.ssh" .
    # scp -r -P 62022 cmiranda@cmiranda.ar:"${BACKUP_DIR}/.cert" .

    # Clones repo
    WORKSPACE=$HOME/Documents/Work/Workspace
    mkdir -p $WORKSPACE
    cd $WORKSPACE
    git clone --recursive git@github.com:cristianmiranda/dotfiles.git

    # Kicks off the installation script
    cd dotfiles
    bash scripts/install.sh
fi
