#!/bin/bash

. ${UTILS_PATH}/ui.sh
. ${UTILS_PATH}/path.sh

if [[ $APPLY_CONFIG =~ n|N ]]; then
    warning ">>> Skipping config..."
    exit 0
fi

# Enable/Start ssh server
info ">>> Enabling SSH server..."
sudo systemctl enable ssh >>$LOG_FILE 2>&1
sudo systemctl start ssh >>$LOG_FILE 2>&1

# Enable/Start docker
info ">>> Enabling Docker..."
sudo systemctl enable docker >>$LOG_FILE 2>&1
sudo systemctl start docker >>$LOG_FILE 2>&1

# Add user to docker group
info ">>> Adding user to docker group..."
sudo usermod -aG docker $USER >>$LOG_FILE 2>&1

# Set default shell to zsh
info ">>> Setting default shell to zsh..."
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh) >>$LOG_FILE 2>&1
fi

# tmux plugin manager
# Run prefix + I to install plugins
info ">>> Installing tmux plugin manager..."
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    warning ">>> tmux plugin manager already installed"
fi
