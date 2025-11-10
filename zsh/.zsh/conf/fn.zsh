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

if command -v psql &>/dev/null; then
  create_postgres_db() {
    local user pass db
    user="$1"
    pass="$2"
    db="$3"

    [ -z "$user" ] && echo "Missing user" && return 1
    [ -z "$pass" ] && echo "Missing password" && return 1
    [ -z "$db" ] && db="$user"

    psql -c "create role ${user} with createdb encrypted password '${pass}' login;"
    psql -c "alter user ${user} superuser;"
    psql -c "create database ${db} with owner ${user};"
  }
fi

timeshell() {
  local shell
  shell=${1}
  [ -z "$shell" ] && echo "Missing shell to time" && return 1

  for _ in $(seq 1 10); do /usr/bin/time "$shell" -i -c exit; done
}
