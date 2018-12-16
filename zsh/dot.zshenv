# dot.zshenv

JMS_SOURCE="${JMS_SOURCE} -> .zshenv {"

# ============================================================================
# ZSH settings
# ============================================================================

# using prompt expansion and modifiers to get
#   realpath(dirname(absolute path to this file)
#   https://github.com/filipekiss/dotfiles/commit/c7288905178be3e6c378cc4dea86c1a80ca60660#r29121191
export ZDOTDIR="${${(%):-%N}:A:h}"
export ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zshcache"

unset ZPLUG_ROOT

# ============================================================================

export JMS_SOURCE="${JMS_SOURCE} }"

# vim: ft=zsh
