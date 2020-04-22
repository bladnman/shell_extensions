CONSOLE_IP='10.125.43.243'
MACHINE_NAME='us38f9d32262b1'
CODE_FOLDER_P=~/code/p
SAMPLE_FOLDER=~$CODE_FOLDER_P/z_testapps
SAMPLE_APP_FOLDER=$SAMPLE_FOLDER/z_ppr_starter
MANIFEST_FOLDER=~/code/p/ppr-urlconfig-dev
SKYNET_CREDENTIAL=bladnman+e1@gmail.com:bob_is_happy
export SKYNET_CREDENTIAL=bladnman+e1@gmail.com:bob_is_happy

alias p_cli='prospero-cli $CONSOLE_IP'
alias p_con='_p_cli get console | sed "/^$/d"'
alias p_man='p_get_manifest'
alias p_man_dev='_p_manifest_named game-hub__dev; p_kill_shell; ssay "Manifest moved to dev, sir."'
alias p_man_gh='p_man_dev'
alias p_man_qa='_p_manifest_named game-hub__device-branch; p_kill_shell; ssay "Manifest moved to on-board branch, sir."'
alias p_man_mast='_p_manifest_named game-hub__device-mast; p_kill_shell; ssay "Manifest moved to on-board master, sir."'
alias p_man_clear='_p_manifest_named game-hub__clear; p_kill_shell; ssay "Now running with a clear manifest, sir."'
alias p_man_named='_p_manifest_named'
alias p_create_sample='_p_create_sample'
alias p_serve_manifest='cd $MANIFEST_FOLDER;yarn start'
alias p_kill_shell='_p_cli kill SceShellUI'
alias p_disco='_p_cli force-disconnect'
alias p_get_info="_p_info_formatted"
alias p_get_extended="_p_extended_info_formatted"
alias p_get_user='_p_user_formatted'
alias p_get_manifest='_p_manifest_formatted'
alias p_get_manifest_contents='_p_manifest_contents_formatted'
alias p_reboot='_p_cli reboot'
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

alias uip='_p_ip_update'

# VERY SHORT
alias pss='_p_screenshot'
alias pk='p_kill_shell; sh_say "Sir, your shell has been invigorated."'

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
  SS_PATH=$CODE_FOLDER_P/screenshots/$SS_NAME.png
  IMG_EDITOR="/Applications/Snagit 2020.app/Contents/MacOS/Snagit 2020"
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
  # prospero-cli $CONSOLE_IP $@
  prospero-cli-mac $CONSOLE_IP $@
}
_p_info_formatted() {
  _p_cli get info | sed -e "s/'/\"/g" | jq
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
  _p_cli get extended | awk '{printf "%s+",$0} END {print ""}' | sed -e "s/^.*{/{/" | sed -e "s/}.*$/}/" | sed -e "s/'/\"/g" | jq
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
  ifconfig | grep " 10\." | grep " --> " | cut -c 7-21
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
    echo
    echo_yellow "UPDATE IP AT:"
    echo "https://urlconfig.rancher.sie.sony.com/u/mmaher/game-hub__dev/edit"
    ssay "Nearly done sir"
    true
  else
    echo_yellow "Couldn't find the correct local IP"
    echo_red "You may not be on VPN"
    ssay "You may not be on VPN sir"
    false
  fi
}