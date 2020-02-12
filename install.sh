# -=-+-=-+-=-+-=-+
# -= ENV VARS
# -=-+-=-+-=-+-=-+
SCRIPT_DIR=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")
SCRIPT_FULL_PATH="$SCRIPT_DIR/$(basename -- "$0")"

# export it for others if they want it
SHELL_EXT_FOLDER=$SCRIPT_DIR
export SHELL_EXT_FOLDER

# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  ENVIRONMENT
# -=-=-=-=-=-=-=-=-=-=-=-=
. $SHELL_EXT_FOLDER/colors.sh
# . $SHELL_EXT_FOLDER/environment.sh

# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  ALIASES
# -=-=-=-=-=-=-=-=-=-=-=-=
. $SHELL_EXT_FOLDER/aliases.sh
. $SHELL_EXT_FOLDER/aliases_rnps.sh
. $SHELL_EXT_FOLDER/aliases_shell.sh
. $SHELL_EXT_FOLDER/aliases_code.sh
. $SHELL_EXT_FOLDER/aliases_democrotizer.sh

# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  PROJECTS
# -=-=-=-=-=-=-=-=-=-=-=-=
. $SHELL_EXT_FOLDER/project_portfolio.sh
. $SHELL_EXT_FOLDER/project_gamehub.sh

# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  BE HAPPY
# -=-=-=-=-=-=-=-=-=-=-=-=
. $SHELL_EXT_FOLDER/hello.sh
