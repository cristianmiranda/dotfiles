#!/bin/bash

# Load all .exports
for export in $(find ${HOME}/dots/ -type f | grep .exports | grep -v .secret); do
	[ -r "$export" ] && [ -f "$export" ] && source "$export";
done;

# Load all .dotfiles
for file in $(find ${HOME}/dots/ -type f | grep -v .exports | grep -v .secret); do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

HOSTNAME=`hostname`

alias dotsync="bash ~/dotfiles/dotbot/bin/dotbot -v -c ~/dotfiles/home/dotbot.esh-server.conf.yaml && source ~/.bash_profile"

# Stuff I already have with ZSH
alias l="ls -lrt"
alias la="ls -lrta"
