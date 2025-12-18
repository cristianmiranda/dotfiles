#!/bin/bash

if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    echo "starship already installed"
fi
