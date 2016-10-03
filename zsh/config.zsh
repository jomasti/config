HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=2000

# Changing Directories
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent
setopt pushd_to_home

# Completion
setopt autolist
setopt no_complete_aliases
setopt list_packed

# Expansion and Globbing
setopt extendedglob

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

# Input/Output
setopt aliases
setopt correct
setopt interactivecomments
setopt noclobber
setopt short_loops

# Job Control
setopt auto_resume

# Prompt
setopt prompt_subst

# Zle
setopt no_beep
setopt vi
