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
SKYNETE_CHECKOUT_FOLDER=~/code/p/SkyNete

# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  ALIASES
# -=-=-=-=-=-=-=-=-=-=-=-=
alias cdgh='cd $CODE_FOLDER_GH'
alias cd_gh='cd $CODE_FOLDER_GH'
alias gh_dev='bash $SCRIPT_FULL_PATH_GH -dev -serve'
alias gh_code='bash $SCRIPT_FULL_PATH_GH -dev'
alias gh_serve='bash $SCRIPT_FULL_PATH_GH -serve'
alias gh_link_concept='_link_concept_gamehub'
alias gh_link_product='_link_product_gamehub'
alias gh_link_title='_link_title_gamehub'
alias gh_link='_link_any_gamehub'
alias gh_tc='pytest --udid=$CONSOLE_IP -m '
alias gh_qa_tc='pytest --udid=$CONSOLE_IP -m '
alias gh_qa_prep='_qa_prepare'

# short-short-handers
alias ghs='gh_serve'
alias ghl='gh_link'

# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  FUNCTIONS
# -=-=-=-=-=-=-=-=-=-=-=-=
_link_concept_gamehub() {
  echo p_cli execute shellui "openuri psgamehub:main?conceptId=$@"
  p_cli execute shellui "openuri psgamehub:main?conceptId=$@"
}
_link_product_gamehub() {
  echo p_cli execute shellui "openuri psgamehub:main?productId=$@"
  p_cli execute shellui "openuri psgamehub:main?productId=$@"
}
_link_title_gamehub() {
  echo p_cli execute shellui "openuri psgamehub:main?titleId=$@"
  p_cli execute shellui "openuri psgamehub:main?titleId=$@"
}
_link_any_gamehub() {
  ID=$1
  if [[ $1 == '' ]]; then
    echo "https://github.sie.sony.com/SIE-Private/rnps-game-hub/blob/master/packages/gamehub-deeplink-example/src/application/items.js"
  elif [[ $1 =~ [\-] ]]; then
    _link_product_gamehub $1
  elif [[ $1 =~ [a-zA-Z] ]] ; then
    _link_title_gamehub $1
  else 
    _link_concept_gamehub $1
  fi
}
_serve_manifest_gamehub() {
  cd $MANIFEST_FOLDER_GH
  yarn start &
  sleep 1
}
_serve_app_gamehub() {
  cd $CODE_FOLDER_GH
  yarn start &
  sleep 1
}
_open_editors_gamehub() {
  echo "Attempting to open editor to GAMEHUB"
  code $CODE_FOLDER_GH
}
_serve_all_gamehub() {
  echo "Starting App server"
  trap "exit" INT TERM ERR
  trap "kill 0" EXIT
  _serve_manifest_gamehub
  _serve_app_gamehub
  echo "server running ..."
  wait
}
_qa_prepare() {
  echo "Getting you ready for QA"
  
  echo "1. Create Virtual Environment"
  cd $SKYNETE_CHECKOUT_FOLDER
  python3 -m venv Skynete
  source ./Skynete/bin/activate
  
  echo "2. Install GH QA Dependancies (longer)"
  cd $CODE_FOLDER_ROOT_GH/tests/e2e
  pip install -r requirements.txt

  echo
  echo
  echo "Done."
  echo "You can now execute test cases against your devkit. Example"
  echo "   > gh_qa_tc tc85"
  echo
}


# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  MAIN
# -=-=-=-=-=-=-=-=-=-=-=-=
# DEV - open editors
if [[ $* == *"-dev"* ]]; then
  _open_editors_gamehub
fi

# SERVE - open editors
if [[ $* == *"-serve"* ]]; then
  # _serve_all_gamehub
  cd $CODE_FOLDER_GH
  yarn start
fi
