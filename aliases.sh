export USERNAME=whoami

alias to-bladnman='ssh bladnman@bladnman.com'
alias to-dexter='ssh dexter\ maher@DexterCraft.local'
alias start_apache='sudo apachectl start'
alias stop_apache='sudo apachectl stop'
alias restart_apache='sudo apachectl restart'
alias chromeNoSecurity='open -a Google\ Chrome --args --disable-web-security'
alias psme='ps -u $USERNAME'

alias dash='openInDash'

# # # #
# Personal Aliases
openInWebstorm() {
  open -a /Applications/WebStorm.app $1
}
openInDash() {
  open dash://$1
}
openInVisualStudioCode() {
  open -a /Applications/Visual\ Studio\ Code.app $1
}
# WS now has its own command-line launcher... let's try that (install from WS with "command-line launcher")
#alias webstorm='openInWebstorm'
alias ws='webstorm'
alias sub='sublime'
alias vsc='openInVisualStudioCode'
alias code='openInVisualStudioCode'
alias cra='npx create-react-app'
alias cls="clear && printf '\e[3J'" # full clear, screen and scroll back
alias reset_shell='clear;exec "$SHELL"'
alias rst='reset_shell'

# set title of window (iterm2)
# function title {
#     echo -ne "\033]0;"$*"\007"
# }

alias cdbrain='cd "/Users/mmaher/Library/Mobile Documents/iCloud~md~obsidian/Documents/iBrain"'

# reset shell