_hello_penguin() {
  echo "(0>"
  echo "//\\"
  echo "V_/_ "
}
_hello_fish() {
  echo
  echo "${SH_COLOR_GREEN}   Hello sir"
  echo "${SH_COLOR_GREEN}  Let's play!${SH_COLOR_YELLOW}"
  echo "    o  _/,_"
  echo "    . /o...\\__//"
  echo "      \\_'__/\`\`\\\`"
  echo "        \\\`"
  echo "${SH_COLOR_NC}"
}
# _hello_fish() {
#   echo "    o  _/,_"
#   echo "    . /o...\\__//"
#   echo "      \\_'__/\`\`\\\`"
#   echo "        \\\`"
# }
_hello_piggy1() {
  echo
  echo_yellow "    〝(ˆ(oo)ˆ)〞"
  echo_green "     CHEEEEEZZ!"
  echo
}
_hello_piggy2() {
  echo
  echo_yellow "        ___&"
  echo_yellow "      e'^_ )"
  echo_yellow "        \" \"  "
  echo_green "     Oink Oink"
  echo
}
_hello_piggy3() {
  echo
  echo_yellow "          _"
  echo_yellow "          |\_,,____"
  echo_yellow "          ( o__o \/"
  echo_yellow "          /(..)  \\ "
  echo_yellow "         (_ )--( _)"
  echo_yellow "         / \"\"--\"\" \\ "
  echo_yellow "  ,===,=| |-,,,,-| |==,=="
  echo_yellow "  |   |  WW   |  WW   |"
  echo_yellow "  |   |   |   |   |   |"
  echo_green "     mmff mf mff mff..."
  echo
}
_hello_piggy4() {
  echo
  echo_yellow "        (\\____/)"
  echo_yellow "        / @__@ \\ "
  echo_yellow "       (  (oo)  )"
  echo_yellow "        \`-.~~.-'"
  echo_yellow "         /    \\ "
  echo_yellow "       @/      \\_"
  echo_yellow "      (/ /    \\ \\)"
  echo_yellow "       WW\`----'WW"
  echo_green "          uh..."

}

# Generate a random number between 1 and 5
random_choice=$((RANDOM % 5 + 1))

# Call a function based on the random number
case $random_choice in
1)
  _hello_fish
  ;;
2)
  _hello_piggy1
  ;;
3)
  _hello_piggy2
  ;;
4)
  _hello_piggy3
  ;;
5)
  _hello_piggy4
  ;;
esac
