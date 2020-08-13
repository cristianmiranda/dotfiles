#!/bin/bash

export UTILS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export SCRIPTS_PATH=${UTILS_PATH}/..
export DOTFILES_PATH=${SCRIPTS_PATH}/..

export CONFIG_FILE=${DOTFILES_PATH}/config.yaml
export LOG_FILE=/tmp/dotfiles.log
