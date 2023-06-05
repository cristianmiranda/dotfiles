#!/bin/zsh

#
# Used to profile zsh plugins
# Uncomment line and run "zprof"
#
# zmodload zsh/zprof
#
# To launch 10 zsh instances and measure time --> for i in $(seq 1 10); do time $SHELL -i -c exit; done

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
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/kubectl

  zgen load zsh-users/zsh-completions
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load wfxr/forgit
  # zgen load lukechilds/zsh-nvm
  # zgen load matthieusb/zsh-sdkman
  zgen load ChrisPenner/copy-pasta

  # theme
  zgen load denysdovhan/spaceship-prompt spaceship
  # zgen load agnoster/agnoster-zsh-theme
  # zgen load romkatv/powerlevel10k powerlevel10k
  # zgen oh-my-zsh themes/cloud

  # generate the init script from plugins above
  zgen save
fi

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
  # eval "$(/opt/homebrew/bin/brew shellenv)"

  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Override python 2.7 with 3
alias python=python3

# Common cross-profile stuff
source ${HOME}/profiles/common.sh

# Command-line Fuzzy Finder - https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#
# https://github.com/wting/autojump
#
# Arch Linux
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh
# autojump-git
[[ -s /home/cmiranda/.cache/yay/autojump-git/pkg/autojump-git/etc/profile.d/autojump.sh ]] && source /home/cmiranda/.cache/yay/autojump-git/pkg/autojump-git/etc/profile.d/autojump.sh
# macOS
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
# Ubuntu Server
[[ -s /home/cmiranda/.autojump/etc/profile.d/autojump.sh ]] && source /home/cmiranda/.autojump/etc/profile.d/autojump.sh

# Navi - https://github.com/denisidoro/navi#customization
where navi >/dev/null 2>&1 && eval "$(navi widget zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
