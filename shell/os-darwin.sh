# shell/os-darwin.sh

export JMS_SOURCE="${JMS_SOURCE} -> shell/os-darwin.sh"

# @see https://github.com/nojhan/liquidprompt/blob/master/liquidprompt
# uname is slower
export DOTFILES_OS="Darwin"
export DOTFILES_DISTRO="mac"

# homebrew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS='--require-sha'
