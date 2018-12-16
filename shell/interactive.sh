# shell/interactive.sh

JMS_SOURCE="${JMS_SOURCE} -> shell/interactive.sh {"

# need this here in case not starting a login shell
source "${DOTFILES}/shell/helpers.sh"
source "${DOTFILES}/shell/functions.sh" # shell functions
source "${DOTFILES}/shell/aliases.sh"   # generic aliases

# ============================================================================
# os specific aliases
# ============================================================================

if [ "$DOTFILES_OS" = 'Linux' ]; then
  source "${DOTFILES}/shell/aliases-linux.sh"
  case "$DOTFILES_DISTRO" in
  "archlinux" | "debian" | "fedora")
    source "${DOTFILES}/shell/aliases-${DOTFILES_DISTRO}.sh"
    ;;
  esac
fi

if [ "$DOTFILES_OS" = 'Darwin' ]; then
  source "${DOTFILES}/shell/aliases-darwin.sh"
fi

# ============================================================================

export JMS_SOURCE="${JMS_SOURCE} }"
