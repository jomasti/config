JMS_SOURCE="${JMS_SOURCE} -> shell/vars.sh {"

# ========
# Locale
# ========

export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# ========
# Dot file paths
# ========

export DOTFILES="${HOME}/.dotfiles"
export BASH_DOTFILES="${DOTFILES}/bash"
export ZDOTDIR="${DOTFILES}/zsh"
export VIM_DOTFILES="${DOTFILES}/vim"

# =========
# XDG
# =========

export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"

# user-dirs.dirs doesn't exist on macOS/OS X so check first.
# Exporting is fine since the file is generated via xdg-user-dirs-update
# and should have those vars. I am just using the defaults but want them
# explicitly defined.
[ -f "${XDG_CONFIG_HOME}/user-dirs.dirs" ]      \
  && source "${XDG_CONFIG_HOME}/user-dirs.dirs" \
  && export                             \
    XDG_DESKTOP_DIR                     \
    XDG_DOWNLOAD_DIR                    \
    XDG_TEMPLATES_DIR                   \
    XDG_PUBLICSHARE_DIR                 \
    XDG_DOCUMENTS_DIR                   \
    XDG_MUSIC_DIR                       \
    XDG_PICTURES_DIR                    \
    XDG_VIDEOS_DIR                      \
  && JMS_SOURCE="${JMS_SOURCE} -> user-dirs.dirs"

export BROWSER="firefox"

export TERMINAL="termite"

export EDITOR="vim"
export VISUAL="gvim"

export PAGER="less"

export JAVA_FONTS="/usr/share/fonts/TTF"

export LESS="-eFRX"
export LESSHISTFILE=-

export PYENV_ROOT="$HOME/.pyenv"

export TZ="America/Phoenix"

export SHELL_ALIASES="$HOME/.shell_aliases"
export SHELL_FUNCTIONS="$HOME/.shell_functions"

export UZBL_UTIL_DIR="$XDG_DATA_HOME/uzbl/util/"

export INTEL_BATCH=1

export ARCH_HASKELL="Joshua Stiefer <facedelajunk@gmail.com>"

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

export SDL_VIDEO_FULLSCREEN_DISPLAY=1

export XINITRC="${DOTFILES}/x/.xinitrc"

export _JAVA_AWT_WM_NONREPARENTING=1

# ============================================================================

export JMS_SOURCE="${JMS_SOURCE} }"

# vim: ft=sh
