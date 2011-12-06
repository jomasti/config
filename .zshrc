# zsh syntax highlighting (obviously)
source /usr/share/zsh/plugins/zsh-syntax-highlight/zsh-syntax-highlighting.zsh

HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000
DIRSTACKSIZE=8

export EDITOR='vim'
export BROWSER='luakit'
export PAGER='most'
if [[ "${COLORTERM}" == "gnome-terminal" && "${TERM}" != "xterm"  ]]; then
	export TERM="gnome-256color"
fi
export UZBL_UTIL_DIR=$XDG_DATA_HOME/uzbl/util/
export INTEL_BATCH=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'

autoload -U compinit compinit
autoload colors zsh/terminfo
colors

setopt autopushd pushdminus pushdsilent pushdtohome
setopt prompt_subst
#setopt autocd
setopt cdablevars
setopt nohup
setopt histignoredups
setopt histignorespace
setopt append_history
setopt noclobber
setopt interactivecomments

#export PS1="%m%  [%~] $ "
PROMPT=$'%{\e[0;34m%}%B┌─[%b%{\e[0m%}%n%{\e[0;34m%}@%{\e[0m%}%m%{\e[0;34m%}%B]%b%{\e[0m%} - %{\e[0;34m%}%B[%b%{\e[0;34m%}'%D{"%a %b %d, %I:%M"}$'%{\e[0;34m%}%B]%b%{\e[0m%}
%{\e[0;34m%}%B└─[%b%{\e[0m%}%~%{\e[0;34m%}%B]%b%{\e[0;34m%}>%{\e[0m%} '

# allow approximate
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# bind keys
bindkey -v
bindkey '^R' history-incremental-search-backward

# aliases
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -lh --color=auto'
alias lal='ls -lha --color=auto'
alias asu-up='sshfs jstiefer@general.asu.edu:. ~/ASU'
alias asu-down='fusermount -u ~/ASU'
alias ..='cd ..'
alias dh='dirs -v'
alias uzbl='uzbl-tabbed'
alias grep='egrep --color=always'
alias tmux='tmux -u -2'
alias pacman='pacman-color'
alias mmaker='mmaker --no-legacy --no-debian -t Gterm OpenBox -f'
alias packer='TMPDIR=/home/josh/build packer'

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

# Functions
define() { curl -s dict://dict.org/d:$1 | grep -v '^[0-9]' }

fu() { curl -s "http://www.commandlinefu.com/commands/matching/$@/$(echo -n $@ | openssl base64)/plaintext" | grep -v "^# commandlinefu" }
