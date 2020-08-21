# Setup fzf
# ---------
if [[ ! "$PATH" == */home/cmiranda/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/cmiranda/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/cmiranda/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/cmiranda/fzf/shell/key-bindings.bash"
