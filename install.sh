# -=-+-=-+-=-+-=-+
# -= ENV VARS
# -=-+-=-+-=-+-=-+
SCRIPT_DIR=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")

# try to get to our shell_extensions folder if possible
if [[ $SCRIPT_DIR != *"shell_extensions"* ]]; then
  if [[ -d "/Users/mmaher/shell_extensions" ]]; then
    SCRIPT_DIR="/Users/mmaher/shell_extensions"
  elif [[ -d "/Users/bladnman/shell_extensions" ]]; then
    SCRIPT_DIR="/Users/bladnman/shell_extensions"
  fi
fi

SCRIPT_FULL_PATH="$SCRIPT_DIR/$(basename -- "$0")"

# export it for others if they want it
SHELL_EXT_FOLDER=$SCRIPT_DIR
export SHELL_EXT_FOLDER

# - - - -
# - ENVIRONMENT
# - - - -
. $SHELL_EXT_FOLDER/env/colors.sh
. $SHELL_EXT_FOLDER/env/color_echo.sh
. $SHELL_EXT_FOLDER/env/shell_aliases.sh
. $SHELL_EXT_FOLDER/git/git_main.sh

. $SHELL_EXT_FOLDER/aliases.sh
. $SHELL_EXT_FOLDER/aliases_code.sh
. $SHELL_EXT_FOLDER/aliases_scripts.sh
. $SHELL_EXT_FOLDER/searching.sh
source $SHELL_EXT_FOLDER/python/python.sh

# - - - -
# - PROJECTS
# - - - -
. $SHELL_EXT_FOLDER/project/democrotizer_main.sh
. $SHELL_EXT_FOLDER/project/portfolio_main.sh
. $SHELL_EXT_FOLDER/project/python_spark.sh

# - - - -
# - PROGRAMS
# - - - -
. $SHELL_EXT_FOLDER/prog/iterm2.sh

# - - - -
# - P
# - - - -
. $SHELL_EXT_FOLDER/p/rnps_main.sh
. $SHELL_EXT_FOLDER/p/gamehub/gh_main.sh
. $SHELL_EXT_FOLDER/p/bgs/bgs_main.sh

# . $SHELL_EXT_FOLDER/wallpaper/wallpaper.sh

# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  SHELL SCRIPTS
# -=-=-=-=-=-=-=-=-=-=-=-=
. $SHELL_EXT_FOLDER/project/shell_scripts.sh

# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  BE HAPPY
# -=-=-=-=-=-=-=-=-=-=-=-=
. $SHELL_EXT_FOLDER/hello.sh

alias source_shell_extensions='source $SHELL_EXT_FOLDER/install.sh'
