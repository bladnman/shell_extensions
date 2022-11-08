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
SCRIPT_DIR_P=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")
SCRIPT_FULL_PATH_P="$SCRIPT_DIR_P/$(basename -- "$0")"

##
# CONFIG VALUES
# CONSOLE_IP='mmaher-gh'
# CONSOLE_IP='10.125.43.243'
# CONSOLE_IP='10.125.47.220'
# CONSOLE_IP='10.125.53.245'
# CONSOLE_IP='10.32.254.234'
# CONSOLE_IP='10.32.254.229'
# CONSOLE_IP='10.58.23.20'
#CONSOLE_IP='10.58.2.204'
export CONSOLE_IP='10.58.202.6'
export MACHINE_NAME='bladn2022'
CODE_FOLDER_P=~/code/p
SAMPLE_FOLDER=~$CODE_FOLDER_P/z_testapps
SAMPLE_APP_FOLDER=$SAMPLE_FOLDER/z_ppr_starter
MANIFEST_FOLDER=~/code/p/ppr-urlconfig-dev
PCLI_COMMAND=prospero-cli
export DEVKIT_IP=$CONSOLE_IP
# PCLI_COMMAND=prospero-cli-mac
# export SKYNET_CREDENTIAL=bladnman+e1@gmail.com:bob_is_happy
export SKYNET_CREDENTIAL=bladnman+e1qa@gmail.com:bob_is_happy

alias p_cli='$PCLI_COMMAND $CONSOLE_IP'
alias p_con='_p_cli get console | sed "/^$/d"'
#alias p_con_shellui='p_con | grep --line-buffered "SceShellUI"' | sed 's/.*[\[SceShellUI\]]//'
alias p_con_shellui="p_con | awk '!/rnps-.*NPXS/' | awk '/SceShellUI/' | sed 's/M@/🐽/' | sed 's/.*[\[SceShellUI\]]//' "
alias p_con_jsconsole="_p_con_jsconsole "
alias p_con_m@="_p_con_jsconsole 🐽 M@ "
alias filter_logs="python ~/code/python/console_log_filter/filter_logs.py"

alias p_man='p_get_manifest'
alias p_man_dev='_p_manifest_named game-hub__dev; p_kill_shell; ssay "Manifest moved to dev, sir."'
alias p_man_dev_no_remote_debug='_p_manifest_named game-hub__dev_no_remote_debug; p_kill_shell; ssay "Manifest moved to dev no debug, my man."'
alias p_man_dev_bgs='_p_manifest_named game-hub__dev_bgs; p_kill_shell; ssay "Manifest moved to dev only bgs, no game hub development."; p_kill_jscd;'
alias p_man_dev_gh_and_bgs='_p_manifest_named game-hub__dev_with_bgs; p_kill_shell; ssay "Manifest moved to dev both game hub and bgs. Good luck, sir"'
alias p_man_gh='p_man_dev'
alias p_man_qa='_p_manifest_named game-hub__device-branch; p_kill_shell; ssay "Manifest moved to on-board branch, sir."'
alias p_man_qa_auto='_p_manifest_named game-hub-qa-automation; p_kill_shell; ssay "Manifest moved to qa automation, sir."'
alias p_man_mast='_p_manifest_named game-hub__device-mast; p_kill_shell; ssay "Manifest moved to on-board master, sir."'
alias p_man_clear='_p_manifest_named game-hub__clear; p_kill_shell; ssay "Now running with a clear manifest, sir."'
alias p_man_thb='_p_manifest_url "https://urlconfig.api.playstation.com/rnps/2.01.00.00/manifest"; p_kill_shell; ssay "Now running with a take-home beta manifest, sir."'
alias p_man_mem='_p_manifest_url "https://urlconfig.e1-np.api.playstation.com/rnps/u/lightning/urlconfig.json"; p_kill_shell; ssay "Now running with a memory profile manifest, sir."'
alias p_man_url='_p_manifest_url'

