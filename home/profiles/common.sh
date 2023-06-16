#!/bin/bash

# Load all .exports
for export in $(find ${HOME}/dots/ -type f | grep .exports | grep -v .secret); do
	[ -r "$export" ] && [ -f "$export" ] && source "$export"
done

# Load all .dotfiles
for file in $(find ${HOME}/dots/ -type f | grep -v .exports | grep -v .secret); do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

HOSTNAME=$(hostname)
HOST_PROFILE="${HOME}/profiles/${HOSTNAME}.sh"
if test -f "${HOST_PROFILE}"; then
	source ${HOME}/profiles/${HOSTNAME}.sh
fi
