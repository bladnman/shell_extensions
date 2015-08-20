alias bls='/bin/ls -Fh'
alias gls='/usr/local/opt/coreutils/libexec/gnubin/ls'
alias ls='gls --color -Fh --group-directories-first'
alias ll='ls -la'
alias l.='ls -d .*'
alias lsa='ls -lart'
alias cd..='cd ..'    # always missing that space!
alias .~='cd ~'       # home toto
alias ..='cd ..'
alias ...='cd ../../../'
alias c='clear'
alias h='history'
alias hg='history | grep'
alias bi="brew install"
alias ag='alias | grep'

alias to-bladnman='ssh bladnman@bladnman.com'
alias to-dexter='ssh dexter\ maher@DexterCraft.local'
alias start_apache='sudo apachectl start'
alias stop_apache='sudo apachectl stop'
alias restart_apache='sudo apachectl restart'
alias chromeNoSecurity='open -a Google\ Chrome --args --disable-web-security'

# # # #
# Personal Aliases
openInWebstorm () {
    open -a /Applications/WebStorm.app $1
}
alias webstorm='openInWebstorm';
alias ws='webstorm';
alias sub='sublime';

# set title of window (iterm2)
function title {
    echo -ne "\033]0;"$*"\007"
}
