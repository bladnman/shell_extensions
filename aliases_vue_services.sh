# E X P O R T S
export BARONESS_PATH='/Users/mmaher/Documents/sony/code/baroness-vs-dev'
export VUE_SERVICES_PATH='/Users/mmaher/Documents/sony/code/vue-services'
export VUE_EMBER_SERVICES_PATH='/Users/mmaher/Documents/sony/code/vue-ember-services'

export VUE_SERVICES_PKG_NAME='snei-vue-services'
export VUE_EMBER_SERVICES_PKG_NAME='snei-vue-ember-services'

alias vsDevStart='vs_setup_for_dev $BARONESS_PATH'
alias vsDevStop='vs_destroy_for_dev $BARONESS_PATH'


vs_setup_for_dev() {
  PATH_TO_PROJECT=$1

  if [ -z "$PATH_TO_PROJECT" ]
  then
    # user didnt pass in a project path. print error to console and exit
    echo "Please pass in a path to the project to want to set up for."
  else

    # VS  - create npm link to self
    cd $VUE_SERVICES_PATH;
    npm link

    # VES - use link to VS
    #     - create npm link to self
    cd $VUE_EMBER_SERVICES_PATH;
    npm link $VUE_SERVICES_PKG_NAME;
    npm link

    # PROJECT - use link both
    cd $PATH_TO_PROJECT
    npm link $VUE_SERVICES_PKG_NAME;
    npm link $VUE_EMBER_SERVICES_PKG_NAME
  fi
}

vs_destroy_for_dev() {
  PATH_TO_PROJECT=$1

  if [ -z "$PATH_TO_PROJECT" ]
  then
    # user didnt pass in a project path. print error to console and exit
    echo "Please pass in a path to the project to want to set up for."
  else

    # VS  - remove own named link
    cd $VUE_SERVICES_PATH;
    npm unlink

    # VES - remove own named link
    #     - stop using VS link
    cd $VUE_EMBER_SERVICES_PATH;
    npm unlink $VUE_SERVICES_PKG_NAME;
    npm unlink

    # PROJECT    - stop using VS link
    #            - stop using VES link
    cd $PATH_TO_PROJECT
    npm unlink $VUE_SERVICES_PKG_NAME;
    npm unlink $VUE_EMBER_SERVICES_PKG_NAME

  fi
}