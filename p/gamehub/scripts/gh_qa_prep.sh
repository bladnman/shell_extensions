TEST_E2E_FOLDER=$CODE_FOLDER_ROOT_GH/tests/e2e

# this script's directory
SCRIPT_DIR_GH_QA_PREP="$(cd "$(dirname $0)" && pwd)"

#
# activate the correct venv
# - i believe not needed in new world
# - only thing is `activate` is not being
# - run, so maybe I will reverse this decision
#
echo_blue "-> Activating Python venv"
pyenv activate gamehub-qa

echo_blue "-> Install GH QA Requirements.txt"
cd $TEST_E2E_FOLDER
pip install -r requirements.txt

echo
echo "You can now execute test cases like so:"
echo_green "   > tc 85"

#
# NO LONGER USED
#
# old pattern saved here
#
# this is the pattern to create a venv using
# current python version and activating it for this shell
# Since moving to venv management through pyenv
# this is no longer used for me. Keeping here in case we move
# away from this one day
#
source "$SCRIPT_DIR_GH_QA_PREP/gh_qa_activate_skynete.sh"
cd $TEST_E2E_FOLDER
pip install -r requirements.txt
#
