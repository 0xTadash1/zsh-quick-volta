# zsh-quick-volta

Install Volta, and enable environment variables and completion!

> Volta: JS Toolchains as Code. ⚡
> 
> -- [volta-cli/volta](https://github.com/volta-cli/volta)

## Features

- Automatic Installation if not already installed
- Automatic Generation of Completion Files 
  - Run `volta completions zsh` if `_volta` doesn't exists or doesn't has size greater than zero
- Automatic Activation
  - If `$VOLTA_HOME` is already set by you, respect it. By default, `~/.volta` will be used. 

## Usage

Just Install! via Your favorite plugin manager

## Required

- `curl`
  - This plugin use official installer(`curl https://get.volta.sh | bash -s -- --skip-setup`), it call `curl` inside. 

## Installation

### Zinit

```shell
zinit light-mode for 0xTadash1/zsh-quick-volta
```

or When installing and using `volta` on `~/.local/volta` with Zinit's Turbo-mode:

```shell
zinit wait lucid light-mode for atinit'VOLTA_HOME="${HOME}/.local/volta"' 0xTadash1/zsh-quick-volta
```

## TODO

- [ ] better support for zinit
- [ ] test with other plugin manager
  - [ ] zplug
  - [ ] antigen
  - [ ] zgen
- [ ] better completions install process
- [ ] post installation hook..?
  - node, npm, yarn, or npm packages installation

## LICENSE

This repository is licensed under a [MIT license](https://github.com/0xTadash1/zsh-quick-volta/blob/main/LICENSE).

