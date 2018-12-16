# shell/path.sh
#
# Sourced in bash and zsh by loader
# pyenv, chruby, chphp, nvm pathing is done in shell/after
#

export JMS_SOURCE="${JMS_SOURCE} -> shell/path.sh"

# ==============================================================================
# Store default system path
# ==============================================================================

# Probably created via /etc/profile and /etc/profile.d/*
#
# On macOS/OS X/BSD path_helper is run in /etc/profile, which generates paths
# using /etc/paths and /etc/paths.d/* and defines the initial $PATH
# Something like "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"
#
# On arch, via /etc/profile, default path is:
# /usr/local/sbin:/usr/local/bin:/usr/bin
export JMS_SYSTEM_PATH="${JMS_SYSTEM_PATH:-${PATH}}"

# On BSD system, e.g. Darwin -- path_helper is called, reads /etc/paths
# Move local bin to front for homebrew compatibility
#if [ -x /usr/libexec/path_helper ]; then
PATH="$JMS_SYSTEM_PATH"

# enforce local bin and sbin order
PATH="/usr/local/bin:/usr/local/sbin:${PATH}"

export PATH
