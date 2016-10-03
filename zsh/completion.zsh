# autoload -U compinit
# compinit
zmodload -i zsh/complist

setopt noauto_remove_slash
setopt list_types
setopt complete_in_word
setopt completealiases

zstyle ':completion:*' menu select
