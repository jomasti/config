HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=2000

# History
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt hist_allow_clobber
setopt extended_history
setopt inc_append_history

setopt noclobber
setopt interactivecomments
setopt printexitvalue
setopt extendedglob
setopt correct
setopt autolist
setopt auto_resume
setopt short_loops

export EDITOR='vim'
export BROWSER='luakit'
export PAGER='less'
if [[ "${COLORTERM}" == "gnome-terminal" && "${TERM}" != "xterm"  ]]; then
	export TERM="gnome-256color"
elif [[ "${COLORTERM}" == "xfce4-terminal" ]]; then
  export TERM="xterm-256color"
fi
export UZBL_UTIL_DIR=$XDG_DATA_HOME/uzbl/util/
export INTEL_BATCH=1
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export ARCH_HASKELL="Joshua Stiefer <facedelajunk@gmail.com>"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export SDL_VIDEO_FULLSCREEN_DISPLAY=1
