if [[ $HOST == "devbox" ]]; then
	export EDITOR=nvim
	export GPG_TTY=$(tty)

	# Force modern terminal colors inside shpool/tmux/ssh
	if [[ -n "$SHPOOL_SESSION_NAME" ]]; then
			export TERM=xterm-256color
	fi

	# use nvr remote
	if [[ -n "$NVIM" ]]; then
		export VISUAL="nvr -cc split --remote-wait"
		export EDITOR="nvr -cc split --remote-wait"

		function nvim() {
			if [ ! -t 0 ]; then
					command nvim "$@"
					return
			fi

			nvr --remote "$@"
		}
		export MANPAGER="nvr -c 'Man!' -o -"
	fi
fi
