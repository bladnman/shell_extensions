#!/bin/bash
whichVersionLabel="Which version would you like to install"
nothingInstallingLabel="⛔️ You chose to not install. Exiting"
_pupDir="" # to be set in setter function

_setSelectedPupDir() {
  count=0
  directoryList=($(ls ~/code/p/PUPs -1pt | grep / | sed 's/\///'))
  for dir in "${directoryList[@]}"; do
    let count++
    echo "$count) $dir"
  done

  read "?$whichVersionLabel? [none] " answer

  if [[ ! -z "$answer" ]]; then
    # get selected dir name
    _pupDir=$directoryList[$answer]
  fi
}

_setSelectedPupDir
if [[ "$_pupDir" == "" ]]; then
  echo $nothingInstallingLabel
  return -1
fi

# continue on installing
echo $_pupDir
