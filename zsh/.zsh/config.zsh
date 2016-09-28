HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=2000

# History
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt hist_allow_clobber
setopt extended_history
setopt inc_append_history
setopt share_history
setopt hist_save_no_dups
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_no_store

setopt noclobber
setopt interactivecomments
setopt printexitvalue
setopt extendedglob
setopt correct
setopt autolist
setopt auto_resume
setopt short_loops

export EDITOR='nvim'
export BROWSER='chrome'
export PAGER='less'
if [[ "${COLORTERM}" == "gnome-terminal" && "${TERM}" != "xterm"  ]]; then
	export TERM="gnome-256color"
elif [[ "${COLORTERM}" == "xfce4-terminal" ]]; then
  export TERM="xterm-256color"
fi
export UZBL_UTIL_DIR=$XDG_DATA_HOME/uzbl/util/
export INTEL_BATCH=1
export ARCH_HASKELL="Joshua Stiefer <facedelajunk@gmail.com>"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export SDL_VIDEO_FULLSCREEN_DISPLAY=1
