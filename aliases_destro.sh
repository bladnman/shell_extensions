
DESTRO_OFFICE_FIRE_STICK_IP='192.168.1.32'
DESTRO_HOME_DINING_FIRE_STICK_IP='192.168.1.17'
DESTRO_FIRE_IP=$DESTRO_OFFICE_FIRE_STICK_IP

alias destroConnect='_adbConnect $DESTRO_FIRE_IP'
alias destroDisconnect='adb disconnect'
alias destroDevices='adb devices'
alias destroStop='destroConnect; _destroStop'
alias destroRestart='destroConnect; _destroStop; destroStart'
alias destroStart='_destroStartWithUrl profiles'
alias destroStartAll='_destroStartWithUrl profiles; _destroOpenWebTools'
alias destroTypeText='destroConnect; _adbTypeText'
alias destroSetIP='_destroSetIP'
alias destroLog='pidcat'
alias destroScreenShot='adb shell screencap -p | perl -pe "s/\x0D\x0A/\x0A/g" > screen.png'
alias destroUninstall='adb uninstall com.snei.vue.firetv.debug'
alias destroInstall='adb install '
alias destroWebTools='_destroOpenWebTools'
# alias destroTypeLocalServerUrlHome='destroTypeText http://:4200/profiles'
alias destroTypeLocalHost='_destroTypeLocalHost'
alias destroTop='adb shell -m 5'
alias destroWebLog='adb logcat | grep CONSOLE'

# short aliases
alias ds='destroStart'
alias dsa='destroStartAll'
alias dw='destroStop'

# LOCATION SETTERS
alias destroSetToOfficeStick='destroSetIP $DESTRO_OFFICE_FIRE_STICK_IP; destroConnect'
alias destroSetToHomeDiningRoomStick='destroSetIP $DESTRO_HOME_DINING_FIRE_STICK_IP; destroConnect'

# D E S T R O
SNEI_DESTRO_PKG='com.snei.vue.firetv'
SNEI_DESTRO_DEBUG_PKG='com.snei.vue.firetv.debug'
SNEI_DESTRO_STAGE_PKG='com.snei.vue.firetv.stage'

_destroSetIP() {
  echo 'Setting IP: ' $1
  DESTRO_FIRE_IP=$1
}
_destroOpenWebTools() {
  /usr/bin/open -a "/Applications/Google Chrome.app/" 'http://'$DESTRO_FIRE_IP':9222/';
}
_destroTypeLocalHost() {
  IPWIFI=`ipWIFI`;
  destroTypeText http://$IPWIFI:4200/profiles;
}
_destroStartWithUrl() {
  destroConnect;
  destroStop;
  adb shell am start -a android.intent.action.MAIN -n ${SNEI_DESTRO_DEBUG_PKG}/${SNEI_DESTRO_PKG}.ui.PSVue
  IPWIFI=`ipWIFI`;
  adb shell am broadcast -a com.snei.vue.launch.url --es url http://$IPWIFI:4200/profiles
}
_destroStop() {
  # adb shell am force-stop com.snei.vue.android.firetv
  adb shell am force-stop $SNEI_DESTRO_DEBUG_PKG
}
_adbTypeText() {
  adb shell input text $1
}
_adbConnect() {
  echo 'Connecting to IP: ' $1
  adb connect $1
}
