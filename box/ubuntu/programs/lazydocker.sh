#!/bin/bash

. ${UTILS_PATH}/ui.sh

info ">>> Installing lazydocker..."

if command -v lazydocker &> /dev/null; then
    warning ">>> Already installed: lazydocker"
    exit 0
fi

LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo /tmp/lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"
tar xf /tmp/lazydocker.tar.gz -C /tmp lazydocker
sudo install /tmp/lazydocker /usr/local/bin
rm -f /tmp/lazydocker /tmp/lazydocker.tar.gz

success ">>> lazydocker installed successfully"
