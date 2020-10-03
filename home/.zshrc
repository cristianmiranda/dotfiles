#!/bin/zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# ZSH_THEME=agnoster

export ZSH_DISABLE_COMPFIX=true

# ZGEN
source "${HOME}/bin/zgen/zgen.zsh"

#########
# DO THIS IF CHANGING ANYTHING RELATED TO ZGEN: --> zgen update
#########

# if the init script doesn't exist
if ! zgen saved; then

  # specify plugins here
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/command-not-found
  zgen oh-my-zsh plugins/docker
  zgen oh-my-zsh plugins/docker-compose
  zgen oh-my-zsh plugins/sudo

  zgen load zsh-users/zsh-completions
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load wfxr/forgit

  # theme
  zgen load denysdovhan/spaceship-prompt spaceship
  # zgen load agnoster/agnoster-zsh-theme
  # zgen load romkatv/powerlevel10k powerlevel10k

  # generate the init script from plugins above
  zgen save
fi

#prompt_context(){}

# https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
#SPACESHIP_DIR_COLOR=178
#SPACESHIP_CHAR_COLOR_FAILURE=160

# Common cross-profile stuff
source ${HOME}/profiles/common.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Command-line Fuzzy Finder - https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/cmiranda/.sdkman"
[[ -s "/Users/cmiranda/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/cmiranda/.sdkman/bin/sdkman-init.sh"

# macOS bash completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
