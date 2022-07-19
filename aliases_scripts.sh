# -=-+-=-+-=-+-=-+
# -= ENV VARS
# -=-+-=-+-=-+-=-+
SCRIPT_DIR_BASE=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")

alias find_app_using_secure_input='python $SCRIPT_DIR_BASE/scripts/find_app_using_secure_input.py'
