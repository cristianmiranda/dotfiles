#!/bin/bash

. ${UTILS_PATH}/ui.sh

info ">>> Installing lazygit..."

if command -v lazygit &> /dev/null; then
    warning ">>> Already installed: lazygit"
    exit 0
fi

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
sudo install /tmp/lazygit /usr/local/bin
rm -f /tmp/lazygit /tmp/lazygit.tar.gz

success ">>> lazygit installed successfully"
