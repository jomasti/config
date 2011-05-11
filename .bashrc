# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls -a --color=auto'
alias asu-up='sshfs jstiefer@general.asu.edu:. /~ASU'
alias asu-down='fusermount -u ~/ASU'
alias www='/usr/bin/chromium --proxy-server=127.0.0.1:8118'

# PS1='[\u@\h \W]\$ '
PS1="┌─[\A][\u@\h:\w]\n└─> "

export EDITOR='vim'
export PAGER='most'
PATH=$PATH:~/bin
