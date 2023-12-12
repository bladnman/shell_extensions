##
##  NOTE:
##  NAMES WILL COLLIDE WITH OTHER SCRIPTS
##  take care to add this project's name to the
##  end of everything. SelectAll/Replace makes
##  it easy.
##

#################
# KEYS SUPPORTED
#   UP / LEFT / RIGHT / DOWN
#   R1 / L1 / R2 / L2 / R3 / L3
#   CROSS / CIRCLE / SQUARE / TRIANGLE
#   OPTION / SHARE
#   PS / TPAD / MUTE / MONKEY
#################

alias p_press_down='p_press_key DOWN $1'
alias p_press_up='p_press_key UP $1'
alias p_press_left='p_press_key LEFT $1'
alias p_press_right='p_press_key RIGHT $1'
alias p_press_r1='p_press_key R1 $1'
alias p_press_l1='p_press_key L1 $1'
alias p_press_r2='p_press_key R2 $1'
alias p_press_l2='p_press_key L2 $1'
alias p_press_r3='p_press_key R3 $1'
alias p_press_l3='p_press_key L3 $1'
alias p_press_cross='p_press_key CROSS $1'
alias p_press_circle='p_press_key CIRCLE $1'
alias p_press_square='p_press_key SQUARE $1'
alias p_press_triangle='p_press_key TRIANGLE $1'
alias p_press_option='p_press_key OPTION $1'
alias p_press_share='p_press_key SHARE $1'
alias p_press_ps='p_press_key PS $1'
alias p_press_tpad='p_press_key TPAD $1'
alias p_press_mute='p_press_key MUTE $1'
alias p_press_monkey='p_press_key MONKEY $1'

p_press_key() {
  local DIRECTION=$1
  local COUNT=${2:-1}
  for i in $(seq 1 $COUNT); do
    p_cli send key $DIRECTION
  done
}
