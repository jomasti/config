#!/usr/bin/fish

set fish_greeting

set -gx EDITOR nvim

if status is-interactive
  source $HOME/.config/fish/abbreviations.fish
  source ~/.asdf/asdf.fish
  if type -q theme_gruvbox
    theme_gruvbox dark medium
  end
end

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

# aliases
if available bat
  alias cat=bat
end

if available exa
  alias ls=exa
  alias l='exa -l'
  alias la='exa -la'
end
