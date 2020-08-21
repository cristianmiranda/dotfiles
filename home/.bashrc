# Common cross-profile stuff
source ~/profiles/common.sh

# Change to zsh if on ssh session
if [ “$SSH_TTY” ] && [ "$HOSTNAME" = "mini-linux" ];
then
	export SHELL=/usr/bin/zsh
	exec /usr/bin/zsh || echo "Could not change to /usr/bin/zsh"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Command-line Fuzzy Finder - https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
