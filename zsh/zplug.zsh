# zplug.zsh
#
# Loaded by zplug when path assigned to ZPLUG_LOADFILE
#
# Use repo format for oh-my-zsh plugins so no random crap is sourced
#
# Make sure fpaths are defined before or within zplug -- it calls compinit
# again in between loading plugins and nice plugins.
#

# ----------------------------------------------------------------------------
# Mine
# ----------------------------------------------------------------------------


# ----------------------------------------------------------------------------
# Vendor
# ----------------------------------------------------------------------------

zplug "plugins/colored-man-pages", from:oh-my-zsh

# Various program completions
zplug "zsh-users/zsh-completions"

# Suggestions like fish
zplug "zsh-users/zsh-autosuggestions"

# Remind me about my own aliases
zplug "djui/alias-tips"

zplug "supercrabtree/k"

# fork of rupa/z with better completion (so needs defer)
zplug "knu/z",  \
  use:"z.sh",   \
  defer:2

zplug "lukechilds/zsh-better-npm-completion", defer:2

# Inspire confidence that I am using an actual command/file
# zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "zdharma/fast-syntax-highlighting", defer:3

zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

# ==============================================================================
# Add zplug's man to MANPATH
# ==============================================================================

MANPATH="${ZPLUG_ROOT}/doc/man:${MANPATH}"
export MANPATH
