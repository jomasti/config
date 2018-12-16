# .zshrc

[[ -n "$TMUX" ]] && JMS_SOURCE="${JMS_SOURCE} -> ____TMUX____ {"
JMS_SOURCE="${JMS_SOURCE} -> .zshrc {"

source "${HOME}/.dotfiles/shell/dot.profile"
source "${DOTFILES}/shell/interactive.sh"

source "${ZDOTDIR}/config.zsh"
source "${ZDOTDIR}/completion.zsh"
source "${ZDOTDIR}/aliases.zsh"
source "${ZDOTDIR}/bindings.zsh"
# source "${ZDOTDIR}/prompt.zsh"

if [ "$(hostname)" = joshuastieferMBP ]; then
  source "${ZDOTDIR}/work.zsh"
fi

typeset -gU cdpath fpath path manpath

# ============================================================================
# zplug
# ============================================================================

source "${ZDOTDIR}/zplugdoctor.zsh"
export ZPLUG_HOME="${XDG_DATA_HOME}/zplug"
# plugin definitions file -- don't set before zplug is installed
export ZPLUG_LOADFILE="${ZDOTDIR}/zplug.zsh"

readonly JMS_ZPLUG_INIT="${ZPLUG_HOME}/init.zsh"

# ----------------------------------------------------------------------------
# zplug - load cli
# ----------------------------------------------------------------------------

__load_zplug_init() {
  if [ -f "$JMS_ZPLUG_INIT" ]; then
    source "$JMS_ZPLUG_INIT"
    # export JMS_SOURCE="${JMS_SOURCE} -> ${JMS_ZPLUG_INIT}"
  else
    jms::warn "Did not find zplug/init.zsh"
  fi
}

# ----------------------------------------------------------------------------
# zplug - auto-install (new install)
# ----------------------------------------------------------------------------

if [ ! -f "$JMS_ZPLUG_INIT" ]; then
  jms::status "(Re)installing zplug"
  rm -rf "${ZPLUG_HOME}"
  git clone https://github.com/zplug/zplug.git "$ZPLUG_HOME" \
    && __load_zplug_init

else # Already installed, check if need to re-source for new shell
  # Note: ZPLUG_ROOT is manually unset in .zshenv ! This ensures plugins are
  # loaded for tmux and subshells (e.g. `exec $SHELL`)
  __load_zplug_init
fi

if ! zplug check; then
  jms::status "Installing zplug plugins"
  zplug install
fi

# ----------------------------------------------------------------------------
# zplug - define plugins
# ----------------------------------------------------------------------------

jms::has "zplug" && {
  # export JMS_SOURCE="${JMS_SOURCE} -> zplug {"
  zplug load >/dev/null
  # export JMS_SOURCE="${JMS_SOURCE} }"
}

jms::source ~/.fzf.zsh

jms::has fasd &&  eval "$(fasd --init auto)"

# ============================================================================
# Local
# ============================================================================

source "${DOTFILES}/shell/after.sh"

# ============================================================================

export JMS_SOURCE="${JMS_SOURCE} }"
