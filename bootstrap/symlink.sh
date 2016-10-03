#!/usr/bin/env bash
#
# Basic symlinks, safe to run on any system
#

set -e

# ============================================================================
# initialize script and dependencies
# ============================================================================

cd "$(dirname "$0")/.." || exit 1
readonly dotfiles_path="$(pwd)"
source "${dotfiles_path}/shell/helpers.sh"

# ============================================================================
# Main
# ============================================================================

__symlink() {
  jms::status "Symlinking dotfiles"

  # ctags
  # jms::symlink ctags/dot.ctags                      .ctags

  # XDG-compatible
  # jms::symlink git/dot.gitconfig                    .config/git/config
  # jms::symlink git/dot.gitignore                    .config/git/ignore
  # jms::symlink shell/dot.inputrc                    .config/readline/inputrc

  # (n)vim
  # jms::symlink vim                                  .vim
  # jms::symlink vim                                  .config/nvim

  # default tern-project
  # jms::symlink ternjs/dot.tern-project              .tern-project


  case "$OSTYPE" in
    darwin*)
      ;;
    linux*)
      ;;
  esac


  # symlink shells ---------------------------------------------------------------
  # jms::symlink bash/dot.bashrc                      .bashrc
  # jms::symlink bash/dot.bash_profile                .bash_profile
  jms::symlink zsh/dot.zshenv                       .zshenv

  jms::status "Done! [symlink.sh]"
}

__symlink
