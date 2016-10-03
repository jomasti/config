[ -z "$PS1" ] && return

source "${DOTFILES}/shell/before.sh"

. "${ZDOTDIR}/config.zsh"
. "${ZDOTDIR}/bindings.zsh"
. "${ZDOTDIR}/completion.zsh"
. "${ZDOTDIR}/aliases.zsh"
. "${ZDOTDIR}/prompt.zsh"

if [ "$(hostname)" = joshuastieferMBP ]; then
  . "${ZDOTDIR}/work.zsh"
fi

if [ -e  ~/.rbenv ]; then
  export PATH="${HOME}/.rbenv/bin:${PATH}"
  eval "$(rbenv init -)"
fi

jms::source ~/.fzf.zsh
jms::source ~/.k/k.sh
jms::source ~/git/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
jms::source ~/git/alias-tips/alias-tips.plugin.zsh

jms::has fasd &&  eval "$(fasd --init auto)"

source "${DOTFILES}/shell/after.sh"
