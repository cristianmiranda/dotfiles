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

  # theme
  zgen load spaceship-prompt/spaceship-prompt spaceship

  # generate the init script from plugins above
  zgen save
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS bash completion
  [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
fi

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
# where navi >/dev/null 2>&1 && eval "$(navi widget zsh)"

# thefuck - https://github.com/nvbn/thefuck
eval $(thefuck --alias)
