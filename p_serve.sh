#!/bin/bash

MANIFEST_FOLDER=~/code/p/ppr-urlconfig-dev
GAMEHUB_FOLDER=~/code/p/rnps-game-hub/packages/game-hub

_p_serve_manifest() {
  cd $MANIFEST_FOLDER
  yarn start &
  sleep 1
}
_p_serve_gamehub() {
  cd $GAMEHUB_FOLDER
  yarn start &
  sleep 1
}


echo "Starting manifest and app servers"
trap "exit" INT TERM ERR
trap "kill 0" EXIT

_p_serve_manifest
_p_serve_gamehub
echo "P Manifest and App servers running ..."
wait


