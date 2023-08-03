#!/bin/zsh

#
# Used to profile zsh plugins
# Uncomment line and run "zprof"
#
# zmodload zsh/zprof
#
# To launch 10 zsh instances and measure time --> for i in $(seq 1 10); do time $SHELL -i -c exit; done

# Antidote - https://getantidote.github.io
[[ -r ~/.antidote ]] || git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
autoload -Uz compinit && compinit
antidote load

# Common cross-profile stuff
zsh-defer source ${HOME}/profiles/common.sh

# Starship - https://starship.rs/
eval "$(starship init zsh)"

