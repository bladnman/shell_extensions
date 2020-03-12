
# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  FUNCTIONS
# -=-=-=-=-=-=-=-=-=-=-=-=
_test_branch() {
  if $(_git__branch_exists $1); then
    echo_green "branch exists"
  else 
    echo_warn "not a branch"
  fi
}
_git__is_git_tree() {
  if [[ $(_git__status) =~ fatal ]]; then
    false; return
  else 
    true; return
  fi
}
_git__isnot_git_tree() {
  if _git__is_git_tree; then
    false; return
  else 
    true; return
  fi
}
_git__has_changes() {
  if _git__isnot_git_tree; then
    false; return
  fi
  # -z testing for empty
  if [[ -z $(_git__status) ]]; then
    false; return
  else 
    true; return
  fi
}
_git__status() {
  # execute the command and look at both
  # standard out and standard error
  echo $( git status --porcelain 2>&1)
}
_git__branch_exists() {
  # https://stackoverflow.com/questions/5167957/is-there-a-better-way-to-find-out-if-a-local-git-branch-exists
  #
  # note: this only checks local-known branches AFAIK
  #
  git show-ref --verify --quiet refs/heads/$1
  # $? == 0 means local branch with <branch-name> exists. 
}
