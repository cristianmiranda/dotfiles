# Setup fzf
# ---------
if [[ ! "$PATH" == */home/cmiranda/dotfiles/home/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/cmiranda/dotfiles/home/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/cmiranda/dotfiles/home/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/cmiranda/dotfiles/home/fzf/shell/key-bindings.bash"