alias p_man_named='_p_manifest_named'
alias p_create_sample='_p_create_sample'
alias p_serve_manifest='cd $MANIFEST_FOLDER;yarn start'
alias p_kill_shell='echo_blue "Killing Shell"; p_kill_jscd; _p_cli kill SceShellUI'
alias p_kill_jscd='echo_blue "Killing Shell"; _p_cli kill SceJSCd'
alias p_kill_shell_disco='p_disco; p_kill_shell'
alias p_id='_p_set_test_ids'
alias p_kd='p_kill_shell_disco'
alias p_disco='echo_blue "Disconnecting any user"; _p_cli force-disconnect'
alias p_get_info="_p_info_formatted"
alias p_get_extended="_p_extended_info_formatted"
alias p_get_user='_p_user_formatted'
alias p_get_manifest='_p_manifest_formatted'
alias p_get_manifest_contents='_p_manifest_contents_formatted'
alias p_reboot='_p_cli reboot'
alias p_poweroff='_p_cli poweroff'
alias p_poweron='_p_cli poweron'
alias cd_p='cd $CODE_FOLDER_P'
alias p_ss='_p_screenshot'

alias p_screen='_p_screenshot'
alias p_snap='_p_screenshot'
alias p_repo='_p_find_repo'
alias find_repo='_p_find_repo'
alias p_ip_local='_p_get_local_ip'
alias p_ip_remote='echo ${CONSOLE_IP}'
alias p_ip_list='_p_ip_list'
alias p_ip='p_ip_list'
alias p_resize_snaps='_p_resize_snaps_by_50'
alias p_pkg_install='_p_pkg_install'
alias p_pup_install='_p_pup_install'
alias p_pup_latest='_p_pup_latest'
alias p_dl_bgs='_p_dl_bgs'
alias dl_bgs='_p_dl_bgs'
alias p_dl_appdb='_p_dl_appdb'
alias dl_appdb='_p_dl_appdb'

# SETTINGS
alias p_set_voice_on='_p_setting_set "/Accessibility/Screen Reader/Enable Screen Reader" 1'
alias p_set_voice_off='_p_setting_set "/Accessibility/Screen Reader/Enable Screen Reader" 0'
alias p_font_size_small='_p_font_size -1'
alias p_font_size_normal='_p_font_size 0'
alias p_font_size_large='_p_font_size 1'
alias p_font_size_extra_large='_p_font_size 2'
alias p_font_bold_toggle='_p_font_bold'
alias p_font_bold_on='_p_font_bold 1'
alias p_font_bold_off='_p_font_bold 0'
alias p_online='_p_setting_set "/Network/Internet Connection" 1'
alias p_offline='_p_setting_set "/Network/Internet Connection" 0'
alias p_env_e1='_p_set_env e1-np'
alias p_env_np='_p_set_env np'
alias p_env_prod='_p_set_env np'
alias p_env_mgmt='_p_set_env mgmt'
alias env_e1='_p_set_env e1-np'
alias env_np='_p_set_env np'
alias env_prod='_p_set_env np'
alias env_mgmt='_p_set_env mgmt'
alias p_dev='p_env_e1'
alias p_mgmt='p_env_mgmt'
alias p_prod='p_env_np'
alias dev='p_env_e1'
alias e1='p_env_e1'
alias prod='p_env_np'

# VERY SHORT
alias uip='_p_ip_update'

alias pss='_p_screenshot'
alias prb='p_reboot'

alias pk='p_kill_shell; sh_say "Sir, your shell has been invigorated."'
alias ppk='pk'
alias pkk='pk'
alias pdi='pk'

alias ppup='p_pup_latest'
alias p_pup='p_pup_latest'
alias pup='p_pup_latest'

