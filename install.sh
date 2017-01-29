
CUR_DIR=`dirname $BASH_SOURCE`

# SHELL PROMPT - GIT style
. $CUR_DIR/git-complete.sh
. $CUR_DIR/git-flow-completion.sh
. $CUR_DIR/bash_git_prompt.sh
. $CUR_DIR/general_functions.sh

# ALIASES
. $CUR_DIR/aliases.sh
. $CUR_DIR/aliases_destro.sh
. $CUR_DIR/aliases_baroness.sh
. $CUR_DIR/aliases_files_folders.sh
. $CUR_DIR/aliases_qubedpeas.sh
. $CUR_DIR/aliases_ember.sh
. $CUR_DIR/aliases_node.sh

. $CUR_DIR/vue_services_development_profile.sh

# Be polite
echo "Hello sir. Let's have some fun!"
