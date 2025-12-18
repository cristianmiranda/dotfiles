#!/bin/bash

. ${UTILS_PATH}/ui.sh
. ${UTILS_PATH}/packages.sh
. ${UTILS_PATH}/path.sh

if [[ $INSTALL_PACKAGES =~ n|N ]]; then
    warning ">>> Skipping Packages..."
    exit 0
fi

# Update package lists
aptUpdate

#
# Core CLI tools
#
CORE_PACKAGES=(
    curl
    wget
    htop
    btop
    tree
    jq
    tmux
    neovim
    zsh
    unzip
    zip
    tar
    gzip
    git
    git-lfs
    ripgrep
    fzf
    fd-find
    bat
    eza
    ncdu
    screen
    neofetch
    man-db
    openssh-server
)

#
# Development tools
#
DEV_PACKAGES=(
    build-essential
    cmake
    pkg-config
    python3
    python3-pip
    python3-venv
    golang-go
    gcc
    autoconf
    software-properties-common
    apt-transport-https
    ca-certificates
    gnupg
    lsb-release
)

#
# Container tools
#
CONTAINER_PACKAGES=(
    docker.io
    docker-compose
)

#
# Python packages
#
PYTHON_PACKAGES=(
    black
    ipython
    httpie
)

# Install core packages
info ">>> Installing core packages..."
for pkg in ${CORE_PACKAGES[@]}; do
    aptInstall $pkg
done

# Install development packages
info ">>> Installing development packages..."
for pkg in ${DEV_PACKAGES[@]}; do
    aptInstall $pkg
done

# Install container packages
info ">>> Installing container packages..."
for pkg in ${CONTAINER_PACKAGES[@]}; do
    aptInstall $pkg
done

# Install Python packages
info ">>> Installing Python packages..."
for pkg in ${PYTHON_PACKAGES[@]}; do
    pip3Install $pkg
done

#
# Install kubectl from official repo
#
info ">>> Installing kubectl..."
if ! command -v kubectl &> /dev/null; then
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg 2>/dev/null
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list > /dev/null
    aptUpdate
    aptInstall kubectl
else
    warning ">>> Already installed: kubectl"
fi

#
# Install yq
#
info ">>> Installing yq..."
if ! command -v yq &> /dev/null; then
    sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
    sudo chmod +x /usr/local/bin/yq
else
    warning ">>> Already installed: yq"
fi

#
# Install starship prompt
#
info ">>> Installing starship..."
if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y >> $LOG_FILE 2>&1
else
    warning ">>> Already installed: starship"
fi
