#!/usr/bin/fish

set fish_greeting

set -gx EDITOR nvim
set -x DOTFILES ~/.dotfiles
set -x XDG_CONFIG_HOME ~/.config
set -x XDG_CACHE_HOME ~/.cache
set -x XDG_DATA_HOME ~/.local/share
set -x PYENV_ROOT ~/.local/pyenv
set -x PATH $PYENV_ROOT/shims $PYENV_ROOT/bin $PATH
set -x PATH $HOME/.cargo/bin $PATH

if status is-interactive
  source $XDG_CONFIG_HOME/fish/abbreviations.fish
  source ~/.asdf/asdf.fish
  source (pyenv init -| psub)
  if type -q theme_gruvbox
    theme_gruvbox dark medium
  end
end

# fzf
echo $fisher_user_paths | grep ~/.fzf/bin > /dev/null
or set --universal fish_user_paths $fish_user_paths ~/.fzf/bin

# fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

set -g fisher_path $XDG_CONFIG_HOME/fish/fisher

set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]

for file in $fisher_path/conf.d/*.fish
  builtin source $file 2> /dev/null
end

# Local settings
if test -e $DOTFILES/local/config.fish
  source $DOTFILES/local/config.fish
end
