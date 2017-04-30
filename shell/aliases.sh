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
alias diff='colordiff'
alias egrep='grep --color=auto'
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias fgrep='grep --color=auto'
alias grep='grep --color=auto'
alias h='history'
alias l='ls -lh'
alias la='ls -lFA'
alias lal='ls -alFh'
alias ld='ls -ld */'
alias ll='ls -lFh'
alias mkdir='mkdir -pv'
alias reload='. $ZDOTDIR/.zshrc'
alias ssh='TERM=xterm ssh'
alias up='uptime'
alias vundle="vim +PluginInstall +qall"
alias vundleu="vim +PluginUpdate +qall"

# Edit dotfiles
alias ev="\${EDITOR} ~/.config/nvim/init.vim"
alias ez="\${EDITOR} ~/.zshrc -c ':args ~/.zsh/* | argdo tabe | tabdo syntax on'"

# Arch Linux stuff
alias path='echo $PATH | tr : "\n"'
alias uzbl='uzbl-tabbed'
alias mmaker='mmaker --no-legacy --no-debian -t Gterm OpenBox -f'
alias packer='TMPDIR=/home/josh/build packer'
alias i3log='less `find ~/.config/i3 | sort -n | tail -n 1`'
alias xlog='less ~/.local/share/xorg/Xorg.0.log'
alias xbmc="SDL_VIDEO_FULLSCREEN_HEAD=1 xbmc -fs"

# Pacman aliases
alias pacupg='sudo pacman -Su'         # Upgrade packages
alias pacin='sudo pacman -S'           # Install specific package(s) from the repositories
alias pacins='sudo pacman -U'          # Install specific package not from the repositories but from a file
alias pacre='sudo pacman -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si'              # Display information about a given package in the repositories
alias pacreps='pacman -Ss'             # Search for package(s) in the repositories
alias pacloc='pacman -Qi'              # Display information about a given package in the local database
alias paclocs='pacman -Qs'             # Search for package(s) in the local database
alias pacupl='pacman -Qu'			   # List packages that have updates
alias pacupd='sudo pacman -Sy'     	   # Update and refresh the local package and ABS databases against repositories
alias paclist='pacman -Ql'		   	   # List the files owned by a local package
alias pacorph='pacman -Qdt'			   # List packages no longer required as dependencies
alias pacinsd='sudo pacman -S --asdeps'        # Install given package(s) as dependencies of another package
alias pacmir='sudo pacman -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist
alias pacexpl='sudo pacman -D --asexplicit'
alias pacowns='pacman -Qo'
alias pacclean='sudo pacman -Sc'

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

alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# vim: ft=sh
