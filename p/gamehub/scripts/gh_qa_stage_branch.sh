#!/bin/bash
## - - - - - - - -
## CONFIG
## - - - - - - - -
#
#
# Root repo folder for rnps-game-hub
__CODE_FOLDER_ROOT_GH=~/code/p/rnps-game-hub

# Console folder for builds
# __CONSOLE_DEST_PATH=/data/rnps/gamehub-bun/
__CONSOLE_DEST_PATH=

# Console IP
# ARGUMENT:
#    -ip=<IP>
__CONSOLE_IP=10.125.43.243 # default to this... can be set with param: -ip=<IP>

# QA Manifest Name
# leave blank to not set manifest
# ARGUMENT:
#
__MANIFEST_URL=mhttps://urlconfig.rancher.sie.sony.com/u/mmaher/game-hub-qa

# Build as dev build
__IS_DEV=false

# Branch to build by default
# leave blank to build what is on disk at the moment
__BRANCH=

## end config
## - - - - - - - - -

_SCRIPT_NAME_='GameHub Build and Pusher'
__IS_REQUESTING_HELP=false

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
  START_TIME=$SECONDS

  if ! __hasAllRequiredParams || $__IS_REQUESTING_HELP; then
    __printUsage
    false
    return
  fi

  echo
  echo
  __echo_blue "➡️ ${_SCRIPT_NAME_} : starting"
  echo
  __echo_blue "  - - - - - - -"
  __echo_blue "∙ Moving to GameHub root directory ..."
  echo
  cd $__CODE_FOLDER_ROOT_GH

  # do all branch work
  # verify clean, checkout, update
  if [[ ! -z $__BRANCH ]]; then
    # bail if it fails
    if ! __checkoutBranch; then
      false
      return
    fi
  else
    __echo_blue "  - - - - - - -"
    __echo_blue "∙ no branch provided, skipping all branch steps"
  fi

  # building
  echo
  __echo_blue "  - - - - - - -"
  __echo_blue "∙ building the project ..."
  echo
  if $__IS_DEV; then
    npm run ci:build-dev
  else
    npm run ci:build
  fi

  echo
  __echo_blue "  - - - - - - -"
  __echo_blue "∙ pushing to console [${__CONSOLE_DEST_PATH}] ..."
  echo
  prospero-cli $__CONSOLE_IP upload --host-path=./bundles --target-path=${__CONSOLE_DEST_PATH} --is-directory

  # moving manifest
  if [[ ! -z $__MANIFEST_URL ]]; then
    echo
    __echo_blue "  - - - - - - -"
    __echo_blue "∙ moving manifest to QA manifest ..."
    echo
    prospero-cli $__CONSOLE_IP set manifest-url $__MANIFEST_URL

  else
    echo
    __echo_yellow "  - - - - - - -"
    __echo_yellow "∙ no manifest url value"
    __echo_yellow "∙ make sure your manifest uses the local folder for gamehub"
  fi

  # COMPLETE : DURATION
  echo
  __echo_green "  - - - - - - -"
  ELAPSED_TIME=$(($SECONDS - $START_TIME))
  __echo_green "✅ All done! Completed in $(displaytime $ELAPSED_TIME)"

}

