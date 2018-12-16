# shell/dot.profile

# Used by /bin/sh shell
# Sourced on login shells only
# Sourced by ~/.bash_profile if in a BASH login shell
# Sourced by $ZDOTDIR/.zprofile if in a ZSH login shell
# NOTE: macOS always starts a login shell

JMS_SOURCE="${JMS_SOURCE} -> shell/dot.profile {"
source "${DOTFILES}/shell/helpers.sh"
[ -z "${JMS_INIT}" ] && source "${HOME}/.dotfiles/shell/init.sh"

# ==============================================================================
# env management -- Node, Python, Ruby, Rust - These add to path
# ==============================================================================

source "${DOTFILES}/shell/node.sh"
source "${DOTFILES}/shell/python.sh"
source "${DOTFILES}/shell/ruby.sh"
source "${DOTFILES}/shell/rust.sh"

# ============================================================================
# Local path
# ============================================================================

PATH="${HOME}/.local/bin:${PATH}"
PATH="${DOTFILES}/bin:${PATH}"
export PATH

# ==============================================================================

export JMS_SOURCE="${JMS_SOURCE} }"

# vim: ft=sh :
