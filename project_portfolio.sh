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
SCRIPT_DIR_PORTFOLIO=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")
SCRIPT_FULL_PATH_PORTFOLIO="$SCRIPT_DIR_PORTFOLIO/$(basename -- "$0")"


# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  VARS
# -=-=-=-=-=-=-=-=-=-=-=-=
CODE_FOLDER_PORTFOLIO=~/code/portfolio
PUBLISHER_FOLDER_PORTFOLIO=$CODE_FOLDER_PORTFOLIO/portfolio-publisher
VIEWER_FOLDER_PORTFOLIO=$CODE_FOLDER_PORTFOLIO/portfolio-viewer


# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  ALIASES
# -=-=-=-=-=-=-=-=-=-=-=-=
alias cdportfolio='cd $CODE_FOLDER_PORTFOLIO'
alias portfolio_dev='bash $SCRIPT_FULL_PATH_PORTFOLIO -dev -serve'
alias portfolio_code='bash $SCRIPT_FULL_PATH_PORTFOLIO -dev'
alias portfolio_serve='bash $SCRIPT_FULL_PATH_PORTFOLIO -serve'


# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  FUNCTIONS
# -=-=-=-=-=-=-=-=-=-=-=-=
_serve_publisher_portfolio() {
  cd $PUBLISHER_FOLDER_PORTFOLIO
  npm start &
  sleep 1
}
_serve_viewer_portfolio() {
  cd $VIEWER_FOLDER_PORTFOLIO
  npm start &
  sleep 1
}
_open_editors_portfolio() {
  echo "Attempting to open editors"
  code $PUBLISHER_FOLDER_PORTFOLIO
  sleep 1 # without this, VSC opens both in 1 window as a workspace ... interesting
  code $VIEWER_FOLDER_PORTFOLIO
}
_serve_all_portfolio() {
  echo "Starting Portfolio servers"
  trap "exit" INT TERM ERR
  trap "kill 0" EXIT

  _serve_publisher_portfolio
  sleep 1
  _serve_viewer_portfolio

  echo "Browsers should auto-launch to the following:"
  echo "      Viewer : http://localhost:3000/#/"
  echo "   Publisher : http://localhost:3001/#/"
  echo "-------------"
  echo "Portfolio servers on their way ..."

  wait
}


# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  MAIN
# -=-=-=-=-=-=-=-=-=-=-=-=
# DEV - open editors
if [[ $* == *"-dev"* ]]; then
  _open_editors_portfolio
fi

# SERVE - open editors
if [[ $* == *"-serve"* ]]; then
  _serve_all_portfolio
fi
