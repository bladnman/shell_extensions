#!/bin/bash

## - - - - - - - -
## CONFIG
## - - - - - - - -

__pcli=prospero-cli

# Root repo folder for rnps-game-hub
# __source_path=~/code/p/rnps-game-hub
__source_path=~/Downloads

# Console folder for builds
# __dest_path=/data/rnps/gamehub-bun/
__dest_path=

# Console IP
# ARGUMENT:
#    -ip=<IP>
__console_ip=

function _main() {
  # function that will
  #   - take in a branch name
  #   - go to GH repo root folder
  #   - checkout that branch
  #   - yarn && build
  #   - push to console
  #   - set console manifest to QA
  # These steps are preceded by a few git
  # checks to mnke sure there are no changes in
  # current env... thus, safe to checkout
  # NOTE:
  #   git commands require functions set up
  #   by other shell_extention scripts
  #   (git_main.sh at the moment)

  # use a little bash magic var
  start_time=$SECONDS

  __orig_dir=$(pwd)
  cd $__source_path

  # replace " (" with "_(" since we are splitting on spaces
  local folderName=$(ls -lt --color=none | egrep '^d' | grep pup | head -1 | sed 's/ (/_(/g' | sed 's/    / /g' | sed 's/   / /g' | sed 's/  / /g' | cut -d " " -f10)
  # then return it to " (" if it's there
  folderName=$(sed 's/_(/ (/g' <<<$folderName)
  if [ -z $folderName ]; then
    __echo_red "❌ No PUP directory found. Exiting"
    return -1
  fi
  local pup_directory_path="$__source_path/$folderName"
  if [ ! -d $pup_directory_path ]; then
    __echo_red "❌ The path found for latest PUP directory was not valid. Exiting"
    echo $pup_directory_path
    cd $__orig_dir
    return -1
  fi

  pup_file_path="$pup_directory_path/PS5UPDATE.I.cex_on_devkit.intdev.qaf.PUP"
  pup_file_path=$(sed 's/\/\//\//g' <<<$pup_file_path)
  if [ ! -f $pup_file_path ]; then
    __echo_red "❌ The path seems to not include a valid PUP file. Exiting"
    echo $pup_file_path
    cd $__orig_dir
    return -1
  fi

  # ARE YOU SURE?
  directory_date=$(date -r $pup_directory_path +"%Y-%m-%d %H:%M:%S")
  __echo_blue "Latest PUP file found:"
  __echo_green "    $pup_directory_path"
  __echo_yellow "    $directory_date"
  echo

  read -q "?Would you like to install this PUP? y/[n] " answer
  if [[ "$answer" =~ ^[Nn]$ ]]; then
    echo
    __echo_red "❌ You chose to not install. Exiting"
    cd $__orig_dir
    return -1
  fi

  # START UPDATE
  echo
  echo
  __echo_blue "Beginning update:"
  p_pup_install "$pup_file_path"

  # return to the place we started
  cd $__orig_dir

  # COMPLETE : DURATION
  echo
  __echo_green "  - - - - - - -"
  elapsed_time=$(($SECONDS - $start_time))
  __echo_green "✅ All done! Completed in $(displaytime $elapsed_time)"
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
