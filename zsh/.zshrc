[ -z "$PS1" ] && return

. ~/.shell_aliases
. ~/.shell_functions

. ~/.zsh/config.zsh
. ~/.zsh/bindings.zsh
. ~/.zsh/completion.zsh
. ~/.zsh/aliases.zsh
. ~/.zsh/prompt.zsh

if [ "$(hostname)" = joshuastieferMBP ]; then
  . ~/.zsh/work.zsh
fi

if [ -e  ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

[ -e ~/.fzf.zsh ] && . ~/.fzf.zsh
[ -e ~/.k/k.sh ] && . ~/.k/k.sh

[ -e ~/git/zsh-syntax-highlighting ] && . ~/git/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -e ~/git/alias-tips ] && . ~/git/alias-tips/alias-tips.plugin.zsh

if command -v fasd &> /dev/null; then
  eval "$(fasd --init auto)"
fi

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

true

export NVM_DIR="/home/josh/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

if command -v pyenv &> /dev/null; then
  eval "$(pyenv init -)"
fi

if [ -e ~/.pyenv/plugins/pyenv-virtualenv ]; then
  eval "$(pyenv virtualenv-init -)"
fi
