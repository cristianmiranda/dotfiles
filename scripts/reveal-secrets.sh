#!/usr/bin/env bash

set -e

# Wrapper script for git-secret reveal that automatically fixes permissions
# on SSH private keys after revealing

echo ">> Revealing secrets..."
git secret reveal "$@"

echo ">> Setting correct permissions on SSH private keys..."
chmod 600 ~/.ssh/pems/*.pem 2>/dev/null || true

echo ">> Done!"
