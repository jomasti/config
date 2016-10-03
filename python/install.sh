#!/usr/bin/env bash

set -eu

# =============================================================================
# Require DOTFILES
# =============================================================================

if [ -z "$DOTFILES" ]; then
  echo ".dotfiles repo is not set up"
  exit 1
fi
source "${DOTFILES}/shell/helpers.sh"

# =============================================================================
# Main
# =============================================================================

__install() {
  # Make sure not using mac OS internal python and pip
  if pip --version | grep -q /usr/lib; then
    jms::die  "System pip detected, not running. Use a userspace python's pip."
  fi

  # Make sure has pyenv
  if ! jms::has "pyenv"; then
    jms::die  "pyenv is not installed. Install it and set up a global pyenv."
  fi

  if pyenv version | grep system >/dev/null; then
    jms::die  "Using system pyenv. Use real pyenv instead."
  fi

  jms::status "Updating global pip"
  pip install --upgrade pip

  jms::status "Updating global pip requirements"
  pip install --upgrade --requirement "${DOTFILES}/python/requirements.txt"
}

__install
