#!/usr/bin/env bash
#
# Cleanup home for XDG compliance
#

set -e

# ============================================================================
# initialize script and dependencies
# ============================================================================

cd "$(dirname "$0")/.." || exit 1
readonly dotfiles_path="$(pwd)"
source "${dotfiles_path}/shell/helpers.sh"

# ============================================================================
# ENV validation
# ============================================================================

if [ -z "$BASH_DOTFILES" ] \
  || [ -z "$XDG_CONFIG_HOME" ] \
  || [ -z "$XDG_DATA_HOME" ]
then
  jms::err  "DOTFILES are not set up, run this after symlinking and restarting"
  jms::err_ "shell"
  exit 1
fi

# ============================================================================
# Cleanup functions
# ============================================================================

# Move entire dir or file somewhere else (create dir if needed)
# $1 full path to move (can be file or dir)
# $2 full destination path
__move() {
  jms::status "Move ${1} to ${2}"

  if [ ! -d "$1" ] && [ ! -f "$1" ] && [ ! -h "$1" ]; then
    jms::status_ "OK, didn't find ${1}"
    return 0
  fi

  if [ -d "$2" ] || [ -f "$2" ] || [ -h "$2" ]; then
    jms::err  "Not moving ${1} to ${2}, destination already exists."
    jms::err_ "Please resolve conflict manually."
    return 1
  fi

  local dest_parent
  dest_parent="$(dirname "${2}")"
  if [ ! -d "$dest_parent" ]; then
    mkdir -p "$dest_parent" \
      && jms::status_ "Created parent directory ${dest_parent}"
  fi

  mv "$1" "$2" && jms::status_ "Moved ${1} to ${2}"
}

# Move contents of one dir into another
# $1 source directory, removed on completion
# $2 destination directory, created if needed
__merge_dir() {
  jms::status "Merge ${1} into ${2}"

  if [ ! -d "$1" ]; then
    jms::status_ "OK, didn't find ${1}"
    return 0
  fi

  if [ ! -d "$2" ]; then
    mkdir -p "$2" \
      && jms::status_ "Created dest directory ${2}"
  fi

  mv "${1}/*"   "$2" && jms::status_ "Moved contents of ${1} into ${2}"
  mv "${1}/.*"  "$2" && jms::status_ "Moved .contents in ${1} into ${2}"
  rmdir "$1" && jms::status_ "Removed ${1}"
}

# Remove file or dir completely with confirmation
# $1 path to completely remove
__remove() {
  jms::status "Remove ${1}"

  if [ -f "$1" ] || [ -h "$1" ]; then
    rm -i   "$1" && jms::status_ "Removed file ${1}"
  elif [ -d "$1" ]; then
    rm -ir  "$1" && jms::status_ "Removed directory ${1}"
  else
    jms::status_ "OK, didn't find ${1}"
  fi
}

# Logic for NVM
__clean_nvm() {
  jms::status "Move invalid NVM paths"

  if [ "${NVM_DIR}" != "${XDG_CONFIG_HOME}/nvm" ]; then
    jms::err "NVM_DIR not set properly. Should be ${XDG_CONFIG_HOME}/nvm"
    return 1
  fi

  mkdir -p "${NVM_DIR}"

  # Move if wrong place
  __move "${XDG_CONFIG_HOME}/.nvm" "$NVM_DIR"

  # Move if wrong name
  __move "${HOME}/.nvm" "$NVM_DIR"
}

# ============================================================================
# main
# ============================================================================

# __move      "${HOME}/.bash_history"   "${BASH_DOTFILES}/.bash_history"
# __move      "${HOME}/.composer"       "${XDG_CONFIG_HOME}/composer"
# __move      "${HOME}/.gimp-2.8"       "${XDG_CONFIG_HOME}/GIMP/2.8"
# __move      "${HOME}/.inputrc"        "${XDG_CONFIG_HOME}/readline/inputrc"
# __move      "${HOME}/.wget-hsts"      "${XDG_DATA_HOME}/wget/.wget-hsts"
# # PYLINTHOME is set
# __move      "${HOME}/.pylint.d"       "${XDG_CONFIG_HOME}/pylint"
# __merge_dir "${HOME}/.fonts"          "${XDG_DATA_HOME}/fonts"
# # HISTFILE is set
# # INPUTRC is set

# # Removes
# __remove "${HOME}/.bash_profile"
# __remove "${HOME}/.bashrc"
# __remove "${HOME}/.zshenv"
# # alias points to dotfile
# __remove "${HOME}/.mdlrc"
# # should be in XDG
# __remove "${HOME}/.pulse-cookie"
# # should be symlinked in XDG
# __remove "${HOME}/.gitconfig"
# # should be symlinked in XDG
# __remove "${HOME}/.gitignore"

# NVM
__clean_nvm

