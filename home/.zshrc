#!/bin/zsh

#
# Used to profile zsh plugins
# Uncomment line and run "zprof"
#
# zmodload zsh/zprof
#
# To launch 10 zsh instances and measure time --> for i in $(seq 1 10); do time $SHELL -i -c exit; done


# Common cross-profile stuff
source ${HOME}/profiles/common.sh

# Starship - https://starship.rs/
eval "$(starship init zsh)"
