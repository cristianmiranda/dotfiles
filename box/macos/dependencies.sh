#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Installing brew
brew -v
if [ $? != 0 ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew install bash
brew install git-secret
brew install figlet
brew install lolcat
brew install yq
brew install go
brew install gum

# Setup Python virtual environment for dotbot
VENV_PATH="$HOME/venv"
if [ ! -d "$VENV_PATH" ]; then
    echo "Creating Python virtual environment at $VENV_PATH..."
    python3 -m venv "$VENV_PATH"
fi

# Install Python dependencies
echo "Installing Python dependencies..."
"$VENV_PATH/bin/pip" install --upgrade pip
"$VENV_PATH/bin/pip" install -r "${DOTFILES_PATH}/requirements.txt"

pip3 install click
