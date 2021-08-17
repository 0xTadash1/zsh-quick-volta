# zsh-quick-volta

Install Volta, and enable environment variables and completion!

> Volta: JS Toolchains as Code. ⚡
> 
> -- [volta-cli/volta](https://github.com/volta-cli/volta)

## Features

- Automatic Installation if not already installed
- Automatic Generation of Completion Files 
  - Run `volta completions zsh` if `_volta` exists and has size greater than zero
- Automatic Activation
  - If `$VOLTA_HOME` is already set by you, respect it. By default, `~/.volta` will be used. 

## Required

- `curl`
  - This plugin use official installer(`curl https://get.volta.sh | bash -s -- --skip-setup`), it call `curl` inside. 

## Installation

### Zinit

```shell
zinit light-mode for 0xTadash1/zsh-quick-volta
```

or You install `volta` to `~/.local/volta` with Zinit's Turbo-mode:
```shell
zinit wait lucid light-mode for atinit'VOLTA_HOME="~/.local/volta"' 0xTadash1/zsh-quick-volta
```

### Zplug

```shell
zplug "0xTadash1/zsh-quick-volta"
```

### Zgen

```shell
zgen load "0xTadash1/zsh-quick-volta"
```

## LICENSE
This repository is licensed under a MIT license.

