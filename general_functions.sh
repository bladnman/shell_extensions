alias ipAddress='ipconfig getifaddr en0'
alias ipWIFI='ipconfig getifaddr en0'
alias ipWired='ipconfig getifaddr en3'

sayIP() {
    IPWIFI=`ipWIFI`;
    echo $IPWIFI;
}

#--------------------------
# cdf: cd's to frontmost window of Finder
cdf ()
{
    currFolderPath=$( /usr/bin/osascript <<"    EOT"
        tell application "Finder"
            try
                set currFolder to (folder of the front window as alias)
            on error
                set currFolder to (path to desktop folder as alias)
            end try
            POSIX path of currFolder
        end tell
    EOT
    )
    echo "Changing Directory to Foremost Finder Window: \"$currFolderPath\""
    cd "$currFolderPath"
}

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
