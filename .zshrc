HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000
bindkey -v

export http_proxy=127.0.0.1:8118
export EDITOR=vim
export XTERM=urxvt

autoload -U compinit compinit
autoload colors zsh/terminfo
colors

set prompt_subst
set autocd

#export PS1="%m%  [%~] $ "
PROMPT=$'%{\e[0;34m%}%B┌─[%b%{\e[0m%}%n%{\e[0;34m%}@%{\e[0m%}%m%{\e[0;34m%}%B]%b%{\e[0m%} - %{\e[0;34m%}%B[%b%{\e[0;34m%}'%D{"%a %b %d, %I:%M"}$'%{\e[0;34m%}%B]%b%{\e[0m%}
%{\e[0;34m%}%B└─[%b%{\e[0m%}%~%{\e[0;34m%}%B]%b%{\e[0;34m%}>%{\e[0m%} '

alias mipod='sudo sh /home/josh/Scripts/ipodmount.sh'
alias uipod='sudo sh /home/josh/Scripts/ipodumount.sh'
alias ls='ls --color=auto'
