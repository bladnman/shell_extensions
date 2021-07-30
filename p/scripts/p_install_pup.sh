#!/bin/bash

## - - - - - - - -
## CONFIG
## - - - - - - - -

__pcli=prospero-cli

# Root repo folder for PUPS
__source_path=/Users/mmaher/code/p/PUPs

# Console folder for builds
__dest_path=

# Console IP
# ARGUMENT:
#    -ip=<IP>
__console_ip=

whichVersionLabel="Which version would you like to install"
nothingInstallingLabel="⛔️ You chose to not install. Exiting"
invalidLocationLabel="❌ No PUP file found at location to install."
_pup_path="" # to be set in setter function

_setSelectedPupDir() {
  local count=0
  local directoryList=()
  # do this, do NOT parse 'ls'... take my word for it!
  local orig_dir=$(pwd)
  cd $__source_path
  for item in */; do
    local cleaned=$(echo $item | sed 's/\///')
    directoryList+=($cleaned)
  done
  cd $orig_dir
  for dir in "${directoryList[@]}"; do
    let count++
    echo "  ${sh_color_green}$count) $dir${sh_color_nc}"
  done

  echo
  __echo_yellow $whichVersionLabel
  read "?  ? [none] " answer

  if [[ ! -z "$answer" ]]; then
    local selectedDirName=$directoryList[$answer]
    local thisPupDirPath=$__source_path/$selectedDirName
    local installFileName="PS5UPDATE.I.cex_on_devkit.intdev.qaf.PUP"
    local fileTest="$__source_path/$directoryList[$answer]/$installFileName"
    # test for file
    if [[ ! -f "$fileTest" ]]; then
      echo $invalidLocationLabel
    else
      _pup_path=$fileTest
    fi
  fi
}
function _main() {
  # use a little bash magic var
  start_time=$SECONDS

  _print_banner

  # LET THE USER SELECT THE PUP TO PUSH
  _setSelectedPupDir

  # VERIFY THEY CHOSE SOMETHING
  if [[ "$_pup_path" == "" ]]; then
    echo $nothingInstallingLabel
    return -1
  fi

  # continue on installing

  # START UPDATE
  echo
  echo
  __echo_blue "Beginning update:"

  p_pup_install "$_pup_path"

  # COMPLETE : DURATION
  echo
  __echo_green "  - - - - - - -"
  elapsed_time=$(($SECONDS - $start_time))
  __echo_green "✅ All done! Completed in $(displaytime $elapsed_time)"
  echo
}
_print_banner() {
  echo
  echo
  echo
  __echo_yellow "888                 d8           888 888                 888 88e  8888 8888 888 88e  "
  __echo_yellow "888 888 8e   dP\"Y  d88    ,\"Y88b 888 888      ,\"Y88b     888 888D 8888 8888 888 888D "
  __echo_yellow "888 888 88b C88b  d88888 \"8\" 888 888 888 888 \"8\" 888 888 888 88\"  8888 8888 888 88\"  "
  __echo_yellow "888 888 888  Y88D  888   ,ee 888 888 888     ,ee 888     888      8888 8888 888      "
  __echo_yellow "888 888 888 d,dP   888   \"88 888 888 888     \"88 888     888      'Y88 88P' 888      "
  echo
}

# =--=--=--=--=--=--=--=--=--=--=--=--=--=--
# FUNCTIONS
# =--=--=--=--=--=--=--=--=--=--=--=--=--=--
function _init() {
  __setParams $@
  __set_colors_if_unset
}
function __setParams() {
  for origParam in "$@"; do
    cleanParam=$(echo $origParam | sed s/^--/-/)
    case $cleanParam in
    -s=* | -source=*)
      __source_path="${cleanParam#*=}"
      shift
      ;;
    -i=* | -ip=* | -ip-address=*)
      __console_ip="${cleanParam#*=}"
      shift
      ;;
    -h | -help)
      __is_requesting_help=true
      shift
      ;;
    *)
      # unknown option
      ;;
    esac
  done

}

# =--=--=--=--=--=--=--=--=--=--=--=--=--=--
# HELPERS / UTILS
# =--=--=--=--=--=--=--=--=--=--=--=--=--=--
function __set_colors_if_unset() {
  if [[ -z $sh_color_black ]]; then
    sh_color_black='\033[0;30m'
    sh_color_white='\033[0;37m'
    sh_color_red='\033[0;31m'
    sh_color_yellow='\033[0;33m'
    sh_color_green='\033[0;32m'
    sh_color_cyan='\033[0;36m'
    sh_color_blue='\033[0;36m'
    sh_color_nc='\033[0m' # No Color
    sh_color_bold=$(tput bold)
    sh_color_normal=$(tput sgr0)
  fi
}
function __echo_blue() {
  echo "${sh_color_blue}${1}${sh_color_nc}"
}
function __echo_red() {
  echo "${sh_color_red}${1}${sh_color_nc}"
}
function __echo_yellow() {
  echo "${sh_color_yellow}${1}${sh_color_nc}"
}
function __echo_green() {
  echo "${sh_color_green}${1}${sh_color_nc}"
}

# =--=--=--=--=--=--=--=--=--=--=--=--=--=--
# LAUNCH
# =--=--=--=--=--=--=--=--=--=--=--=--=--=--
_init $@
_main
