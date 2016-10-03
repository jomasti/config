#!/usr/bin/env bash
#
# Symlink X11 settings
#

set -eu

# ============================================================================
# initialize script and dependencies
# ============================================================================

cd "$(dirname "$0")/.." || exit 1
readonly dotfiles_path="$(pwd)"
source "${dotfiles_path}/shell/helpers.sh"

# ==============================================================================
# Main
# ==============================================================================

jms::status "Symlinking X11 dotfiles"
# this probably isn't sourced by your session
jms::symlink linux/.xinitrc       .xinitrc
jms::symlink linux/.xprofile      .xprofile
