#.dotfiles/shell/helpers.sh

jms::echo_()      { echo -e "    $*"; }

jms::status()     { echo -e "\033[0;34m==>\033[0;32m $*\033[0;m"; }
jms::status_()    { echo -e "\033[0;32m    $*\033[0;m"; }
jms::err()        { echo -e "\033[0;31m==> ERR: \033[0;m$*\033[0;m" >&2; }
jms::err_()       { echo -e           "         $*" >&2; }
jms::warn()       { echo -e "\033[0;33m==> WARN: \033[0;m$*\033[0;m" >&2; }
jms::warn_()      { echo -e           "          $*" >&2; }

jms::usage()      { echo -e "\033[0;34m==> \033[0;34mUSAGE: \033[0;32m$*\033[0;m"; }
jms::usage_()     { echo -e "\033[0;29m    $*\033[0;m"; }

jms::installing() { jms::status "Installing \033[0;33m$1\033[0;32m..."; }
jms::symlinking() { jms::status "Symlinking \033[0;35m$1\033[0;32m -> \033[0;35m$2\033[0;32m "; }
jms::die()        { jms::err "$*"; exit 256; }

# silently determine existence of executable
# $1 name of bin
jms::has() { command -v "$1" >/dev/null 2>&1; }

# pipe into this to indent
jms::indent() { sed 's/^/    /'; }

# source a file if it exists
# $1 path to file
jms::source() {
  [ -f "$1" ] && source "$1" # && echo "Sourced $1"
}

# require root
jms::requireroot() {
  if [[ "$(whoami)" != "root" ]]; then
    jms::die "Please run as root, these files go into /etc/**/";
  fi
}

# require executable
# $1 name of bin
jms::require() {
  if jms::has "$1"; then
    jms::status "FOUND: ${1}"
  else
    jms::err "MISSING: ${1}"
    jms::die "Please install before proceeding.";
  fi
}

# symlinking helper function
# @TODO don't assume ~/.dotfiles
# $1 source file in $DOTFILES, assuming ${HOME}/.dotfiles
# $2 dest file relative to $HOME
jms::symlink() {
  local dotfiles_dir="${HOME}/.dotfiles"
  local dotfile="${dotfiles_dir}/${1}"
  local homefile="$2"
  local homefilepath="${HOME}/${homefile}"

  mkdir -p "$(dirname "$homefilepath")"
  jms::symlinking "$homefile" "$dotfile" && ln -fns "$dotfile" "$homefilepath"
}
