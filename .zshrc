# zsh syntax highlighting (obviously)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export ARCH_HASKELL="Joshua Stiefer <facedelajunk@gmail.com>"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

autoload -U compinit promptinit colors zcalc zsh-mime-setup zsh/terminfo
compinit
promptinit
zsh-mime-setup
colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg svn

setopt autopushd pushdminus pushdsilent pushdtohome
setopt prompt_subst
#setopt autocd
setopt cdablevars
setopt nohup

# History
setopt histignoredups
setopt histignorespace
setopt extended_history
setopt append_history
setopt share_history

# Search history
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^[[A' history-beginning-search-backward-end
bindkey '^[[B' history-beginning-search-forward-end

setopt noclobber
setopt interactivecomments
setopt printexitvalue

#export PS1="%m%  [%~] $ "
PROMPT=$'%{\e[0;34m%}%B┌─[%b%{\e[0m%}%n%{\e[0;34m%}@%{\e[0m%}%m%{\e[0;34m%}%B]%b%{\e[0m%} - %{\e[0;34m%}%B[%b%{\e[0;34m%}'%D{"%a %b %d, %I:%M"}$'%{\e[0;34m%}%B]%b%{\e[0m%}
%{\e[0;34m%}%B└─[%b%{\e[0m%}%~%{\e[0;34m%}%B]%b%{\e[0;34m%}>%{\e[0m%} '

# allow approximate
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# bind keys
bindkey -v
bindkey '^R' history-incremental-search-backward

# Safety first
alias rm='rm -I'

# aliases
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -lh --color=auto'
alias lal='ls -lha --color=auto'
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

# Functions
define() { curl -s dict://dict.org/d:$1 | grep -v '^[0-9]' }

fu() { curl -s "http://www.commandlinefu.com/commands/matching/$@/$(echo -n $@ | openssl base64)/plaintext" | grep -v "^# commandlinefu" }

mdc() { mkdir -p "$1" && cd "$1" }

extract() {
  if [ -f $1 ] ; then
    case $1 in 
      *.tar.bz2)  tar xjvf $1   ;;
      *.tbz2)     tar xjvf $1   ;;
      *.tar.gz)   tar xzvf $1   ;;
      *.tgz)      tar xzvf $1   ;;
      *.tar.xz)   tar xJvf $1   ;;
      *.tar)      tar xvf $1    ;;
      *.bz2)      bunzip2 $1    ;;
      *.rar)      unrar x $1    ;;
      *.gz)       gunzip $1     ;;
      *.zip)      unzip $1      ;;
      *.ace)      unace $1      ;;
      *.Z)        uncompress $1 ;;
      *.7z)       7z x $1       ;;
      *)          echo "'$1' cannot be extracted."a ;;
    esac
  else
    echo "'$1' is not a valid file."
  fi
}

rename_mp3() {
    find . -type f -exec sh -c 'test $(file --brief --mime-type "$0") == "audio/mpeg"' {} \; -print | xargs -t -i mv {} {}.mp3
}

connect_monitor() {
	  xrandr --output LVDS --primary --mode 1600x900 --pos 0x0 --output VGA-0 --mode 1680x1050 --pos 1600x0  
}


# Console
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0222222" #black
    echo -en "\e]P8222222" #darkgrey
    echo -en "\e]P1803232" #darkred
    echo -en "\e]P9982b2b" #red
    echo -en "\e]P25b762f" #darkgreen
    echo -en "\e]PA89b83f" #green
    echo -en "\e]P3aa9943" #brown
    echo -en "\e]PBefef60" #yellow
    echo -en "\e]P4324c80" #darkblue
    echo -en "\e]PC2b4f98" #blue
    echo -en "\e]P5706c9a" #darkmagenta
    echo -en "\e]PD826ab1" #magenta
    echo -en "\e]P692b19e" #darkcyan
    echo -en "\e]PEa1cdcd" #cyan
    echo -en "\e]P7ffffff" #lightgrey
    echo -en "\e]PFdedede" #white
    clear #for background artifacting
fi
