CONSOLE_IP='172.31.1.2'
MACHINE_NAME='us38f9d32262b1'
SAMPLE_FOLDER=~/code/p/z_testapps
SAMPLE_APP_FOLDER=$SAMPLE_FOLDER/z_ppr_starter
MANIFEST_FOLDER=~/code/p/ppr-urlconfig-dev


alias p_cli='_p_cli'
alias p_con='p_cli get console | sed "/^$/d"'
alias p_man='_p_manifest_named gh'
alias p_man_named='_p_manifest_named'
alias p_create_sample='_p_create_sample'
alias p_serve_manifest='cd $MANIFEST_FOLDER;yarn start'
alias p_die='p_cli kill SceShellUI'
alias p_kill_shell='p_cli kill SceShellUI'

_p_cli() {
  prospero-cli $CONSOLE_IP $@
}
_p_manifest_named() {
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