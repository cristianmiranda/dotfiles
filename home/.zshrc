#!/bin/zsh

#
# Used to profile zsh plugins
# Uncomment line and run "zprof"
#
# zmodload zsh/zprof
#
# To launch 10 zsh instances and measure time --> for i in $(seq 1 10); do time $SHELL -i -c exit; done

export ZSH_DISABLE_COMPFIX=true

# ZGEN
source "${HOME}/bin/zgen/zgen.zsh"

#########
# DO THIS IF CHANGING ANYTHING RELATED TO ZGEN: --> zgen update
#########

# if the init script doesn't exist
if ! zgen saved; then

  zgen oh-my-zsh
  zgen oh-my-zsh plugins/command-not-found
  zgen oh-my-zsh plugins/sudo

  zgen load zsh-users/zsh-completions
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load wfxr/forgit
  zgen load ChrisPenner/copy-pasta
  zgen load djui/alias-tips
  # zgen load lukechilds/zsh-nvm              # --> Uncomment if using nvm
  # zgen load matthieusb/zsh-sdkman           # --> Uncomment if using sdkman

  # generate the init script from plugins above
  zgen save
fi

# Common cross-profile stuff
source ${HOME}/profiles/common.sh

# Starship - https://starship.rs/
eval "$(starship init zsh)"
