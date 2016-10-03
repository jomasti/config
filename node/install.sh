#!/usr/bin/env bash

set -e

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

# @TODO check for nvm node
__install() {
  jms::status "Installing latest NPM"
  npm install --global npm@latest

  jms::status "Installing Yeoman"
  npm install --global yo

  jms::status "Checking npm environment using yo doctor"
  yo doctor || exit 1

  jms::status "Installing global node packages"
  # peer dep packages
  npm install --global eslint

  # loop through packages.txt file and install each one
  while read -r package; do
    if [ "$package" != "yo" ] \
      && [ "$package" != "eslint" ]; then
      # npm ls --global --parseable --depth=0 "$package" ||
      npm install --global "$package"
    fi
  done < "${DOTFILES}/node/packages.txt"
}

__install "$@"
