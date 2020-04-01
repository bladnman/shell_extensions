alias bls='/bin/ls -Fh'
alias gls='/usr/local/opt/coreutils/libexec/gnubin/ls'
alias ls='gls --color -Fh --group-directories-first'
alias ll='ls -la'
alias l.='ls -d .*'
alias lsa='ls -lart'
alias cd..='cd ..' # always missing that space!
alias .~='cd ~'    # home toto
alias ..='cd ..'
alias ...='cd ../../../'
alias c='clear'
alias h='history'
alias hg='history | grep'
alias bi="brew install"
alias ag='alias | grep'
alias sh_say='_sh_say'
alias sh_notify='_sh_notify'
alias ssay='sh_say'
alias snotif='sh_notify'
alias sn='sh_notify'

_cmd__exists() {
  if [[ $(which ${1}) =~ not\ found ]]; then
    false
    return
  fi
  true
  return
}
_sh_say() {
  say "${1}" --voice=Daniel
}
_sh_notify() {
  if [[ $? = 0 ]]; then
    _sh_say "Sir. Job done."
  else
    _sh_say "I'm sorry sir."
  fi
}
