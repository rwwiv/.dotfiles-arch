for config in ${0:A:h}/*.zsh; do
  # Skip the current file to avoid infinite recursion
  [[ "$config" == "${0:A}" ]] && continue
  source "$config"
done
