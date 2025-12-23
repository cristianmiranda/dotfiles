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
    bat
    btop
    curl
    eza
    fd-find
    git
    git-delta
    git-lfs
    gzip
    htop
    jq
    man-db
    ncdu
    neofetch
    neovim
    openssh-server
    openvpn
    ripgrep
    screen
    tar
    tmux
    tree
    unzip
    vim
    wget
    zip
    zoxide
    zsh
)

#
# Development tools
#
DEV_PACKAGES=(
    apt-transport-https
    autoconf
    awscli
    build-essential
    ca-certificates
    cmake
    gcc
    gnupg
    golang-go
    lsb-release
    nodejs
    npm
    pkg-config
    python3
    python3-pip
    python3-venv
    software-properties-common
)

#
# Container tools
#
CONTAINER_PACKAGES=(
    docker.io
)

#
# Python packages
#
PYTHON_PACKAGES=(
    black
    httpie
    ipython
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
# Install Docker Compose v2 plugin from official Docker repo
#
info ">>> Installing docker-compose-plugin..."
if ! docker compose version &> /dev/null; then
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    aptUpdate
    aptInstall docker-compose-plugin
else
    warning ">>> Already installed: docker-compose-plugin"
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

