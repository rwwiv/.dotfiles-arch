# zsh config
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=${HISTSIZE}
setopt appendhistory
setopt HIST_IGNORE_DUPS

bindkey -e
if [[ -n "$SSH_CONNECTION" ]]; then
    echo -e "\e[5 q"
fi
PATH="$PATH:$HOME/.local/bin"
TIMEFMT=$'%J\n%U user\n%S system\n%P cpu\n%E total'

# clone/source znap
[[ -r $HOME/dev/znap/znap.zsh ]] ||
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git $HOME/dev/znap
source $HOME/dev/znap/znap.zsh

# starship prompt
if command -v starship &>/dev/null; then
  export STARSHIP_LOG="error"
  znap eval starship "starship init zsh"
  znap prompt
fi

if command -v thefuck &>/dev/null; then
  znap eval thefuck "thefuck --alias"
fi

if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
fi

if command -v mise &>/dev/null; then
  znap eval mise "mise activate zsh"
fi

if command -v zoxide &>/dev/null; then
  znap eval zoxide "zoxide init zsh"
fi

if command -v uv &>/dev/null; then
  znap eval uv "uv generate-shell-completion zsh"
fi

[[ -r $HOME/.zsh/conf/rc.zsh ]] && source $HOME/.zsh/conf/rc.zsh

znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
znap source wfxr/forgit
znap source ohmyzsh/ohmyzsh plugins/{aliases,encode64,extract,git,safe-paste,z,kubectl}
