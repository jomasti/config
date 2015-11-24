[ -z "$PS1" ] && return

. ~/.zsh/config.zsh
. ~/.zsh/bindings.zsh
. ~/.zsh/completion.zsh
. ~/.zsh/functions.zsh
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

[ -e ~/git/zsh-syntax-highlighting ] && . ~/git/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if command -v fasd &> /dev/null; then
  eval "$(fasd --init auto)"
fi

true
