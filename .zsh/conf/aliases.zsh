# File system
if command -v eza &> /dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias la='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

if command -v fzf &> /dev/null; then
  alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
fi

if command -v lazygit &> /dev/null; then
  alias lg="lazygit"
  # Yadm with lazygit
  alias ylg='lazygit --git-dir ~/.local/share/yadm/repo.git --work-tree ~'
fi

if command -v lazydocker &> /dev/null; then
  alias ld="lazydocker"
fi

if command -v helix &>/dev/null; then
  alias hx="helix"
fi

if command -v harlequin &>/dev/null; then
  alias hq="harlequin"
  alias hqp="harlequin -a postgres"
  alias hqm="harlequin -a mysql"
  alias hqs="harlequin -a sqlite"
fi

if command -v nvim &>/dev/null; then
  n() { if [ "$#" -eq 0 ]; then nvim .; else nvim "$@"; fi; }
fi

if command -v rg &>/dev/null; then
  alias grep="rg --no-ignore --hidden"
fi

if command -v fd &>/dev/null; then
  alias find="fd --no-ignore --hidden"
fi

open () {
  xdg-open "$@" >/dev/null 2>&1 &
}


