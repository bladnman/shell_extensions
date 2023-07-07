

__PCLI=prospero-cli
__BUNDLES_PATH=/Users/bladnman/code/p/rnps-game-hub/bundles
__TARGET_PATH=/data/rnps/gamehub-stage/

  echo
  $__PCLI $__CONSOLE_IP upload --host-path=./bundles --target-path=${__DEST_PATH} --is-directory
