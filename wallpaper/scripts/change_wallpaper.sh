#!/bin/bash
## - - - - - - - -
## WALLPAPER SETTER
## Download `desktoppr` from
##    https://github.com/scriptingosx/desktoppr
## Put the executable in
##    /usr/local/bin
## Set up your folder of images to choose from
WALLPAPER_PATH="~/Documents/uDesktop NEXT Library/Catalog"
WALLPAPER_PATH_CLEAN=$(sed 's/ /\\ /g' <<<"$WALLPAPER_PATH")
WALLPAPER_LOGGING=0          # 0-false, 1-true
WALLPAPER_DETAILED_LOGGING=1 # 0-false, 1-true
## - - - - - - - -

function main() {
  __log "$(date)"

  local newpath=$(__wp_get_new_random)

  __log "/usr/local/bin/desktoppr \"$newpath\""

  /usr/local/bin/desktoppr "$newpath"
  __log ""
}
function __log() {
  if [[ $WALLPAPER_LOGGING == 1 ]]; then
    echo $1 >>~/logs/wallpaper.log
  fi
}
function __logDetailed() {
  if [[ $WALLPAPER_DETAILED_LOGGING == 1 ]]; then
    __log $1
  fi
}
function randomFile() {
  tmpFile=$(mktemp)

  files=$(find . -type f >$tmpFile)
  total=$(cat "$tmpFile" | wc -l)
  randomNumber=$(($RANDOM % $total))

  i=0
  while read line; do
    if [ "$i" -eq "$randomNumber" ]; then
      # Do stuff with file
      amarok $line
      break
    fi
    i=$(($i + 1))
  done <$tmpFile
  rm $tmpFile
}
function __wp_get_new_random() {
  local __resultvar=$1

  local currentpath=''
  local newpath
  newpath=$(__wp_get_random)

  # KEEP IT UNIQUE
  # local currentpath=$(desktoppr 0)
  # while [ $newpath == $currentpath ]; do
  #   newpath=$(__wp_get_random)
  # done

  __logDetailed "__wp_get_new_random got $newpath"

  if [[ "$__resultvar" ]]; then
    eval $__resultvar="'$newpath'"
  else
    echo "$newpath"
  fi
}
function __wp_get_random() {

  dir="$WALLPAPER_PATH"
  n_files=$(/bin/ls -1 "$dir" | /usr/bin/wc -l | /usr/bin/cut -f1)
  rand_num=$(awk "BEGIN{srand();print int($n_files * rand()) + 1;}")
  file=$(/bin/ls -1 "$dir" | sed -ne "${rand_num}p")
  path=$(cd $dir && echo "$PWD/$file") # Converts to full path.

  local __resultvar=$1
  local filename=$(ls "$WALLPAPER_PATH" | /usr/bin/sort -R | /usr/bin/tail -1)
  local fullpath="$WALLPAPER_PATH/$filename"

  __logDetailed "__wp_get_random got filename [$filename]"
  __logDetailed "__wp_get_random got fullpath [$fullpath]"

  if [[ "$__resultvar" ]]; then
    eval $__resultvar="'$fullpath'"
  else
    echo "$fullpath"
  fi
}

########################
# MAIN
########################
main
