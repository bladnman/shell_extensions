
#--------------------------
# Alias work found at:
# http://hayne.net/MacDev/Bash/aliases.bash
#--------------------------
# The following aliases (save & show) are for saving frequently used directories
# You can save a directory using an abbreviation of your choosing. Eg. save ms
# You can subsequently move to one of the saved directories by using cd with
# the abbreviation you chose. Eg. cd ms  (Note that no '$' is necessary.)
# (I got this technique from Michael Boyle in the late 1980's at Visual Edge)
alias sdirs='source ~/.dirs'
alias show='cat ~/.dirs'
save () { /usr/bin/sed "/$@/d" ~/.dirs > ~/.dirs1; \mv ~/.dirs1 ~/.dirs; echo "$@"=\"`pwd`\" >> ~/.dirs; source ~/.dirs ; }
# Initialization for the above 'save' facility: source the .sdirs file:
sdirs
# set the bash option so that no '$' is required when using the above facility
shopt -s cdable_vars
#-------
