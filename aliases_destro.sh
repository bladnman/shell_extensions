
DESTRO_OFFICE_FIRE_STICK_IP='192.168.1.32'
DESTRO_HOME_DINING_FIRE_STICK_IP='192.168.1.17'
DESTRO_FIRE_IP=$DESTRO_OFFICE_FIRE_STICK_IP

alias destroConnect='_adbConnect $DESTRO_FIRE_IP'
alias destroStop='destroConnect; _destroStop'
alias destroRestart='destroConnect; _destroStop; destroStart'
alias destroStart='_destroStartWithUrl profiles'
alias destroTypeText='destroConnect; _adbTypeText'
alias destroSetIP='_destroSetIP'
alias destroLog='pidcat'


# D E S T R O
SNEI_DESTRO_PKG='com.snei.vue.firetv'
SNEI_DESTRO_DEBUG_PKG='com.snei.vue.firetv.debug'
SNEI_DESTRO_STAGE_PKG='com.snei.vue.firetv.stage'

_destroSetIP() {
  DESTRO_FIRE_IP=$1
}
_destroStartWithUrl() {
  destroConnect;
  destroStop;
  /usr/bin/open -a "/Applications/Google Chrome.app/" 'http://'$DESTRO_FIRE_IP':9222/';

  IPWIFI=`ipWIFI`;
  # adb shell am start --user 0  -e url http://$IPWIFI:4200/$1 -n com.snei.vue.android.firetv/.ui.dev.UrlLaunchActivity;
  adb shell am start --user 0  -e url http://$IPWIFI:4200/$1 -n $SNEI_DESTRO_DEBUG_PKG/$SNEI_DESTRO_PKG.ui.dev.UrlLaunchActivity;
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
