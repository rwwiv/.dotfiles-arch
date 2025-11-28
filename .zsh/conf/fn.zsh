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
