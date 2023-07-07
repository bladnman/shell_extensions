#!/usr/bin/env bash

open x-apple.systempreferences:com.apple.Displays-Settings.extension

#  activate
#delay 1
read -d '' AppleScript <<EOF
tell application "System Settings"
  tell application "System Events" to click first menu button of first window of application process "System Settings" of application "System Events"
  tell application "System Events" to click first menu item of first menu of first menu button of first window of application process "System Settings" of application "System Events"
  quit
end tell
EOF
osascript -e "$AppleScript"