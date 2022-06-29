#!/usr/bin/env zsh

typeset package='zqvolta'
typeset packageRoot="${${(%):-%x}:A:h}"

${package}.main() {
    # Export variables and check for `curl` existence
    ${package}.init || return 1
    
    case "${ZQVOLTA[VERSION_CHECK]}" in
    notice)
        ${package}.versionOk || \
            echo "You can \`${package}.Install\` to install '${ZQVOLTA[VERSION]}'." ;;
    
    question)
        ${package}.versionOk || {
            echo -n '==> Update now? [y/N]: '
            read -q && ${package}.Install
        } ;;
    
    immediate)
        ${package}.versionOk || ${package}.Install ;;
    
    background)
        ( { ${package}.versionOk || ${package}.Install } > /dev/null & ) ;;
    
    nocheck)
        ;;
    esac
}

${package}.init() {
    typeset -Ax ZQVOLTA

    # Varidation
    local -A allowed_regex=(
        [VERSION]='^(latest|([1-9]+[0-9]*|0)(\.([1-9]+[0-9]*|0)){2})$'
        [VERSION_CHECK]='^(notice|question|immediate|background|nocheck)$'
    )
    local key regex
    for key regex in ${(kv)allowed_regex}; do
        [[ -n "${ZQVOLTA[$key]}" && "${ZQVOLTA[$key]}" =~ "$regex" ]] || {
            echo "==> \${ZQVOLTA[$key]} is invalid. Fallback to default." 1>&2
        }
    done

    : ${ZQVOLTA[VERSION]:='latest'}
    : ${ZQVOLTA[VERSION_CHECK]:='question'}
    : ${ZQVOLTA[FPATH]:="${packageRoot}/functions"}

    # Instead of `volta setup`
    export VOLTA_HOME="${VOLTA_HOME:-"${HOME}/.volta"}"
    export path=("${VOLTA_HOME}/bin"(N-/) ${path})

    if ! type curl >& /dev/null; then
        echo '==> zsh-quick-volta requires `curl` to check for the latest version,' >&2
        echo '    download the installer script and run that.' >&2
        return 1
    fi
}

${package}.Install() {
    typeset -Ax ZQVOLTA
    : ${ZQVOLTA[VERSION]:='latest'}
    : ${ZQVOLTA[FPATH]:="${packageRoot}/functions"}
    export VOLTA_HOME="${VOLTA_HOME:-"${HOME}/.volta"}"

    echo "==> Start Volta Installation. Request: ${ZQVOLTA[VERSION]} [1/2]"

    # Download and Run the install script
    curl -fsS 'https://get.volta.sh' | bash -s -- --skip-setup --version "${ZQVOLTA[VERSION]}" && {
        
        echo '==> Next, install volta completions. [2/2]'

        # `--force`: overwrite
        volta completions zsh --force --output "${ZQVOLTA[FPATH]}/_volta" && {
            [[ -z "${fpath[(r)${ZQVOLTA[FPATH]}]}" ]] && export fpath+=( "${ZQVOLTA[FPATH]}" )

            echo '==> Successfully Installed all!'
            echo
            echo '==> You don'\''t have to `volta setup` to set environment variables.'
            echo '    These are done by loading this plugin. So your dotfiles are kept clean :)'
            
        } || {
            echo '==> Failed to install the completions.' >&2

            command rm -rfv "${VOLTA_HOME}"

            # To goto `echo '==> Filed to Install.' >&2` block.
            # Don't use `return` which escape whole `curl ...` block.
            false
        }
    } || {
        echo '==> Failed to Install.' >&2
        return 1
    }
}

${package}.versionOk() {
    # Get local version
    if type volta >& /dev/null; then
        local -a raw_local_v=( ${(s/./)$(volta -v)} )
        local -a local_v=$(( ${raw_local_v[1]} * 1000000 + ${(j/./)raw_local_v[2,3]} * 1000 ))
    else
        echo '==> Volta has not been installed.' 1>&2
        return 1
    fi

    if [[ "${ZQVOLTA[VERSION]}" = 'latest' ]]; then
        # Get latest release's version

        # Check latest version code via redirect
        # For exmaple, redirect to 'https://github.com/**/releases/tag/v1.0.7'
        local url='https://github.com/volta-cli/volta/releases/latest'
        local -a raw_latest_v=(
            # `##*/v`: https://github.com/**/v1.0.7 -> 1.0.7
            ${${(s/./)$(curl -sw '%{redirect_url}' "$url")##*/v}:?"Connection failed: $url"}
        )
        local -a latest_v=$(( ${raw_latest_v[1]} * 1000000 + ${(j/./)raw_latest_v[2,3]} * 1000 ))

        # Verify
        if (( "$local_v" < "$latest_v" )); then
            echo '==> Updates are there.' "Local: ${local_v}, Latest: ${latest_v}" 1>&2
            return 1
        fi

    else
        # Verify
        if (( "$local_v" != "${ZQVOLTA[VERSION]}" )); then
            echo '==> Version mismatch.' "Local: ${local_v}, Request: ${ZQVOLTA[VERSION]}" 1>&2
            return 1
        fi
    fi
}

${package}.UninstallVolta() {
    typeset -Ax ZQVOLTA
    : ${ZQVOLTA[FPATH]:="${packageRoot}/functions"}
    : ${VOLTA_HOME:="${HOME}/.volta"}
    export VOLTA_HOME="${VOLTA_HOME:-"${HOME}/.volta"}"

    echo -n '==> Uninstall Volta? (`rm -rfv '"${VOLTA_HOME}" "${ZQVOLTA[FPATH]}/_volta"'`) [y/N]: '
    if read -q; then
        command rm -rfv "$VOLTA_HOME" "${ZQVOLTA[FPATH]}/_volta" && {
            echo '==> Successfully Uninstalled.'
        } || {
            echo '==> Failed to Uninstall.' 1>&2
            return 1
        }
    else
        echo '==> Canceled.'
    fi
}

${package}.deinit() {
    local endstatus=$?
    local glob="$1"
    unfunction "${package}.deinit" ${(Mk)functions:#"${~glob}"}
    unset package packageRoot
    return $endstatus
}


${package}.main
${package}.deinit "${package}.[0-9a-z_]*"
