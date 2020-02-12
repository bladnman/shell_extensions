SHELL_EXT_FOLDER='/Users/mmaher/shell_extensions'
export SHELL_EXT_FOLDER

# zsh
CUR_DIR=`dirname ${(%):-%x}`

#bash
# CUR_DIR=`dirname $BASH_SOURCE`
. $CUR_DIR/colors.sh


# . $CUR_DIR/environment.sh

# SHELL PROMPT - GIT style
# . $CUR_DIR/git-complete.sh
# . $CUR_DIR/git-flow-completion.sh
# . $CUR_DIR/bash_git_prompt.sh
# . $CUR_DIR/general_functions.sh

# ALIASES
. $CUR_DIR/aliases.sh
# . $CUR_DIR/aliases_destro.sh
. $CUR_DIR/aliases_baroness.sh
. $CUR_DIR/aliases_rnps.sh
# . $CUR_DIR/aliases_files_folders.sh
# . $CUR_DIR/aliases_qubedpeas.sh
# . $CUR_DIR/aliases_ember.sh
# . $CUR_DIR/aliases_node.sh
. $CUR_DIR/aliases_shell.sh
# . $CUR_DIR/aliases_vue_services.sh
# . $CUR_DIR/aliases_git.sh
. $CUR_DIR/aliases_portfolio.sh
. $CUR_DIR/aliases_code.sh
. $CUR_DIR/aliases_democrotizer.sh

# Be polite
. $CUR_DIR/hello.sh