_p_resize_snaps_by_50() {
  P_SS_PATH=~/Pictures/SCE/Prospero
  cd $P_SS_PATH
  for sourceFileName in *.png; do
    destFileName="resized/resz_$sourceFileName"
    if [ ! -f $destFileName ]; then
      echo_yellow "resizing: $sourceFileName"
      convert $sourceFileName -resize 50% $destFileName
    fi
  done
  echo_green "done resizing screenshots"
}
_p_screenshot() {
  SS_NAME=$(date -u +'%Y-%m-%d_%H%M%S')
#  SS_PATH=$CODE_FOLDER_P/screenshots/$SS_NAME.png
  SS_PATH=~/Documents/graphics/screenshots/p/$SS_NAME.png
  # IMG_EDITOR="/Applications/Snagit 2020.app/Contents/MacOS/Snagit 2020"
  IMG_EDITOR="/Applications/Snagit 2022.app/Contents/MacOS/Snagit 2022"
  # IMG_EDITOR="/Applications/Setapp/CleanShot X.app/Contents/MacOS/CleanShot X Setapp"
  echo "starting snapshot process:"
  echo "    ${SS_PATH}"

  ## CAPTURE
  p_cli get screenshot --file ${SS_PATH}
  if [ ! -f $SS_PATH ]; then
    echo "error in fetching screenshot"
    return 0
  fi

  ## RESIZE
  echo "resizing snapshot"
  magick convert ${SS_PATH} -resize 50% ${SS_PATH}
  if [ ! -f $SS_PATH ]; then
    echo "error in resizing screenshot"
    return 0
  fi

  ## OPEN EDITOR
  if [ -e $IMG_EDITOR ]; then
    # & disown - returns control to shell and
    # allows you to close it with it killing app
    $IMG_EDITOR $SS_PATH &
    disown
  else
    echo "------------"
    echo "    ${IMG_EDITOR}"
    echo "image editor not found"
    echo "------------"
    return 0
  fi
}
_p_cli() {
  $PCLI_COMMAND $CONSOLE_IP $@
}

