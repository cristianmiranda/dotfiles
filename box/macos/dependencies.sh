#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Installing brew
brew -v
if [ $? != 0 ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew install git-secret
brew install figlet
brew install lolcat
brew install yq

pip3 install click
