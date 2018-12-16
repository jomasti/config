export JMS_SOURCE="${JMS_SOURCE} -> shell/aliases.sh"

# OS Specific aliases
case "$(uname)" in
    Linux)
        alias ls='ls --color=auto'
        alias rmi='rm -I'
        alias ports='sudo netstat -tulpan'
        ;;
    Darwin)
        alias ls='ls -G'
        alias rmi='rm -i'
        alias ports='sudo lsof -i -n -P'
        ;;
esac

# General commands
alias ..='cd ..'
alias ag='ag --path-to-ignore=$HOME/.agignore'
alias cp='cp -i'
alias mv='mv -i'
alias cpr='cp -r'
alias df='df -h'
alias dh='dirs -v'
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias diff='colordiff'
alias egrep='egrep --color=auto'
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias h='history'
alias l='ls -lh'
alias la='ls -lFA'
alias lal='ls -alFh'
alias ld='ls -ld */'
alias ll='ls -lFh'
alias mkdir='mkdir -pv'
alias path='echo $PATH | tr : "\n"'
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias reload='. $ZDOTDIR/.zshrc'
alias ssh='TERM=xterm ssh'
alias up='uptime'

# Edit dotfiles
alias ev="\${EDITOR} ~/.config/nvim/init.vim"
alias ez="\${EDITOR} ~/.zshrc -c ':args ~/.zsh/* | argdo tabe | tabdo syntax on'"

#tmux
alias tmux="tmux -f \"\${DOTFILES}/tmux/tmux.conf\""
alias tn="tmux new -s"
alias ta="tmux attach -t"
alias ts="tmux switch -t"
alias tsess="tmux list-sessions"
alias td="tmux detach"
alias tks="tmux kill-server"
alias x="exit"
alias nw='tmux new-window -c "$PWD"'

# vim: ft=sh
