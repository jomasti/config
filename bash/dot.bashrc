# .bashrc

source "${HOME}/.dotfiles/shell/vars.sh"
source "${DOTFILES}/shell/before.sh"

export HISTFILE="${BASH_DOTFILES}/.bash_history"

set -o notify
shopt -s cmdhist
shopt -s histappend
shopt -s dotglob
shopt -s nocaseglob
shopt -s extglob
shopt -s cdspell
shopt -s cdable_vars
shopt -s no_empty_cmd_completion

set completion-ignore-case on

jms::source /etc/bash_completion
jms::source /usr/share/bash-completion/bash_completion

jms::source "${NVM_DIR}/bash_completion"

jms::source "${HOME}/.fzf.bash"

# vim: syn=sh :
