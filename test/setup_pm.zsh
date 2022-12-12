#!/usr/bin/env zsh

# This script is expected to run in container.

setup_zi-zinit() {
  sh -c "$(curl -fsSL https://git.io/get-zi)" -- -a annex -a loader
	exec zsh
  zinit self-update

  echo $'zinit wait lucid light-mode for atinit\'VOLTA_HOME="${HOME}/.local/volta"; typeset -Ax ZQVOLTA=([FPATH]=".")\' ver\'kiss\' 0xTadash1/zsh-quick-volta' >> ${ZDOTDIR:-$HOME}/.zshrc
}

setup_continuum-zinit() {
	bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
	exec zsh -i
	zinit self-update

  echo $'zinit wait lucid light-mode for atinit\'VOLTA_HOME="${HOME}/.local/volta"; typeset -Ax ZQVOLTA=([FPATH]=".")\' ver\'kiss\' 0xTadash1/zsh-quick-volta' >> ${ZDOTDIR:-$HOME}/.zshrc
}

setup_antidote() {
	(){
		# clone antidote if necessary
		[[ -e ~/.antidote ]] || git clone https://github.com/mattmc3/antidote.git ~/.antidote
		# source antidote
		. ~/.antidote/antidote.zsh
		# generate and source plugins from ~/.zsh_plugins.txt
		antidote load
	}

  # TODO
	#antidote -h 1>&2 > /dev/null
}

setup_zimfw() {
  curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
	exec zsh -i

	zimfw -h 1>&2 > /dev/null
}


setup_${PLUGIN_MGR:?'`PLUGIN_MGR` is not set.'}
