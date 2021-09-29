#!/bin/bash

echo "*************"
echo "GitHub Repo Initializer"
echo ""
echo "This will create a repository in the current directory"
echo "and push that repository to github.com for you."
echo_yellow "YOU WILL NEED TO ADD THE REPO TO GITHUB YOURSELF"
echo "(instructions follow)"
echo ""

# Gather constant vars
CURRENTDIR=${PWD##*/}
# add this value (this is not a default value)
#   ``` git --global config github.user.username bladnman ```
GITHUBUSER=$(git config github.user.username)

# Get user input
read "REPONAME?New repo name [${PWD##*/}] : "
read "USER?Git Username [${GITHUBUSER}] : "
read "DESCRIPTION?Repo Description : "

echo_blue "Here we go..."

echo "+ - - - - - - - - - - - -"
echo_yellow "  ->  ${REPONAME:-${CURRENTDIR}}   "
echo_yellow "      https://github.com/new"
echo
read "__BGS?Have you created a new REPO on Github? [yes] : "

# Create a local repo if not yet created
_git_folder=$(git rev-parse --git-dir 2>/dev/null)
if [ -z "$_git_folder" ]; then
  echo_blue "... initializing git repo in this folder"

  # create readme file
  if [ ! -f "README.md" ]; then
    echo_blue "... creating readme"
    echo "# ${REPONAME:-${CURRENTDIR}}" >>README.md
  fi

  echo_blue "... creating local repo"
  git init
  git add .
  git commit -m "initial commit"
fi

# trying to push new repo to GH... no luck yet
# Curl some json to the github API oh damn we so fancy
# echo curl -u ${USER:-${GITHUBUSER}} https://api.github.com/user/repos -d "{\"name\": \"${REPONAME:-${CURRENTDIR}}\", \"description\": \"${DESCRIPTION}\", \"private\": false, \"has_issues\": true, \"has_downloads\": true, \"has_wiki\": false}"
# curl -u ${USER:-${GITHUBUSER}} https://api.github.com/user/repos -d "{\"name\": \"${REPONAME:-${CURRENTDIR}}\", \"description\": \"${DESCRIPTION}\", \"private\": false, \"has_issues\": true, \"has_downloads\": true, \"has_wiki\": false}"

echo_blue "... pushing to github.com"
git remote add origin "https://github.com/${USER:-${GITHUBUSER}}/${REPONAME:-${CURRENTDIR}}.git"
git push -u origin main
# git remote add origin https://github.com/${USER:-${GITHUBUSER}}/${REPONAME:-${CURRENTDIR}}.git
# git push -u origin

# Set the freshly created repo to the origin and push
# You'll need to have added your public key to your github account
# git remote set-url origin git@github.com:${USER:-${GITHUBUSER}}/${REPONAME:-${CURRENTDIR}}.git
# git push --set-upstream origin master
