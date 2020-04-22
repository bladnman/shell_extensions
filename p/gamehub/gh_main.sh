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
alias gh_verify='_gh_verify_flow && _gh_verify_lint && _gh_verify_tests && ssay "Smashing job. Everything looks good sir."'
alias gh_lint='_gh_verify_lint && ssay "Looks correct sir"'
alias gh_flow='_gh_verify_flow && ssay "Your flow looks proper sir"'
alias gh_tests='_gh_verify_tests && ssay "Perfect marks sir"'

alias gh_qa_tc='pytest --udid=$CONSOLE_IP -m '
alias gh_qa_prep='_gh__qa_prepare; snotif'
alias gh_stage_branch='_gh__do_stage_branch'
alias gh_stage_master='_gh__do_stage_master'

alias gh_man_master='_gh__switch_manifest game-hub__device-mast "Now using on board master manifest, sir"'
alias gh_man_branch='_gh__switch_manifest game-hub__device-branch "Now using on board branch manifest, sir"'
alias gh_man_dev='_gh__switch_manifest "game-hub__dev" "Dev manifest enabled, sir"'
alias gh_man_clear='_gh__switch_manifest game-hub__clear "Clear manifest installed, sir"'

# short-short-handers
alias stage_branch='gh_stage_branch'
alias stage_master='gh_stage_master'
alias stb='gh_stage_branch'
alias stm='gh_stage_master'
alias smoke='_gh__run_e2e_smoke; snotif'
alias tc='_gh__run_e2e_tc; snotif'
alias ts='_gh__qa_run_test_suite_named; snotif'
alias ghs='gh_serve'
alias ghl='gh_link'
alias ghv='gh_verify'
alias man_master='gh_man_master'
alias man_branch='gh_man_branch'
alias man_dev='gh_man_dev'
alias man_clear='gh_man_clear'
alias mnm='gh_man_master'
alias mnb='gh_man_branch'
alias mnd='gh_man_dev'
alias mnc='gh_man_clear'

# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  FUNCTIONS
# -=-=-=-=-=-=-=-=-=-=-=-=
_gh_verify_flow() {
  cd $CODE_FOLDER_GH

  # FLOW CHECK
  echo_blue "Checking Flow ..."
  yarn run flow
  RESULT=$?
  if [ $RESULT -ne 0 ]; then
    echo_red "Problem with Flow"
    ssay "There seems to be a Flow problem sir."
    false
  else
    true
  fi
}
_gh_verify_lint() {
  cd $CODE_FOLDER_GH

  # FLOW CHECK
  echo_blue "Checking Lint ..."
  yarn lint
  RESULT=$?
  if [ $RESULT -ne 0 ]; then
    echo_red "Problem with Lint"
    ssay "I believe I see some lint sir."
    false
  else
    true
  fi
}
_gh_verify_tests() {
  cd $CODE_FOLDER_GH

  # FLOW CHECK
  echo_blue "Checking Unit Tests ..."
  yarn test
  RESULT=$?
  if [ $RESULT -ne 0 ]; then
    echo_red "Problem with Unit Tests"
    ssay "Sir, I think we have a unit test failing around here somewhere."
    false
  else
    true
  fi
}
_gh__do_stage_branch() {
  . ${SCRIPT_DIR_GH}/scripts/gh_qa_stage_branch.sh -b=$1 -s=$CODE_FOLDER_ROOT_GH -i=$CONSOLE_IP -d=/data/rnps/gamehub-branch/ -m=mhttps://urlconfig.rancher.sie.sony.com/u/mmaher/game-hub__device-branch
  sh_say "Sir, your branch has been staged."
}
_gh__do_stage_master() {
  . ${SCRIPT_DIR_GH}/scripts/gh_qa_stage_branch.sh -b=master -s=$CODE_FOLDER_ROOT_GH -i=$CONSOLE_IP -d=/data/rnps/gamehub-mast/ -m=mhttps://urlconfig.rancher.sie.sony.com/u/mmaher/game-hub__device-mast
  sh_say "Sir, master has been staged."
}
_gh__switch_manifest() {
  MANIFEST_NAME=$1
  SUCCESS_MESSAGE=$2

  _p_manifest_named $MANIFEST_NAME
  RESULT=$?
  if [ $RESULT -eq 0 ]; then
    p_kill_shell
    if [ -z "$SUCCESS_MESSAGE" ]; then
      ssay "Sir, your manifest was switched."
    else
      ssay $SUCCESS_MESSAGE
    fi
  else
    snotif
  fi
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
