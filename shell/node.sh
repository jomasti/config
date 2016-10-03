export NVM_DIR="${XDG_CONFIG_HOME}/nvm"

jms::source "${NVM_DIR}/nvm.sh"

# npmrc switching (due to private repo use)
export NPMRC_STORE="${XDG_CONFIG_HOME}/npmrcs"
