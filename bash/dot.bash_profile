# bash/.bash_profile
#
# Login shells only -- use .bashrc exclusively
# Except OSX which always starts a login shell.
# @see http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
#

# export DKO_SOURCE="${DKO_SOURCE} -> .bash_profile {"
[ -f "${HOME}/.bashrc" ] && source "${HOME}/.bashrc"
# export DKO_SOURCE="${DKO_SOURCE} }"
# vim: ft=sh :
