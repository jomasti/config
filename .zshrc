HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000
DIRSTACKSIZE=8
bindkey -v

export EDITOR=vim
export BROWSER=firefox
if [[ "${COLORTERM}" == "gnome-terminal" && "${TERM}" != "xterm"  ]]; then
	export TERM="gnome-256color"
fi
export PATH=$PATH:~/bin

autoload -U compinit compinit
autoload colors zsh/terminfo
colors

setopt autopushd pushdminus pushdsilent pushdtohome
setopt prompt_subst
setopt autocd
setopt cdablevars
setopt nohup
setopt histignoredups
setopt histignorespace
setopt noclobber
setopt interactivecomments

#export PS1="%m%  [%~] $ "
PROMPT=$'%{\e[0;34m%}%B┌─[%b%{\e[0m%}%n%{\e[0;34m%}@%{\e[0m%}%m%{\e[0;34m%}%B]%b%{\e[0m%} - %{\e[0;34m%}%B[%b%{\e[0;34m%}'%D{"%a %b %d, %I:%M"}$'%{\e[0;34m%}%B]%b%{\e[0m%}
%{\e[0;34m%}%B└─[%b%{\e[0m%}%~%{\e[0;34m%}%B]%b%{\e[0;34m%}>%{\e[0m%} '

alias mipod='sudo sh /home/josh/Scripts/ipodmount.sh'
alias uipod='sudo sh /home/josh/Scripts/ipodumount.sh'
alias ls='ls --color=auto'
alias asu-up='sshfs jstiefer@general.asu.edu:. /~ASU'
alias asu-down='fusermount -u ~/ASU'
alias ..='cd ..'
alias dh='dirs -v'

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
alias pacupd='sudo pacman -Sy && sudo abs'     # Update and refresh the local package and ABS databases against repositories
alias pacinsd='sudo pacman -S --asdeps'        # Install given package(s) as dependencies of another package
alias pacmir='sudo pacman -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist

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
alias -s java=$EDITOR
alias -s txt=$EDITOR
alias -s PKGBUILD=$EDITOR

define() {
	    curl -s dict://dict.org/d:$1 | grep -v '^[0-9]'
}
