bindkey -v
export KEYTIMEOUT=1
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

zmodload zsh/terminfo

bindkey -M viins "${terminfo[kdch1]}" delete-char
bindkey -M vicmd "${terminfo[kdch1]}" delete-char

bindkey -M viins '^[[H'  beginning-of-line
bindkey -M viins '^[OH'  beginning-of-line
bindkey -M viins '^[[1~' beginning-of-line

bindkey -M vicmd '^[[H'  beginning-of-line
bindkey -M vicmd '^[OH'  beginning-of-line
bindkey -M vicmd '^[[1~' beginning-of-line

bindkey -M viins '^[[F'  end-of-line
bindkey -M viins '^[OF'  end-of-line
bindkey -M viins '^[[4~' end-of-line

bindkey -M vicmd '^[[F'  end-of-line
bindkey -M vicmd '^[OF'  end-of-line
bindkey -M vicmd '^[[4~' end-of-line

bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char

export VISUAL=nvim
export EDITOR=nvim

function _set_cursor_shape() {
    if [[ $1 == "block" ]]; then
        print -n '\e[2 q'
    elif [[ $1 == "beam" ]]; then
        print -n '\e[6 q'
    fi
}

function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        _set_cursor_shape block
    else
        _set_cursor_shape beam
    fi
		zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-init {
    zle -K viins 
    _set_cursor_shape beam
}
zle -N zle-line-init

function _reset_cursor_precmd {
    _set_cursor_shape beam
}
precmd_functions+=(_reset_cursor_precmd)
