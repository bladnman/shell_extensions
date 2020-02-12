echo "You got me!"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "This script is in $DIR"
DIRNAME=$(readlink -f "$(dirname "$0")")
echo "DIRNAME = $DIRNAME"
# SIMPLE="$( dirname "$_" )"
SIMPLE="$( dirname "$0" )"
echo "SIMPLE = $SIMPLE"
echo "\$0 : $0"
SCRIPT="$(readlink --canonicalize-existing $0)"
echo "SCRIPT = $SCRIPT"
SCRIPT_HOME=`dirname $0 | while read a; do cd $a && pwd && break; done`
echo "SCRIPT_HOME : $SCRIPT_HOME"
SCRIPT_PATH=`$0 | while read a; do cd $a && pwd && break; done`
echo $SCRIPT_PATH
ZSH_DIR=`dirname ${(%):-%x}`
echo "ZSH_DIR : $ZSH_DIR"
echo "-----------"

SCRIPT_DIR=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")
SCRIPT_FULL_PATH="$SCRIPT_DIR/$(basename -- "$0")"
echo "WINNERS"
echo "SCRIPT_DIR : $SCRIPT_DIR"
echo "SCRIPT_FULL_PATH : $SCRIPT_FULL_PATH"
