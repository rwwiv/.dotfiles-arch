# Compression
compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"

if command -v magick &>/dev/null; then
  # Transcode any image to JPG image that's great for shrinking wallpapers
  img2jpg() {
    magick $1 -quality 95 -strip ${1%.*}.jpg
  }

  # Transcode any image to JPG image that's great for sharing online without being too big
  img2jpg-small() {
    magick $1 -resize 1080x\> -quality 95 -strip ${1%.*}.jpg
  }
fi

# create-postgres-db moved to bin/.local/bin/create-postgres-db

timeshell() {
  local shell
  shell=${1}
  [ -z "$shell" ] && echo "Missing shell to time" && return 1

  for _ in $(seq 1 10); do /usr/bin/time "$shell" -i -c exit; done
}

if command -v clamdscan &>/dev/null; then
  # Optimized ClamAV Scan Function
  # Usage: "scan ." (current dir) or "scan /path/to/folder"
  scan() {
      # 1. Set up the Quarantine Folder (safely)
      local QUARANTINE="$HOME/.clamav/quarantine"
      mkdir -p "$QUARANTINE"

      # 2. Define the target (default to current directory if no arg provided)
      local TARGET="${1:-.}"

      echo "🛡️  Scanning: $TARGET"
      echo "📦 Quarantine: $QUARANTINE"

      # 3. Run clamdscan (The fast client)
      # --multiscan: Uses all threads (Crucial for your Core Ultra 7)
      # --fdpass:    Fixes permission errors (passes file access to the daemon user)
      # --move:      Moves viruses instead of deleting them (Safety net)
      # --quiet:     Only output errors/viruses (Clean terminal)
      
      sudo clamdscan \
          --multiscan \
          --fdpass \
          --move="$QUARANTINE" \
          --quiet \
          "$TARGET"

      # 4. Check the exit code for the notification
      local STATUS=$?
      if [ $STATUS -eq 0 ]; then
          echo "✅ Scan Clean."
          notify-send "ClamAV" "Scan Clean: No threats found." -i security-high
      elif [ $STATUS -eq 1 ]; then
          echo "🚨 THREAT FOUND. check $QUARANTINE"
          notify-send "ClamAV" "🚨 THREAT FOUND. Moved to Quarantine." -u critical
      else
          echo "⚠️  Scan Error."
      fi
  }
fi

extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

znap_clear_eval_cache() {
    local cache_dir=${ZDOTDIR:-$HOME}/.cache/zsh-snap/eval
    
    echo "🚨 Forcefully removing all znap eval cache files in: $cache_dir"
    
    # Check if the directory exists before trying to remove it
    if [[ -d "$cache_dir" ]]; then
        # Remove all contents recursively and forcefully
        command rm -rf "$cache_dir"
        
        # Check if the removal was successful
        if [[ $? -eq 0 ]]; then
            echo "✅ znap eval cache cleared successfully."
        else
            echo "❌ Error clearing znap eval cache."
            return 1
        fi
    else
        echo "ℹ️ znap eval cache directory not found. Nothing to clear."
    fi
}

sshp() {
  # Check if the first argument contains a '+'
  if [[ "$1" == *+* ]]; then
    # 1. Extract Session (Remove everything from the '+' onwards)
    local session="${1%+*}"
    
    # 2. Extract Host (Remove everything up to the '+')
    local host="${1#*+}"
    
    # Remove the first argument (session+host) so we can pass the rest
    shift
    
    # Connect
    ssh -t "$host" "shpool attach '$session' || shpool create '$session'" "$@"
  else
    # Standard SSH behavior
    ssh "$@"
  fi
}
compdef sshp=ssh

burniso() {
	if [ $# -ne 2 ]; then
    echo "Usage: iso2sd <input_file> <output_device>"
    echo "Example: iso2sd ~/Downloads/ubuntu-25.04-desktop-amd64.iso /dev/sda"
    echo -e "\nAvailable drives:"
    lsblk -d -o NAME | grep -E '^sd[a-z]' | awk '{print "/dev/"$1}'
  else
    sudo dd bs=4M status=progress oflag=sync if="$1" of="$2"
    sudo eject $2
  fi
}

