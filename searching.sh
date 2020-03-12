#-----------
# Searching:
#-----------
# ff:  to find a file under the current directory
ff () { /usr/bin/find . -name "$@" ; }

# ffs: to find a file whose name starts with a given string
ffs () { /usr/bin/find . -name "$@"'*' ; }

# ffe: to find a file whose name ends with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }

# grepfind: to grep through files found by find, e.g. grepf pattern '*.c'
# note that 'grep -r pattern dir_name' is an alternative if want all files
grepfind () { find . -type f -name "$2" -print0 | xargs -0 grep "$1" ; }

# I often can't recall what I named this alias, so make it work either way:
alias findgrep='grepfind'
