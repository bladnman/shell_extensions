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

echo_blue "... pushing to github.com"

# when there were passwords...
#git remote add origin "https://github.com/${USER:-${GITHUBUSER}}/${REPONAME:-${CURRENTDIR}}.git"

# now there is ssh only
git remote add origin "git@github.com:${USER:-${GITHUBUSER}}/${REPONAME:-${CURRENTDIR}}.git"

git push -u origin main
