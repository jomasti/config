# dot.bashrc

[[ -n "$TMUX" ]] && JMS_SOURCE="${JMS_SOURCE} -> ____TMUX____ {"
JMS_SOURCE="${JMS_SOURCE} -> .bashrc {"

# Just in case...
[[ -z "$DOTFILES" ]] && source "${HOME}/.dotfiles/shell/init.sh"

source "${DOTFILES}/shell/dot.profile"

# Non-interactive? Some shells/OS will source bashrc and bash_profile out of
# order or skip one entirely
[[ -z "$PS1" ]] && export JMS_SOURCE="${JMS_SOURCE} }" && return

# Interactive -- continue
source "${DOTFILES}/shell/interactive.sh"

# ============================================================================
# BASH settings
# ============================================================================

export HISTFILE="${BASH_DOTFILES}/.bash_history"

# ----------------------------------------------------------------------------
# Options
# ----------------------------------------------------------------------------

set -o notify
shopt -s cmdhist
shopt -s histappend
shopt -s dotglob
shopt -s nocaseglob
shopt -s extglob
shopt -s cdspell
shopt -s cdable_vars
shopt -s no_empty_cmd_completion

# ----------------------------------------------------------------------------
# Completions
# ----------------------------------------------------------------------------

set completion-ignore-case on

jms::source /etc/bash_completion
jms::source /usr/share/bash-completion/bash_completion

jms::source "${NVM_DIR}/bash_completion"

# ==============================================================================
# Plugins
# ==============================================================================

jms::source "${HOME}/.fzf.bash"

# ==============================================================================
# After
# ==============================================================================

source "${DOTFILES}/shell/after.sh"

# ==============================================================================

export JMS_SOURCE="${JMS_SOURCE} }"

# vim: ft=sh :
