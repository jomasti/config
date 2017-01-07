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

zplug "${ZDOTDIR}", \
  from:local, \
  use:"{bindings,prompt}.zsh"
#
# ----------------------------------------------------------------------------
# Vendor
# ----------------------------------------------------------------------------

zplug "zplug/zplug"

zplug "plugins/colored-man-pages", from:oh-my-zsh

# Various program completions
zplug "zsh-users/zsh-completions"

# Remind me about my own aliases
zplug "djui/alias-tips"

zplug "supercrabtree/k"

# fork of rupa/z with better completion (so needs defer)
zplug "knu/z",  \
  use:"z.sh",   \
  defer:2

zplug "lukechilds/zsh-better-npm-completion", defer:2

# Inspire confidence that I am using an actual command/file
zplug "zsh-users/zsh-syntax-highlighting", defer:3
