
_git_rename_branch() {
  OLD_BRANCH=$1
  NEW_BRANCH=$2

  if [ -z "$OLD_BRANCH" ]; then
   echo "Must provide an OLD branch name"
   echo "usage: git_rename_branch OLD_BRANCH NEW_BRANCH"
   return
  fi

  if [ -z "$NEW_BRANCH" ]; then
   echo "Must provide a NEW branch name"
   echo "usage: git_rename_branch OLD_BRANCH NEW_BRANCH"
   return
  fi

  git branch -m $OLD_BRANCH $NEW_BRANCH         # Rename branch locally
  git push origin :$OLD_BRANCH                  # Delete the old branch
  git push --set-upstream origin $NEW_BRANCH    # Push the new branch, set local branch to track the new remote
}

alias git_rename_branch='_git_rename_branch'

