# The following lines were added by compinstall
zstyle :compinstall filename '/home/josh/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000
bindkey -v
# End of lines configured by zsh-newuser-install

export http_proxy=127.0.0.1:8118
export EDITOR=vim
export XTERM=urxvt

export PS1="%m%  [%~] $ "

alias mipod='sudo sh /home/josh/Scripts/ipodmount.sh'
alias uipod='sudo sh /home/josh/Scripts/ipodumount.sh'
alias ls='ls --color=auto'
