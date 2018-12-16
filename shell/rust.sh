JMS_SOURCE="${JMS_SOURCE} -> shell/rust.sh {"

if [[ -f "${HOME}/.cargo/env" ]]; then
  source "${HOME}/.cargo/env"
  JMS_SOURCE="${JMS_SOURCE} -> cargo"
fi

export JMS_SOURCE="${JMS_SOURCE} }"
