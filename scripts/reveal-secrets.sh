#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "${SCRIPT_DIR}/utils/ui.sh" 2>/dev/null || true

# Wrapper script for git-secret reveal that automatically fixes permissions
# on SSH private keys after revealing

info ">> Revealing secrets..."

# Make existing secret files writable so git-secret can overwrite them
# (they may have been chmod 400/600 from previous reveal)
find "$(git rev-parse --show-toplevel)" -name "*.pem" -type f -exec chmod u+w {} \; 2>/dev/null || true
find ~/.ssh/pems -name "*.pem" -type f -exec chmod u+w {} \; 2>/dev/null || true

git secret reveal "$@"

info ">> Setting correct permissions on SSH private keys..."
chmod 600 ~/.ssh/pems/*.pem 2>/dev/null || true

success ">> Secrets revealed!"
