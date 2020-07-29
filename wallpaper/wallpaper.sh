#!/bin/bash
## - - - - - - - -
## WALLPAPER SETTER
## see script file for config and install notes
##

# -=-+-=-+-=-+-=-+
# -= ENV VARS
# -=-+-=-+-=-+-=-+
local SCRIPT_DIR_WALLPAPER=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")
## - - - - - - - -

alias wp='. $SCRIPT_DIR_WALLPAPER/scripts/change_wallpaper.sh'
