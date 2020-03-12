# -=-+-=-+-=-+-=-+
# -= ENV VARS
# -=-+-=-+-=-+-=-+
SCRIPT_DIR=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")
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
. $SHELL_EXT_FOLDER/env/git_main.sh

. $SHELL_EXT_FOLDER/aliases.sh
. $SHELL_EXT_FOLDER/aliases_code.sh
. $SHELL_EXT_FOLDER/searching.sh

# - - - -
# - PROJECTS
# - - - -
. $SHELL_EXT_FOLDER/project/democrotizer_main.sh
. $SHELL_EXT_FOLDER/project/portfolio_main.sh

# - - - -
# - PROGRAMS
# - - - -
. $SHELL_EXT_FOLDER/prog/iterm2.sh

# - - - -
# - P
# - - - -
. $SHELL_EXT_FOLDER/p/rnps_main.sh
. $SHELL_EXT_FOLDER/p/gh_main.sh


# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  BE HAPPY
# -=-=-=-=-=-=-=-=-=-=-=-=
. $SHELL_EXT_FOLDER/hello.sh
