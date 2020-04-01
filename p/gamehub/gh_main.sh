##
##  NOTE:
##  NAMES WILL COLLIDE WITH OTHER SCRIPTS
##  take care to add this project's name to the
##  end of everything. SelectAll/Replace makes
##  it easy.
##

# -=-+-=-+-=-+-=-+
# -= ENV VARS
# -=-+-=-+-=-+-=-+
SCRIPT_DIR_GH=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")
SCRIPT_FULL_PATH_GH="$SCRIPT_DIR_GH/$(basename -- "$0")"

# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  VARS
# -=-=-=-=-=-=-=-=-=-=-=-=
MANIFEST_FOLDER_GH=~/code/p/ppr-urlconfig-dev
CODE_FOLDER_ROOT_GH=~/code/p/rnps-game-hub
CODE_FOLDER_GH=$CODE_FOLDER_ROOT_GH/packages/game-hub
TEST_E2E_FOLDER=$CODE_FOLDER_ROOT_GH/tests/e2e
SKYNETE_CHECKOUT_FOLDER=~/code/p/SkyNete

# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  ALIASES
# -=-=-=-=-=-=-=-=-=-=-=-=
alias cdgh='cd $CODE_FOLDER_GH'
alias cd_gh='cd $CODE_FOLDER_GH'
alias gh_dev='_gh__setup_env -dev -serve'
alias gh_code='_gh__setup_env -dev'
alias gh_serve='_gh__setup_env -serve'
alias gh_link_concept='_gh__link_concept_gamehub'
alias gh_link_product='_gh__link_product_gamehub'
alias gh_link_title='_gh__link_title_gamehub'
alias gh_link='_gh__link_any_gamehub'
alias gh_tc='pytest --udid=$CONSOLE_IP -m '

alias gh_qa_tc='pytest --udid=$CONSOLE_IP -m '
alias gh_qa_prep='_gh__qa_prepare; snotif'
alias gh_stage_branch='. ${SCRIPT_DIR_GH}/scripts/gh_qa_stage_branch.sh -s=$CODE_FOLDER_ROOT_GH -i=$CONSOLE_IP -d=/data/rnps/gamehub-branch/ -m=mhttps://urlconfig.rancher.sie.sony.com/u/mmaher/game-hub__device-branch; snotif '
alias gh_stage_master='gh_stage_branch -b=master -d=/data/rnps/gamehub-mast/ -m=mhttps://urlconfig.rancher.sie.sony.com/u/mmaher/game-hub__device-mast; snotif '

alias gh_man_master='_p_manifest_named game-hub__device-mast; p_kill_shell; snotif'
alias gh_man_branch='_p_manifest_named game-hub__device-branch; p_kill_shell; snotif'
alias gh_man_dev='_p_manifest_named game-hub__dev; p_kill_shell; snotif'
alias gh_man_clear='_p_manifest_named game-hub__clear; p_kill_shell; snotif'

# short-short-handers
alias smoke='_gh__run_e2e_smoke; snotif'
alias tc='_gh__run_e2e_tc; snotif'
alias ts='_gh__qa_run_test_suite_named; snotif'
alias ghs='gh_serve'
alias ghl='gh_link'
alias stage_branch='_gh__do_stage_branch'
alias stage_master='_gh__do_stage_master'
alias sb='stage_branch'
alias sm='stage_master'
alias man_master='_p_manifest_named game-hub__device-mast; p_kill_shell; snotif'
alias man_branch='_p_manifest_named game-hub__device-branch; p_kill_shell; snotif'
alias man_dev='_p_manifest_named game-hub__dev; p_kill_shell; snotif'
alias man_clear='_p_manifest_named game-hub__clear; p_kill_shell; snotif'

# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  FUNCTIONS
# -=-=-=-=-=-=-=-=-=-=-=-=
_gh__do_stage_branch() {
  . ${SCRIPT_DIR_GH}/scripts/gh_qa_stage_branch.sh -b=$1 -s=$CODE_FOLDER_ROOT_GH -i=$CONSOLE_IP -d=/data/rnps/gamehub-branch/ -m=mhttps://urlconfig.rancher.sie.sony.com/u/mmaher/game-hub__device-branch
  sh_say "Sir, your branch has been staged."
}
_gh__do_stage_master() {
  . ${SCRIPT_DIR_GH}/scripts/gh_qa_stage_branch.sh -b=master -s=$CODE_FOLDER_ROOT_GH -i=$CONSOLE_IP -d=/data/rnps/gamehub-mast/ -m=mhttps://urlconfig.rancher.sie.sony.com/u/mmaher/game-hub__device-mast
  sh_say "Sir, master has been staged."
}
_gh__qa_run_test_suite_named() {
  SUITE_NAME="${1:-Matt-Manual}"

  # need to be in the gh test root folder
  cd $TEST_E2E_FOLDER

  pytest --udid=$CONSOLE_IP --suite=$SUITE_NAME --qtest-enable .
}
_gh__qa_stage() {
  ALL_ARGS=$@
  . ${SCRIPT_DIR_GH}/scripts/gh_qa_stage_branch.sh -s=$CODE_FOLDER_ROOT_GH -i=$CONSOLE_IP -d=/data/rnps/gamehub-bun/ -m=mhttps://urlconfig.rancher.sie.sony.com/u/mmaher/game-hub__device-bun $@
}
_gh__qa_stage_branch() {
  if [[ ! $@ =~ "-b=" && ! $@ =~ "-branch=" ]]; then
    echo_red "You must indicate a branch with -b=<branch_name>"
    false
    return
  fi
  . ${SCRIPT_DIR_GH}/scripts/gh_qa_stage_branch.sh $@
}
_gh__link_concept_gamehub() {
  echo p_cli execute shellui "openuri psgamehub:main?conceptId=$@"
  p_cli execute shellui "openuri psgamehub:main?conceptId=$@"
}
_gh__link_product_gamehub() {
  echo p_cli execute shellui "openuri psgamehub:main?productId=$@"
  p_cli execute shellui "openuri psgamehub:main?productId=$@"
}
_gh__link_title_gamehub() {
  echo p_cli execute shellui "openuri psgamehub:main?titleId=$@"
  p_cli execute shellui "openuri psgamehub:main?titleId=$@"
}
_gh__run_e2e_tc() {
  PARAM=$1
  LOWER_PARAM=$(printf '%s\n' "$PARAM" | awk '{ print tolower($0) }')

  if [[ $LOWER_PARAM != *"tc"* ]]; then
    LOWER_PARAM=tc$LOWER_PARAM
  fi

  # need to be in the gh test root folder
  cd $TEST_E2E_FOLDER

  echo pytest --udid=${CONSOLE_IP} -m ${LOWER_PARAM}
  pytest --udid=${CONSOLE_IP} -m ${LOWER_PARAM}
}
_gh__run_e2e_smoke() {
  echo pytest --udid=${CONSOLE_IP} --suite=Smoke-Manual --qtest-enable tests
  pytest --udid=${CONSOLE_IP} --suite=Smoke-Manual --qtest-enable tests
}
_gh__link_any_gamehub() {
  ID=$1
  if [[ $1 == '' ]]; then
    echo "https://github.sie.sony.com/SIE-Private/rnps-game-hub/blob/master/packages/gamehub-deeplink-example/src/application/items.js"
  elif [[ $1 =~ [\-] ]]; then
    _gh__link_product_gamehub $1
  elif [[ $1 =~ [a-zA-Z] ]]; then
    _gh__link_title_gamehub $1
  else
    _gh__link_concept_gamehub $1
  fi
}
_gh__serve_manifest_gamehub() {
  cd $MANIFEST_FOLDER_GH
  yarn start &
  sleep 1
}
_gh__serve_app_gamehub() {
  cd $CODE_FOLDER_GH
  yarn start &
  sleep 1
}
_gh__open_editors_gamehub() {
  echo "Attempting to open editor to GAMEHUB"
  code $CODE_FOLDER_GH
}
_gh__serve_all_gamehub() {
  echo "Starting App server"
  trap "exit" INT TERM ERR
  trap "kill 0" EXIT
  _gh__serve_manifest_gamehub
  _gh__serve_app_gamehub
  echo "server running ..."
  wait
}
_gh__qa_prepare() {
  echo_blue "Getting you ready for QA"

  echo_blue "1. Create Virtual Environment"
  cd $SKYNETE_CHECKOUT_FOLDER
  python3 -m venv Skynete
  source ./Skynete/bin/activate

  echo_blue "2. Install GH QA Dependancies (longer)"
  cd $TEST_E2E_FOLDER
  pip install -r requirements.txt

  clear
  echo
  echo "Done."
  echo "You can now execute test cases like so:"
  echo_yellow "   > tc tc85"
  echo
}
_gh__setup_env() {
  # DEV - open editors
  if [[ $* == *"-dev"* ]]; then
    _gh__open_editors_gamehub
  fi

  # SERVE - open editors
  if [[ $* == *"-serve"* ]]; then
    # _gh__serve_all_gamehub
    cd $CODE_FOLDER_GH
    yarn start
  fi
}
_gh__qa_checkout_build_and_push() {
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

  # where should all of this end up on the console?
  CONSOLE_QA_GH_PATH=/data/rnps/gamehub-bun/

  # must send a branch name to us
  BRANCH=$1

  # use a little bash magic var
  START_TIME=$SECONDS

  echo
  echo
  echo_blue "➡️ GameHub : Checkout : Build : Push (starting)"
  echo
  echo_blue "  - - - - - - -"
  echo_blue "∙ Moving to GameHub root directory ..."
  echo
  cd $CODE_FOLDER_ROOT_GH

  # bail - not a git repo
  if [[ -z $BRANCH ]]; then
    echo_error "❌ You must send a branch name to checkout"
    return
  fi

  # bail - not a git repo
  if _git__isnot_git_tree; then
    echo "Current folder contains no git repo"
    return
  fi

  # bail - changes in this git tree
  if _git__has_changes; then
    echo_error "❌ There are unhandled changes in this git tree."
    echo "This command only works on a clean tree."
    return
  fi

  # checkout
  echo
  echo_blue "  - - - - - - -"
  echo_blue "∙ Checking out branch [${BRANCH}] ..."
  echo
  git checkout $BRANCH

  # validate we got the right one
  if [[ $BRANCH != $(_git__current_branch_name) ]]; then
    echo $BRANCH
    echo $(_git__current_branch_name)
    echo_error "❌ It seems like our checkout did not work"
    echo "Possible that you asked for a branch that does not exist?"
    return
  fi

  # pull
  echo
  echo_blue "  - - - - - - -"
  echo_blue "∙ git pull'ing ..."
  echo
  git pull

  # updating modules
  echo
  echo_blue "  - - - - - - -"
  echo_blue "∙ yarn updating ..."
  echo
  yarn

  # building
  echo
  echo_blue "  - - - - - - -"
  echo_blue "∙ building for ci ..."
  echo
  npm run ci:build

  echo
  echo_blue "  - - - - - - -"
  echo_blue "∙ pushing to console [${CONSOLE_QA_GH_PATH}] ..."
  echo
  p_cli upload --host-path=./bundles --target-path=${CONSOLE_QA_GH_PATH} --is-directory

  # moving manifest
  if _cmd__exists "p_man_qa"; then
    echo
    echo_blue "  - - - - - - -"
    echo_blue "∙ moving manifest to QA manifest ..."
    echo
    p_man_qa

    # look for errors
    if [[ $_ =~ RuntimeError ]]; then
      echo_error "❌ It looks like setting the manifest did not work"
      return
    fi

  else
    echo
    echo_yellow "  - - - - - - -"
    echo_yellow "∙ the $(p_man_qa) command was not found"
    echo_yellow "∙ make sure your manifest uses the local folder for gamehub"
  fi

  # COMPLETE : DURATION
  echo
  echo_green "  - - - - - - -"
  ELAPSED_TIME=$(($SECONDS - $START_TIME))
  echo_green "✅ All done! Completed in $(displaytime $ELAPSED_TIME)"
}
