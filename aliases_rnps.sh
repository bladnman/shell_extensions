CONSOLE_IP='172.31.1.2'
MACHINE_NAME='us38f9d32262b1'
CODE_FOLDER_P=~/code/p
SAMPLE_FOLDER=~$CODE_FOLDER_P/z_testapps
SAMPLE_APP_FOLDER=$SAMPLE_FOLDER/z_ppr_starter
MANIFEST_FOLDER=~/code/p/ppr-urlconfig-dev


alias p_cli='_p_cli'
alias p_con='p_cli get console | sed "/^$/d"'
alias p_man='p_cli set manifest-url mhttps://urlconfig.rancher.sie.sony.com/u/mmaher/game-hub'
alias p_man_named='_p_manifest_named'
alias p_man_local_named='_p_manifest_local_named'
alias p_create_sample='_p_create_sample'
alias p_serve_manifest='cd $MANIFEST_FOLDER;yarn start'
alias p_die='p_cli kill SceShellUI'
alias p_kill_shell='p_cli kill SceShellUI'
alias cd_p='cd $CODE_FOLDER_P'
alias p_ss='_p_screenshot'
alias p_screen='_p_screenshot'
alias p_snap='_p_screenshot'

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
  if [ -e $IMG_EDITOR ] 
  then 
    # & disown - returns control to shell and 
    # allows you to close it with it killing app 
    $IMG_EDITOR $SS_PATH & disown
  else 
    echo "------------"
    echo "    ${IMG_EDITOR}"
    echo "image editor not found"
    echo "------------"
    return 0
  fi
}
_p_cli() {
  prospero-cli $CONSOLE_IP $@
}
_p_manifest_named() {
  p_cli set manifest-url mhttps://urlconfig.rancher.sie.sony.com/u/mmaher/$1
}
_p_manifest_local_named() {
  p_cli set manifest-url mhttp://$CONSOLE_IP.am.sony.com:8080/u/mmaher/$1
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