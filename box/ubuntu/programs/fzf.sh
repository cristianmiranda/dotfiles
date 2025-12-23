#!/bin/bash

. ${UTILS_PATH}/ui.sh

info ">>> Installing fzf..."

FZF_VERSION=$(curl -s "https://api.github.com/repos/junegunn/fzf/releases/latest" | grep -oP '"tag_name": "\K[^"]+' | sed 's/^v//')
curl -Lo /tmp/fzf.tar.gz "https://github.com/junegunn/fzf/releases/latest/download/fzf-${FZF_VERSION}-linux_amd64.tar.gz"
tar xf /tmp/fzf.tar.gz -C /tmp fzf
mkdir -p ~/.local/bin
install /tmp/fzf ~/.local/bin/
rm -f /tmp/fzf /tmp/fzf.tar.gz

success ">>> fzf installed successfully"
