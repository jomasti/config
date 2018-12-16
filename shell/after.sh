# shell/after.sh
#
# Runs before local/* .zshrc and .bashrc
#

JMS_SOURCE="${JMS_SOURCE} -> shell/after.sh {"

# ==============================================================================
# Use neovim
# Now that path is available, use neovim instead of vim if it is installed
# ==============================================================================

jms::has "nvim" && {
  export EDITOR="nvim"
  export VISUAL="nvim"
}

# ==============================================================================

unset JMS_INIT
export JMS_SOURCE="${JMS_SOURCE} }"
