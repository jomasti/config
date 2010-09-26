# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
alias mpd='mpd && scrobby && ncmpcpp'

# PS1='[\u@\h \W]\$ '
PS1="┌─[\A][\u@\h:\w]\n└─> "

export http_proxy=127.0.0.1:8118
export EDITOR=vim
PATH=$PATH:~/bin
