#!/usr/bin/env zsh

assert() {
  echo TRIAL: ${(qq)@}
  $@ \
    && echo PASS \
    || { echo FAIL; return 1 }
}

assertFail() {
  echo TRIAL: ${(qq)@}
  $@ \
    && { echo FAIL; return 1 } \
    || echo PASS
}

alias -g passFail='&& echo pass || fail'
zqv_version() {
  # Allwed: `^(latest|([1-9]+[0-9]*|0)(\.([1-9]+[0-9]*|0)){2})$`
  local -a pattern=(
    "typeset -Ax ZQVOLTA=( [VERSION]='1.0.0' )"
    "typeset -Ax ZQVOLTA=( [VERSION]='latest' )"
    "typeset -Ax ZQVOLTA=( [VERSION]='' )"

    "typeset -Ax ZQVOLTA=( [VERSION]='1.0.0.0' )"
    "typeset -Ax ZQVOLTA=( [VERSION]='1.0' )"
    "typeset -Ax ZQVOLTA=( [VERSION]='LATEST' )"
    "typeset -Ax ZQVOLTA=( [VERSION]='10.0.0' )"
  )
  local -i f
  for p in $pattern; do
    assert $p insPin || f+=1
  done
}

if [[ "$1" = 'as-entrypoint' ]]; then

  exec zsh -i
fi