# =--=--=--=--=--=--=--=--=--=--=--=--=--=--
# FUNCTIONS
# =--=--=--=--=--=--=--=--=--=--=--=--=--=--
function _init() {
  __setParams $@
  __set_colors_if_unset
}
function __hasAllRequiredParams() {
  if [[ -z $__CODE_FOLDER_ROOT_GH ]] ||
    [[ -z $__CONSOLE_IP ]] ||
    [[ -z $__CONSOLE_DEST_PATH ]]; then
    false
  else
    true
  fi
}
function __printUsage() {
  __echo_yellow "${_SCRIPT_NAME_} : usage"

  SCRIPT_DIR=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")
  SCRIPT_FULL_PATH="$SCRIPT_DIR/$(basename -- "$0")"

  echo "Usage:"
  echo "  REQUIRED"
  echo "  -i, -ip, -ip-address        ip address of console."
  echo "  -d, -dest, -destination     full path on the console"
  echo "                              where build we be placed."
  echo "  -s, -source                 root directory to gamehub; "
  echo "                              where you cloned the repo."
  echo
  echo "  OPTIONAL"
  echo "  -b, -branch                 branch name:"
  echo "                                - if empty code will build as-is."
  echo "                                  (no checkout, no yarn)"
  echo "  -m, -manifest-url           manifest url to set on console:"
  echo "                                - if empty manifest will not be set."
  echo "  -dev                        build in dev mode (skips minify)."

}
function __checkoutBranch() {

  # bail - not a git repo
  if __git__isnot_git_tree; then
    echo "Current folder contains no git repo"
    false
    return
  fi

  # bail - changes in this git tree
  if __git__has_changes; then
    __echo_red "❌ There are unhandled changes in this git tree."
    echo "This command only works on a clean tree."
    false
    return
  fi

  # checkout
  echo
  __echo_blue "  - - - - - - -"
  __echo_blue "∙ Checking out branch [${__BRANCH}] ..."
  echo
  git checkout $__BRANCH

  # validate we got the right one
  if [[ $__BRANCH != $(__git__current_branch_name) ]]; then
    echo $__BRANCH
    echo $(__git__current_branch_name)
    __echo_red "❌ It seems like our checkout did not work"
    echo "Possible that you asked for a branch that does not exist?"
    false
    return
  fi

  # pull
  echo
  __echo_blue "  - - - - - - -"
  __echo_blue "∙ git pull'ing ..."
  echo
  git pull

  # updating modules
  echo
  __echo_blue "  - - - - - - -"
  __echo_blue "∙ yarn updating ..."
  echo
  yarn

  true
  return
}
function __setParams() {
  for origParam in "$@"; do
    cleanParam=$(echo $origParam | sed s/^--/-/)
    case $cleanParam in
    -m=* | -man=* | -manifest=* | manifest-url=*)
      __MANIFEST_URL="${cleanParam#*=}"
      shift
      ;;
    -s=* | -source=*)
      __CODE_FOLDER_ROOT_GH="${cleanParam#*=}"
      shift
      ;;
    -i=* | -ip=* | -ip-address=*)
      __CONSOLE_IP="${cleanParam#*=}"
      shift
      ;;
    -d=* | -dest=* | -destination=*)
      __CONSOLE_DEST_PATH="${cleanParam#*=}"
      shift
      ;;
    -b=* | -branch=*)
      __BRANCH="${cleanParam#*=}"
      shift
      ;;
    -dev=*)
      __IS_DEV=true
      shift
      ;;
    -h=* | -help)
      __IS_REQUESTING_HELP=true
      shift
      ;;
    *)
      # unknown option
      ;;
    esac
  done

  # echo "__MANIFEST_URL          = ${__MANIFEST_URL}"
  # echo "__CODE_FOLDER_ROOT_GH   = ${__CODE_FOLDER_ROOT_GH}"
  # echo "__CONSOLE_IP            = ${__CONSOLE_IP}"
  # echo "__CONSOLE_DEST_PATH     = ${__CONSOLE_DEST_PATH}"
  # echo "__BRANCH                = ${__BRANCH}"
  # echo "__IS_DEV                = ${__IS_DEV}"
}

# =--=--=--=--=--=--=--=--=--=--=--=--=--=--
# HELPERS / UTILS
# =--=--=--=--=--=--=--=--=--=--=--=--=--=--
function __set_colors_if_unset() {
  if [[ -z $SH_COLOR_BLACK ]]; then
    SH_COLOR_BLACK='\033[0;30m'
    SH_COLOR_WHITE='\033[0;37m'
    SH_COLOR_RED='\033[0;31m'
    SH_COLOR_YELLOW='\033[0;33m'
    SH_COLOR_GREEN='\033[0;32m'
    SH_COLOR_CYAN='\033[0;36m'
    SH_COLOR_BLUE='\033[0;36m'
    SH_COLOR_NC='\033[0m' # No Color
    SH_COLOR_BOLD=$(tput bold)
    SH_COLOR_NORMAL=$(tput sgr0)
  fi
}
function __echo_blue() {
  echo "${SH_COLOR_BLUE}${1}${SH_COLOR_NC}"
}
function __echo_red() {
  echo "${SH_COLOR_RED}${1}${SH_COLOR_NC}"
}
function __echo_yellow() {
  echo "${SH_COLOR_YELLOW}${1}${SH_COLOR_NC}"
}
function __echo_green() {
  echo "${SH_COLOR_GREEN}${1}${SH_COLOR_NC}"
}
function __cmd__exists() {
  if [[ $(which ${1}) =~ not\ found ]]; then
    false
  else
    true
  fi
}
function __git__is_git_tree() {
  if [[ $(_git__status) =~ fatal ]]; then
    false
    return
  else
    true
    return
  fi
}
function __git__isnot_git_tree() {
  if _git__is_git_tree; then
    false
    return
  else
    true
    return
  fi
}
function __git__has_changes() {
  if _git__isnot_git_tree; then
    false
    return
  fi
  # -z testing for empty
  if [[ -z $(_git__status) ]]; then
    false
    return
  else
    true
    return
  fi
}
function __git__status() {
  # execute the command and look at both
  # standard out and standard error
  echo $(git status --porcelain 2>&1)
}
function __git__local_branch_exists() {
  # https://stackoverflow.com/q/5167957/473501
  #
  # note: this only checks local-known branches!
  #
  git show-ref --verify --quiet refs/heads/$1
  # $? == 0 means local branch with <branch-name> exists.
}
function __git__current_branch_name() {
  # https://stackoverflow.com/a/24210877/473501
  git branch --no-color | grep -E '^\*' | awk '{print $2}' ||
    echo "default_value"
  # or
  # git symbolic-ref --short -q HEAD || echo "default_value";
}

# =--=--=--=--=--=--=--=--=--=--=--=--=--=--
# LAUNCH
# =--=--=--=--=--=--=--=--=--=--=--=--=--=--
_init $@
_main
