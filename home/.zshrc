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
source ${HOME}/profiles/common.sh

#
# Zoxide
# Only init in interactive shells with zoxide in PATH
# Fallback: unset cd if zoxide functions weren't properly defined
#
[[ -o interactive ]] && (( $+commands[zoxide] )) && eval "$(zoxide init --cmd cd zsh)"
(( $+functions[cd] )) && ! (( $+functions[__zoxide_z] )) && unset -f cd

#
# Starship prompt
# (use _evalcache_clear to clear cached init script)
#
_evalcache starship init zsh

# Load SDKMAN
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
