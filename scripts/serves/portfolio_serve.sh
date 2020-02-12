#!/bin/bash

PUBLISHER_FOLDER=~/code/portfolio/portfolio-publisher
VIEWER_FOLDER=~/code/portfolio/portfolio-viewer

_portfolio_serve_publisher() {
  cd $PUBLISHER_FOLDER
  npm start &
  sleep 1
}
_portfolio_serve_viewer() {
  cd $VIEWER_FOLDER
  npm start &
  sleep 1
}


echo "Starting Portfolio servers"
trap "exit" INT TERM ERR
trap "kill 0" EXIT

_portfolio_serve_publisher
_portfolio_serve_viewer

echo "Browsers should auto-launch to the following:"
echo "      Viewer : http://localhost:3000/#/"
echo "   Publisher : http://localhost:3001/#/"
echo "-------------"
echo "Portfolio servers on their way ..."

wait


