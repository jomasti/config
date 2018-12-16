# init.sh

# Sourced on all shells, interactive or not

JMS_SOURCE="${JMS_SOURCE} -> shell/init.sh {"
export JMS_INIT=1

# ============================================================================

source "${HOME}/.dotfiles/shell/vars.sh"

# OS specific overrides, OSTYPE is not POSIX so these won't run except in
# modern shells
case "$OSTYPE" in
darwin*) source "${DOTFILES}/shell/os-darwin.sh" ;;
linux*) source "${DOTFILES}/shell/os-linux.sh" ;;
esac

# Rebuild path starting from system path
# Regarding tmux:
# Since my tmux shells are not login shells the path needs to be rebuilt.
# shell/vars.sh on the other hand just get inherited.
source "${DOTFILES}/shell/path.sh"

# ============================================================================

export JMS_SOURCE="${JMS_SOURCE} }"
