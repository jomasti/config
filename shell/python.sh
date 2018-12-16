JMS_SOURCE="${JMS_SOURCE} -> shell/python.sh {"

unset PYTHONPATH

export PYLINTHOME="${XDG_CONFIG_HOME}/pylint"

export PYENV_ROOT="${HOME}/.local/pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
jms::has "pyenv" && {
  JMS_SOURCE="${JMS_SOURCE} -> pyenv"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
}

# Default virtualenv
export WORKON_HOME="${HOME}/.local/virtualenv"

# Disable virtualenv in prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Assign global var to virtualenv name
virtualenv_info() {
  venv=''
  # Strip out the path and just leave the env name
  [ -n "$VIRTUAL_ENV" ] && venv="${VIRTUAL_ENV##*/}"
  [ -n "$venv" ] && echo "$venv"
}

# ==============================================================================
# pip
# ==============================================================================

jms::has "pip" && {
  if [ -n "$ZSH_VERSION" ]; then
    eval "$(pip completion --zsh)"
  elif [ -n "$BASH" ]; then
    eval "$(pip completion --bash)"
  fi
}

export JMS_SOURCE="${JMS_SOURCE} }"

# vim: ft=sh :
