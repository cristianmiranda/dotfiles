#!/usr/bin/env bash

# Common cross-profile stuff
source ~/profiles/common.sh

command -v zoxide &> /dev/null && eval "$(zoxide init bash)"

# Starship - https://starship.rs/
eval "$(starship init bash)"