_p_con_jsconsole() {
  _cmd="p_con_shellui | sed 's/.*JSConsole\ \://'"
  _extra=""

  for value in "$@"
  do
    if [ "$_extra" ]; then
      _extra="$_extra || /$value/"
    else
      _extra="/$value/"
    fi
  done

  if [ "$_extra" ]; then
    echo "$_cmd | awk '$_extra'"
    eval "$_cmd | awk '$_extra'"
  else
    echo "$_cmd"
    eval "$__cmd"
  fi

}
_p_info_formatted() {
  _p_cli get info | sed -e "s/'/\"/g" | jq
  # {'CpVersion': '0x1080505', 'CpRevision': 9793, 'TargetUniqueID': '78-c8-81-78-2f-5f', 'DEVSubnetMask': '255.255.255.240', 'SdkVersion': 67108864, 'HwAttributes': '0x20', 'DevkitType': 'DevKit', 'DevkitName': '', 'ExpiryTime': 31536000, 'TscFrequency': '0x5f259b84', 'CurrentOwner': ''}
}
_p_manifest_formatted() {
  echo "asking for manifest url..."
  _p_cli get manifest-url | sed -e "s/.*= //g"
}
_p_manifest_contents_formatted() {
  echo "asking for manifest url..."
  FULL_MAN_URL=$(_p_cli get manifest-url | sed -e "s/.*= //g")
  MAN_URL=$(echo $FULL_MAN_URL | sed -e "s/mhttp/http/")
  curl $MAN_URL | jq

  echo
  echo "From"
  echo_yellow $FULL_MAN_URL
}
_p_user_formatted() {
  # this is sweet shell magic
  _p_cli get current-user | awk '{printf "%s+",$0} END {print ""}' | sed -e "s/^.*{/{/" | sed -e "s/}.*$/}/" | sed -e "s/'/\"/g" | jq
}
_p_extended_info_formatted() {
  # this is sweet shell magic
  # _p_cli get extended | awk '{printf "%s+",$0} END {print ""}' | sed -e "s/^.*{/{/" | sed -e "s/}.*$/}/" | sed -e "s/'/\"/g" | jq

  _p_cli get extended | sed -e "s/Devi.* is {/{/" | sed -e "s/^.*{/{/" | sed -e "s/}.*$/}/" | sed -e "s/'/\"/g" | jq
}
_p_manifest_url() {
  prospero-cli $CONSOLE_IP set manifest-url $1
}
_p_manifest_named() {
  prospero-cli $CONSOLE_IP set manifest-url mhttps://urlconfig.rancher.sie.sony.com/u/mmaher/$1
}
_p_create_sample() {
  APP_NAME=$1
  FINAL_APP_DIRECTORY="$SAMPLE_FOLDER/$APP_NAME"
  echo
  # echo 'You asked to create a new sample app named: ' $APP_NAME
  if [ ! -d "$SAMPLE_FOLDER" ]; then
    echo "error: Sample folder does not exist"
    echo "    $SAMPLE_FOLDER"
    echo "This is where all samples live, including the sample app template."
    return 0
  fi
  if [ ! -d "$SAMPLE_APP_FOLDER" ]; then
    echo "error: Sample app folder does not exist"
    echo "    $SAMPLE_APP_FOLDER"
    echo "This is the sample app template and is needed to create a new app."
    return 0
  fi
  if [ -d "$FINAL_APP_DIRECTORY" ]; then
    echo "error: APP NAME IS ALREADY IN USE. Choose another"
    echo "    $FINAL_APP_DIRECTORY     <- already exists"
    return 0
  fi

  echo 'creating your new sample app...'
  cd $SAMPLE_FOLDER
  cp -r $SAMPLE_APP_FOLDER $APP_NAME
  cd $APP_NAME
  git init
  echo
  echo 'Welcome to your new sample application'
}
_p_find_repo() {
  REPO_NAME=$1
  REPO_URL=$(_find_repo $REPO_NAME)

  if [ -z "$REPO_URL" ]; then
    # empty? some mondo repo items can't be found this way
    # let's offer a direct search url for them
    REPO_ENCODED=$(echo $REPO_NAME | sed -e "s/@/%2A/g" | sed -e "s/\//%2F/g")
    SEARCH_URL="https://github.sie.sony.com/search?q=language%3A%22json%22+name$REPO_ENCODED&type=Code"
    echo $SEARCH_URL
  else
    echo $REPO_URL
  fi
}
_find_repo() {
  REPO_NAME=$1
  REPO_GIT_URI=$(npm view $REPO_NAME repository.url)
  REPO_URL=$REPO_GIT_URI
  # some are urls and some are uris
  if [[ $REPO_GIT_URI =~ [@] ]]; then
    REPO_URL=$(echo $REPO_GIT_URI | sed -e "s/:/\//" | sed -e "s/.*@/http:\/\//")
  elif [[ $REPO_GIT_URI =~ [git+http] ]]; then
    REPO_URL=$(echo $REPO_GIT_URI | sed -e "s/git\+//")
  elif [[ $REPO_GIT_URI =~ [git:] ]]; then
    REPO_URL=$(echo $REPO_GIT_URI | sed -e "s/git:/http:/")
  fi

  echo $REPO_URL
}
_p_get_local_ip() {
  ifconfig | grep " 10\." | grep " --> " | cut -c 7-21 | sed 's/[^0-9.]*//g'
}
_p_ip_list() {
  echo_yellow "CONSOLE IP:"
  echo $CONSOLE_IP
  echo_yellow "LOCAL IP:"
  _p_get_local_ip
}
_p_ip_update() {

  # check if on VPN yet
  if _p_get_local_ip | grep -q 10; then
    echo "VPN Found"
    _p_ip_list
    # get local IP on clipboard
    _p_get_local_ip | pbcopy
    echo
    echo_yellow "UPDATE IP AT:"
    echo "https://urlconfig.rancher.sie.sony.com/u/mmaher/game-hub__dev/edit"
    # open the browser
    open "https://urlconfig.rancher.sie.sony.com/u/mmaher/game-hub__dev/edit"
    ssay "Awaiting command sir"
    echo

    # read -p 'Should I KILL SHELL? y/n' answer
    # zsh specific read parameters
    # http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html
    read -q "?Should I KILL SHELL y/[n]? " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
      echo
      ssay "On it sir"
      p_kill_shell
    fi

    true
  else
    echo_yellow "Couldn't find the correct local IP"
    echo_red "You may not be on VPN"
    ssay "You may not be on VPN sir"
    false
  fi
}
testIt() {
  # zsh specific read parameters
  # http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html
  read -q "?Should I KILL SHELL y/[n]? " answer
  if [[ "$answer" =~ ^[Yy]$ ]]; then
    echo
    ssay "On it sir"
    p_kill_shell
  fi
}
_p_pkg_install() {
  _p_cli install package $@
}
_p_pup_install() {
  _p_cli update --pup-file $@
}
_p_pup_latest() {
  . ${SCRIPT_DIR_P}/scripts/p_install_pup.sh
}
_p_set_test_ids() {

  # this does not quite work yet...
  _p_cli execute shellui "utcmd testinfo set --devkit_ip $CONSOLE_IP --test_case_id ${1} --test_session_id ${1} --test_type ${1}"
}
_get_scp_hex_from_conceptid() {
  # call pattern:
  # MY_HEX=$(_get_scp_hex_from_conceptid $MY_DEC)
  local FINAL_LEN=16
  local NUM=$1
  local HX=$(printf '%x\n' ${NUM})
  local PAD_NUM=$(expr ${FINAL_LEN} - ${#HX})
  local PRE=$(printf "%0${PAD_NUM}d")
  local PAD="${PRE}${HX}"
  echo $PAD
}
# Set accessibility text size.
# Example Usage:
#   normal: `_p_font_size 0`
#   large: `_p_font_size 1`
#   very large: `_p_font_size 2`
_p_font_size() {
  _p_setting_set "/Accessibility/Display/Text Size" $1
}
# Get Devkit Setting
_p_setting_get() {
  p_cli get setting $*
}

# Set Devkit Setting
_p_setting_set() {
  p_cli set setting $*
}
# Set accessibility font boldness (toggles if no input)
# example usage:
#   toggle: `_p_font_bold`
#   on: `_p_font_bold 1`
#   off: `_p_font_bold 0`
_p_font_bold() {
  BOLD=$(_p_setting_get "/Accessibility/Display/Bold Text")
  IS_ACTIVE="/Accessibility/Display/Bold Text = 1"

  if [ -z $1 ]; then
    if [ "$BOLD" = "$IS_ACTIVE" ]; then
      echo "turning bold off"
      _p_setting_set "/Accessibility/Display/Bold Text" 0
    else
      echo "turning bold on"
      _p_setting_set "/Accessibility/Display/Bold Text" 1
    fi
  else
    echo "setting bold to $1"
    _p_setting_set "/Accessibility/Display/Bold Text" $1
  fi
}

## GET ALL SETTINGS
#   _p_setting_get "/★ Debug Settings" > settings.txt

# Switch np environment
# example usage:
#    `_p_set_env np`
#    `_p_set_env e1-np`
#    `_p_set_env mgmt`
_p_set_env() {
  _p_setting_set "/★ Debug Settings/PlayStation Network/NP Environment" $1
  p_reboot
}
_p_dl_bgs() {
  # user may send in userid to use
  userid_arg=$1

  # get the active userid
  # but only do this if userid_arg is not provided
  if [ -z "$userid_arg" ]; then
    echo_yellow "No userid specified, looking for active userid"
    userid_active=$(_p_get_user_id)
  fi

  # we also will define a default userid
  userid_default="1695674e"

  # coalesce the userid
  userid="${userid_arg:-${userid_active:-${userid_default}}}"

  # we need to make sure to remove the "0x" from the userid
  userid=$(echo ${userid/0x/})

  date_stamp=$(date '+%Y-%m-%d_%H-%M-%S')
  remotePath="/system_data/priv/home/${userid}/nobackup/bgs_storage/bgs_storage_sqlite.db"
  localPath="/Users/bladnman/Downloads/${date_stamp}__bgs_storage_sqlite.db"
  p_cli download --target_path $remotePath --host_path $localPath
  echo_green "👍 Check your Downloads folder"
  echo_yellow "     ${localPath}"
}
_p_dl_appdb() {
  date_stamp=$(date '+%Y-%m-%d_%H-%M-%S')
  remotePath="/system_data/priv/mms/app.db"
  localPath="/Users/bladnman/Downloads/${date_stamp}__app.db"
  p_cli download --target_path $remotePath --host_path $localPath
  echo_green "👍 Check your Downloads folder"
  echo_yellow "     ${localPath}"
}
_p_get_user_id() {
  user_info_json=$(p_get_user)
  # echo_blue "user_info_json: $user_info_json"
  userid=$(echo ${user_info_json} | jq --raw-output '.UserID')
  echo $userid
}
