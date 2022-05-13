#!/bin/zsh

#
# Used to profile zsh plugins
# Uncomment line and run "zprof"
#
# zmodload zsh/zprof
#
# To launch 10 zsh instances and measure time --> for i in $(seq 1 10); do time $SHELL -i -c exit; done

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

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
  zgen load lukechilds/zsh-nvm
  zgen load matthieusb/zsh-sdkman
  zgen load ChrisPenner/copy-pasta

  # theme
  zgen load denysdovhan/spaceship-prompt spaceship
  # zgen load agnoster/agnoster-zsh-theme
  # zgen load romkatv/powerlevel10k powerlevel10k

  # generate the init script from plugins above
  zgen save
fi

zmodload zsh/zprof

#prompt_context(){}

# https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
#SPACESHIP_DIR_COLOR=178
#SPACESHIP_CHAR_COLOR_FAILURE=160
SPACESHIP_GCLOUD_SHOW=false
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_DOCKER_VERBOSE=false

if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS bash completion
  [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
  
  # Brew
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # Override python 2.7 with 3
  alias python=python3
fi

# Common cross-profile stuff
source ${HOME}/profiles/common.sh

# Command-line Fuzzy Finder - https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://github.com/wting/autojump
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

# Navi - https://github.com/denisidoro/navi#customization
where navi > /dev/null 2>&1 && eval "$(navi widget zsh)"

# To customize prompt, run `p10k configure` or edit ~/Documents/Work/Workspace/dotfiles/home/.p10k.zsh.
# [[ ! -f ~/Documents/Work/Workspace/dotfiles/home/.p10k.zsh ]] || source ~/Documents/Work/Workspace/dotfiles/home/.p10k.zsh

# typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='➜'
