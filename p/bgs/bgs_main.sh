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
SCRIPT_DIR_BGS=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")
SCRIPT_FULL_PATH_BGS="$SCRIPT_DIR_BGS/$(basename -- "$0")"

# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  VARS
# -=-=-=-=-=-=-=-=-=-=-=-=
CODE_FOLDER_ROOT_BGS=~/code/p/ppr-bgs
CODE_FOLDER_BGS=$CODE_FOLDER_ROOT_BGS

LOCAL_BUNDLE_ROOT=$CODE_FOLDER_ROOT_BGS/bundle
LOCAL_BUNDLE_PREFETCH=$LOCAL_BUNDLE_ROOT/prefetch
CONSOLE_BGS_ROOT=/system_ex/rnps/bgs/NPXS40052
CONSOLE_BGS_PREFETCH=$CONSOLE_BGS_ROOT/prefetch

# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  ALIASES
# -=-=-=-=-=-=-=-=-=-=-=-=
alias cdbgs='cd $CODE_FOLDER_BGS'
alias bgs_push_prefetch=_bgs_push_prefetch


# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  FUNCTIONS
# -=-=-=-=-=-=-=-=-=-=-=-=
_bgs_push_prefetch() {
  echo_blue "BGS: Pushing prefetch bundle files ..."
  prospero-cli $CONSOLE_IP upload --host-path=${LOCAL_BUNDLE_PREFETCH} --target-path=${CONSOLE_BGS_PREFETCH} --is-directory
  echo_green "BGS: Done"
}
