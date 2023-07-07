#!/usr/bin/env bash
#reveal pane id "com.apple.preference.sidecar"

read -d '' AppleScript <<EOF
do shell script "open x-apple.systempreferences:com.apple.Displays-Settings.extension"
EOF
osascript -e "$AppleScript"