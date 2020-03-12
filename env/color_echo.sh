# REQUIRES colors.sh
alias echo_log='_echo__log'
alias echo_green='_echo__green'
alias echo_error='_echo__red'
alias echo_red'_echo__red'
alias echo_warn='_echo__yellow'
alias echo_yellow='_echo__yellow'

_echo__log() {
  echo $1
}
_echo__yellow() {
  echo "${SH_COLOR_YELLOW}${1}${SH_COLOR_NC}"
}
_echo__red() {
  echo "${SH_COLOR_RED}${1}${SH_COLOR_NC}"
}
_echo__green() {
  echo "${SH_COLOR_GREEN}${1}${SH_COLOR_NC}"
}
# give seconds will print dhms
function displaytime {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  (( $D > 0 )) && printf '%d days ' $D
  (( $H > 0 )) && printf '%d hours ' $H
  (( $M > 0 )) && printf '%d minutes ' $M
  (( $D > 0 || $H > 0 || $M > 0 )) && printf 'and '
  printf '%d seconds\n' $S
}
