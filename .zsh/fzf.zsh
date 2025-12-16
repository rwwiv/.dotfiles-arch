fzf-atuin-history-widget() {
  local selected
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2>/dev/null
  
  # Use atuin to get command history
  selected=$(atuin search --cmd-only | \
    fzf --tac \
        --no-sort \
        --exact \
        --height=40% \
        --query="$LBUFFER")
  
  local ret=$?
  if [ -n "$selected" ]; then
    LBUFFER="$selected"
  fi
  zle reset-prompt
  return $ret
}

zle -N fzf-atuin-history-widget
bindkey '^R' fzf-atuin-history-widget
