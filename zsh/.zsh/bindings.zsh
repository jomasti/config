#vi mode
bindkey -v

bindkey '^R' history-incremental-search-backward
bindkey '^W' backward-kill-word
bindkey '^P' up-history
bindkey '^N' down-history

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^f' edit-command-line

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^[[A' history-beginning-search-backward-end
bindkey '^[[B' history-beginning-search-forward-end
