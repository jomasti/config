#ls
case "$(uname)" in
    Linux)
        alias ls='ls --color=auto'
        alias rmi='rm -I'
        ;;
    Darwin)
        alias ls='ls -G'
        alias rmi='rm -i'
        ;;
esac
alias l='ls -lFh'
alias la='ls -laFh'

alias asu-up='sshfs jstiefer@general.asu.edu:. ~/ASU'
alias asu-down='fusermount -u ~/ASU'
alias cosmo-up='sshfs jstiefer@cosmo:. ~/cosmo'
alias cosmo-down='fusermount -u ~/cosmo'
alias ..='cd ..'
alias dh='dirs -v'
alias uzbl='uzbl-tabbed'
alias grep='egrep --color=always'
alias tmux='tmux -u -2'
alias mmaker='mmaker --no-legacy --no-debian -t Gterm OpenBox -f'
alias packer='TMPDIR=/home/josh/build packer'
alias i3log='most `find ~/.config/i3 | sort -n | tail -n 1`'
alias xlog='most ~/.local/share/xorg/Xorg.0.log'
alias xbmc="SDL_VIDEO_FULLSCREEN_HEAD=1 xbmc -fs"
alias vundle="vim +PluginInstall +qall"

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
alias pacaur='pacman -Qm'
alias pacclean='sudo pacman -Sc'

# Set up auto extension stuff
alias -s html=$BROWSER
alias -s org=$BROWSER
alias -s php=$BROWSER
alias -s com=$BROWSER
alias -s net=$BROWSER
alias -s png=feh
alias -s jpg=feh
alias -s gif=feg
alias -s odt=libreoffice
alias -s doc=libreoffice
alias -s gz=tar -xzvf
alias -s bz2=tar -xjvf
alias -s zip=unzip
alias -s java=$EDITOR
alias -s txt=$EDITOR
alias -s PKGBUILD=$EDITOR
alias -s pdf=zathura

