# modified from https://github.com/sorin-ionescu/prezto/blob/master/modules/prompt/functions/prompt_steeef_setup

function prompt_precmd {
  # Check for untracked files or updated submodules since vcs_info does not.
  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    branch_format="(${_prompt_colors[1]}%b%f%u%c${_prompt_colors[4]}●%f)"
  else
    branch_format="(${_prompt_colors[1]}%b%f%u%c)"
  fi

  zstyle ':vcs_info:*:prompt:*' formats "${branch_format}"

  vcs_info 'prompt'
}

function prompt_setup {
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS
  prompt_opts=(cr percent subst)

  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  add-zsh-hook precmd prompt_precmd

  _prompt_colors=(
    "%F{cyan}"
    "%F{yellow}"
    "%F{magenta}"
    "%F{red}"
    "%F{green}"
    "%F{blue}"
  )

  local branch_format="${_prompt_colors[1]}%b%f%u%c"
  local action_format="${_prompt_colors[5]}%a%f"
  local unstaged_format="${_prompt_colors[2]}●%f"
  local staged_format="${_prompt_colors[5]}●%f"

  zstyle ':vcs_info:*' enable bzr git hg svn
  zstyle ':vcs_info:*:prompt:*' check-for-changes true
  zstyle ':vcs_info:*:prompt:*' unstagedstr "${unstaged_format}"
  zstyle ':vcs_info:*:prompt:*' stagedstr "${staged_format}"
  zstyle ':vcs_info:*:prompt:*' actionformats "${branch_format}${action_format}"
  zstyle ':vcs_info:*:prompt:*' formats "${branch_format}"
  zstyle ':vcs_info:*:prompt:*' nvcsformats   ""

  PROMPT="${_prompt_colors[3]}%n%f at ${_prompt_colors[6]}%m%f in ${_prompt_colors[5]}%~%f "'${vcs_info_msg_0_}'""$'\n'"$ "
  RPROMPT=''
}

prompt_setup "$@"
