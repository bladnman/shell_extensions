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
alias gh_qa_prep='_gh__qa_prepare'
alias gh_qa_build_push='_gh__build_and_push_for_qa'
alias gh_qa_checkout_build_and_push='_gh__qa_checkout_build_and_push'

# short-short-handers
alias smoke='_gh__run_e2e_smoke'
alias tc='_gh__run_e2e_tc'
alias ghs='gh_serve'
alias ghl='gh_link'

# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  FUNCTIONS
# -=-=-=-=-=-=-=-=-=-=-=-=
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
_gh__build_and_push_for_qa() {

  echo
  echo
  echo "+-----------------"
  echo "Moving into GameHub root folder, updating and building..."
  cd $CODE_FOLDER_ROOT_GH

  echo
  echo
  echo "+-----------------"
  echo "Updating..."
  yarn

  echo
  echo
  echo "+-----------------"
  echo "Building (please wait)..."
  npm run ci:build

  echo
  echo
  echo "+-----------------"
  echo "Pushing to console (please wait)..."
  p_cli upload --host-path=./bundles --target-path=/data/rnps/gamehub-bun/ --is-directory
  echo
  echo
  echo "+-----------------"
  echo "Done. Published to /data/rnps/gamehub-bun/"
}
_gh__run_e2e_tc() {
  PARAM=$1
  LOWER_PARAM=`printf '%s\n' "$PARAM" | awk '{ print tolower($0) }'`

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
  elif [[ $1 =~ [a-zA-Z] ]] ; then
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
  echo "Getting you ready for QA"

  echo "1. Create Virtual Environment"
  cd $SKYNETE_CHECKOUT_FOLDER
  python3 -m venv Skynete
  source ./Skynete/bin/activate
  
  echo "2. Install GH QA Dependancies (longer)"
  cd $TEST_E2E_FOLDER
  pip install -r requirements.txt

  clear
  echo
  echo
  echo "Done."
  echo "You can now execute test cases against your devkit. Example"
  echo "   > gh_qa_tc tc85"
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

  # must send a branch name to us
  BRANCH=$1

  # use a little bash magic var
  START_TIME=$SECONDS

  echo
  echo 
  echo "➡️ GameHub : Checkout : Build : Push (starting)"

  cd $CODE_FOLDER_ROOT_GH

  # bail - not a git repo
  if [[ -z $BRANCH ]] ; then
    echo_error "❌ You must send a branch name to checkout"
    return
  fi

  # bail - not a git repo
  if _git__isnot_git_tree ; then
    echo "Current folder contains no git repo"
    return
  fi

  # bail - changes in this git tree
  if _git__has_changes ; then
    echo_error "❌ There are unhandled changes in this git tree."
    echo "This command only works on a clean tree."
    return
  fi

  echo_green "✅ Looks like we will be moving on!"
  ELAPSED_TIME=$(($SECONDS - $START_TIME))
  
    
  
  




  
  # COMPLETE : DURATION
  echo_green "⬅️ Completed in $(displaytime $ELAPSED_TIME)"
}
