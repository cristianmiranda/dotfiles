# Common cross-profile stuff
source ~/profiles/common.sh

# Change to zsh if on ssh session
if [ “$SSH_TTY” ] && [ "$HOSTNAME" = "mini-linux" ];
then
	export SHELL=/usr/bin/zsh
	exec /usr/bin/zsh || echo "Could not change to /usr/bin/zsh"
fi

# Command-line Fuzzy Finder - https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
