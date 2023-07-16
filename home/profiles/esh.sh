#!/usr/bin/env bash

#
# Installation: Stick it in .bashrc or .bash_profile
#
# PROFILE_URL=https://raw.githubusercontent.com/cristianmiranda/dotfiles/master/home/profiles/esh.sh
# source <(curl -H 'Cache-Control: no-cache' -s $PROFILE_URL)
#

#
# Fixes vim colors on Alacritty
#
export TERM=xterm-256color

#
# ESH Specific Aliases
#
alias sutomcat="sudo /bin/su - tomcat -s /bin/bash"
alias suescribe="sudo su - escribe"
alias webapps="cd /srv/tomcat/webapps"
alias logs="cd /var/log/tomcat/escribe"

#
# ESH Specific Exports
#
export PATH=$PATH:/opt/escribe/bin

#
# Common Aliases
#
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias l="ls -CF"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias grep="grep --color=auto"
alias c="clear"
alias h="history"

#
# Common Exports
#
export EDITOR=vim
export VISUAL=vim
