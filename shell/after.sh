# shell/after.sh
#
# Runs before local/* .zshrc and .bashrc
#

# export jms_SOURCE="${DKO_SOURCE} -> shell/after.sh {"

# ==============================================================================
# Use neovim
# Now that path is available, use neovim instead of vim if it is installed
# ==============================================================================

jms::has "nvim" && {
  export EDITOR="nvim"
  export VISUAL="nvim"
}

# ==============================================================================
# Auto-manpath
# ==============================================================================

unset MANPATH

# export jms_SOURCE="${DKO_SOURCE} }"
# vim: ft=zsh :
