# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
alias mpd='mpd && scrobby && ncmpcpp'
alias asu-up='sshfs jstiefer@general.asu.edu:. /~ASU'
alias asu-down='fusermount -u ~/ASU'
alias www='/usr/bin/chromium --proxy-server=127.0.0.1:8118'

# PS1='[\u@\h \W]\$ '
PS1="┌─[\A][\u@\h:\w]\n└─> "

export all_proxy=http://127.0.0.1:8118/
export ALL_PROXY=http://127.0.0.1:8118/
export EDITOR='vim'
PATH=$PATH:~/bin
