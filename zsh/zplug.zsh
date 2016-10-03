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

zplug "plugins/colored-man-pages", from:oh-my-zsh

# Various program completions
zplug "zsh-users/zsh-completions"

# Remind me about my own aliases
zplug "djui/alias-tips"

zplug "lukechilds/zsh-better-npm-completion", nice:10

# Inspire confidence that I am using an actual command/file
zplug "zsh-users/zsh-syntax-highlighting", nice:19
