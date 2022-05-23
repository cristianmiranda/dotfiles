#!/bin/bash

. ${UTILS_PATH}/ui.sh
. ${UTILS_PATH}/path.sh

function addAptRepository {
  info ">>> Adding ppa repository ${1}"
  sudo add-apt-repository -y ppa:${1} >> $LOG_FILE 2>&1
}

function aptUpdate {
  sudo DEBIAN_FRONTEND=noninteractive apt update >> $LOG_FILE 2>&1
}

function aptInstall {
  dpkg -l $1 &> /dev/null

  if [ $? -ne 0 ]; then
    info ">>> Installing ${1}"
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y $1 >> $LOG_FILE 2>&1
  else
    warning ">>> Already installed: ${1}"
  fi
}

function yayInstall {
  pacman -Qi $1 &> /dev/null

  if [ $? -ne 0 ]; then
    info ">>> Installing ${1}"
    yes | yay --noconfirm -S $1 >> $LOG_FILE 2>&1
  else
    warning ">>> Already installed: ${1}"
  fi
}

function aptUpgrade {
  info ">>> Upgrading ${1}"
  sudo apt-get -y --only-upgrade install $1 >> $LOG_FILE 2>&1
}

function pip3Install {
  info ">>> Installing ${1}"
  pip3 install $1 >> $LOG_FILE 2>&1
}

function pip3InstallForUser {
  info ">>> Installing ${1}"
  pip3 install $1 --user >> $LOG_FILE 2>&1
}

function brewInstall {
  info ">>> Installing ${1}"
  brew install $1 >> $LOG_FILE 2>&1
}

function brewCaskInstall {
  info ">>> Installing ${1}"
  brew install --cask $1 >> $LOG_FILE 2>&1
}

function brewUpdateUpgrade {
  info ">>> Updating & Upgrading packages"
  brew update >> $LOG_FILE 2>&1
  brew upgrade >> $LOG_FILE 2>&1
}

function brewCleanup {
  info ">>> Removing outdated versions from the cellar"
  brew cleanup >> $LOG_FILE 2>&1
}
