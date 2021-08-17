export VOLTA_HOME=${VOLTA_HOME:-"${HOME}/.volta"}
export path=(${VOLTA_HOME}/bin(N-/) ${path})

if [[ ! $(command -v volta) ]]; then
    # `curl` is called in volta installer too, so it is required
    if [[ $(command -v curl) ]]; then
        curl https://get.volta.sh | bash -s -- --skip-setup
    else
        echo '`volta` has not been installed yet. But install process needs `curl`' 1>&2
        return 1
    fi
fi

if [[ ! -s "$(dirname ${0})/_volta" ]]; then
    volta completions zsh -f -o "$(dirname ${0})/_volta"

    # if zinit is used as plugin manager
    if [[ $(command -v zinit) ]]; then
        zinit creinstall 0xTadash1/zsh-quick-volta
    fi
fi
