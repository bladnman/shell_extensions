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
CODE_FOLDER_ROOT_RNPS_SETTINGS=~/code/p/rnps-settings
CODE_FOLDER_RNPS_SETTINGS=$CODE_FOLDER_ROOT_BGS

alias cdsettings="cd $CODE_FOLDER_ROOT_RNPS_SETTINGS"
alias sttg_man_dev='man_sttg_dev'
alias man_sttg_dev='_p_set_manifest_to_named "settings__dev"; ssay "Settings Dev manifest enabled, mon frayer"'
alias man_sttg_stage='_p_set_manifest_to_named "settings__stage"; ssay "Settings now pointed at stage location"'
alias stage_settings='_sttg__stage'

_sttg__stage() {
  cd $CODE_FOLDER_ROOT_RNPS_SETTINGS
  npm run ci:build
  p_cli upload --host-path /Users/bladnman/code/p/rnps-settings/bundles --target-path /data/rnps/settings-stage --is-directory
  man_sttg_stage
  _p_set_manifest_to_murl
}
_sttg__man_stage() {
  _p_set_manifest_to_named "settings__stage"
}
