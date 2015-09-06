[ -z "$PS1" ] && return

. ~/.zsh/config.zsh
. ~/.zsh/bindings.zsh
. ~/.zsh/completion.zsh
. ~/.zsh/functions.zsh
. ~/.zsh/aliases.zsh
. ~/.zsh/prompt.zsh

if [ -e  ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

[ -e ~/.fzf.zsh ] && . ~/.fzf.zsh

[ -e ~/git/zsh-syntax-highlighting ] && . ~/git/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

true
