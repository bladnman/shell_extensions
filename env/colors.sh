SH_COLOR_BLACK='\033[0;30m'
SH_COLOR_WHITE='\033[0;37m'
SH_COLOR_RED='\033[0;31m'
SH_COLOR_YELLOW='\033[0;33m'
SH_COLOR_GREEN='\033[0;32m'
SH_COLOR_CYAN='\033[0;36m'
SH_COLOR_BLUE='\033[0;36m'
SH_COLOR_NC='\033[0m' # No Color
SH_COLOR_BOLD=$(tput bold)
SH_COLOR_NORMAL=$(tput sgr0)
# Black        0;30
# Red          0;31
# Green        0;32
# Brown/Orange 0;33
# Blue         0;34
# Purple       0;35
# Cyan         0;36
# Light Gray   0;37
# Dark Gray     1;30
# Light Red     1;31
# Light Green   1;32
# Yellow        1;33
# Light Blue    1;34
# Light Purple  1;35
# Light Cyan    1;36
# White         1;37

# EXAMPLE
#echo -e "I ${SH_COLOR_BOLD}love${SH_COLOR_NORMAL} ${SH_COLOR_YELLOW}FRESH${SH_COLOR_NC} fish"
