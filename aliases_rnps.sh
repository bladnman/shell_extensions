CONSOLE_IP='172.31.1.2'

alias pcli='prospero-cli $CONSOLE_IP '
alias pcon='pcli get console | sed "/^$/d"'
alias pman='pcli set manifest-url mhttp://us38f9d32262b1.am.sony.com:8080/u/mmaher/gh_helloworld '