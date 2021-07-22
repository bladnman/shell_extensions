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
    local RANDOM=$$$(date +%s)
    local expressions=(
      "Happy days sir"
      "Happy days sir"
      "Happy days sir"
      "Happy days sir"
      "Happy days sir"
      "Happy days sir"
      "Happy days sir"
      "Happy days sir"
      "Happy days sir"
      "Better than I had hoped"
      "I knew you had this one sir"
      "Awesome work sir"
      "Awesome work sir"
      "Awesome work sir"
      "Awesome work sir"
      "Awesome work sir"
      "Awesome work sir"
      "Awesome work sir"
      "That is how it is done sir"
      "They will build a statue of you sir"
      "Random happy sentiment expressed with joy"
    )
    local selectedexpression=${expressions[$RANDOM % ${#expressions[@]} + 1]}
    _sh_say $selectedexpression
    true
    return
  else
    local RANDOM=$$$(date +%s)
    local expressions=(
      "I would try that again"
      "I would try that again"
      "I would try that again"
      "Not sure that's what you meant"
      "Sorry sir"
      "Sorry sir"
      "Sorry sir"
      "Sorry sir"
      "Sorry sir"
      "Sorry sir"
      "Sorry sir"
      "Sorry sir"
      "Sorry sir"
      "Maybe again with effort, sir?"
      "Think you'd better take a look at this"
      "Dissatisfied emoji"
      "Thumbs down sir"
      "I believe in you sir"
      "Don't give up sir"
      "Don't give up sir"
      "Don't give up sir"
      "Don't give up sir"
      "Chosen message of future success here"
    )
    local selectedexpression=${expressions[$RANDOM % ${#expressions[@]} + 1]}
    _sh_say $selectedexpression
    false
    return
  fi
}
