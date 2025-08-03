#!/usr/bin/env bash

# Common cross-profile stuff
source ~/profiles/common.sh

eval "$(zoxide init bash)"

# Starship - https://starship.rs/
eval "$(starship init bash)"
