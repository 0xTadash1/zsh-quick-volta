# zsh-quick-volta 🅩⚡

Zsh plugin for Volta lovers.

> Volta: JS Toolchains as Code. ⚡
> 
> -- [volta-cli/volta](https://github.com/volta-cli/volta)

## Features

- [x]  **Automatic install**
  - [x] If `VOLTA_HOME` is set, it's respected. (default: `$HOME/.volta`)
  - [x] You can specify to install version. (default: `latest`)
    - E.g. `typeset -Ax ZQVOLTA=( [VERSION]='1.2.3' )`
- [x]  **Automatic update**
  - When `ZQVOLTA[VERSION]` is unset or `latest`.
  - (Note that update Volta itself but not this plugin.)
  - You can cofigure this behaviour.
- [x] **Automatic env variables setup without ever effects to your `.zshrc`**
  - `export VOLTA_HOME=...` and `export PATH=...` are automaticaly done by loading this plugin.
- [x] Easy to uninstall Volta
  - Just run `zqvolta.UninstallVolta` function.
- [x]  **Automatic completions (re)generation on every install/update**
  - [x] `ZQVOLTA[FPATH]` is as the completions directory. (default: _&lt;PLUGIN_ROOT&gt;_`/functions`)

## Requirements

- `curl`
  - This plugin use the official installer (`curl https://get.volta.sh | bash -s -- --skip-setup`) and itself also `curl` inside.
  - To check updates.

## Installation

### ZI, Zinit

```sh
zinit light for 0xTadash1/zsh-quick-volta
```

or When installing and using `volta` at `~/.local/volta` with Zinit's Turbo-mode:

```sh
zinit wait lucid light for atinit'VOLTA_HOME="${HOME}/.local/volta"' 0xTadash1/zsh-quick-volta
```

### antidote

- :octocat: [mattmc3/antidote](https://github.com/mattmc3/antidote)
  > Antidote is a feature complete Zsh implementation of the legacy Antibody plugin manager.
- 🏠 [GetAntidote](https://getantidote.github.io/)

```sh
antidote install 0xTadash1/zsh-quick-volta
```

### zimfw

```sh
zmodule 0xTadash1/zsh-quick-volta
```

### Oh-my-zsh

### Prezto

### zpm

### zgenom

### zsh-snap

## Configure

The bahaviors can be changed via `ZQVOLTA`. `ZQVOLTA` is an associated array (key-value, dictionary) variable in Zsh.
To apply the changes, `ZQVOLTA` must be set **before** the plugin is loaded.

> #### Hint
>
> ```sh
> typeset -Ax ZQVOLTA
> ```
>
> This means:
>
> - Set a variable `ZQVOLTA`.
> - It is `A`ssociated array.
> - It is e`x`ported.

### Specify The Version

- `ZQVOLTA[VERSION]`
  - You can specify the version to be installed. By default, `latest` version will be installed.\
  The format is based on [SemVer](https://semver.org)'s "MAJOR.MINOR.PATCH".
  - Default: `latest`
  - Allowed: `^(latest|([1-9]+[0-9]*|0)(\.([1-9]+[0-9]*|0)){2})$`
  - <details open><summary>Example</summary><p>

    ```sh
    # Specify the version
    typeset -Ax ZQVOLTA=( [VERSION]='1.0.8' )
    # Bad. You cannot omit.
    typeset -Ax ZQVOLTA=( [VERSION]='1.0' )
    ```

    ```sh
    # Track latest release (default)
    typeset -Ax ZQVOLTA=( [VERSION]='latest' )
    ```

    </p></details>

### Configure Update Conditions

- `ZQVOLTA[VERSION_CHECK]`
  - Control update/install behaviour. Set `nocheck` to disable checking updates.
  - Default: `question`
  - Allowed: `^(notice|question|immediate|background|nocheck)$`
  - <details open><summary>Example</summary><p>

    ```sh
    # If there're new releases, only show short message.
    typeset -Ax ZQVOLTA=( [VERSION_CHECK]='notice' )
    ```

    ```sh
    # It ask to question whether update now `[y/N]`-style. (default)
    typeset -Ax ZQVOLTA=( [VERSION_CHECK]='question' )
    ```

    ```sh
    # No question. Immediately update in foreground.
    typeset -Ax ZQVOLTA=( [VERSION_CHECK]='immediate' )
    ```

    ```sh
    # Like `immediate`. However, this makes to update in background.
    typeset -Ax ZQVOLTA=( [VERSION_CHECK]='background' )
    ```

    ```sh
    # Disable update check.
    # Even though, you can manually update by `ZQVOLTA[VERSION]='latest' zqvolta.Install`.
    typeset -Ax ZQVOLTA=( [VERSION_CHECK]='nocheck' )
    ```

    </p></details>

### Specify the completions directory (fpath)

- `ZQVOLTA[FPATH]`
  - The location to install completion scripts for Volta. In Zsh, completion files should be in a directory in the environment variable `fpath` (or `FPATH`) in order to be loaded. If `ZQVOLTA[FPATH]` dir is not in `fpath` when the plugin is loaded, it will be added.\
  To avoid `fpath` bloat or to use a directory provided by the plugin manager, enter an alternate absolute path in this variable. The completions will be installed there.\
  If `.` is assigned, the completions will be placed directly under the root of the plugin, and `fpath` will not be changed. This is useful for users who want to let plugin managers do the completions (un)installation and load.
  - Default: _\<PLUGIN_ROOT>_`/functions`
  - Allowed: User writable directory. OR `.`.
  - <details><summary>Example</summary><p>
    </p></details>

# TODO

- ZQVOLTA[FPATH] = '.'
- test
- how 2 install

## LICENSE

[MIT](https://github.com/0xTadash1/zsh-quick-volta/blob/main/LICENSE)

