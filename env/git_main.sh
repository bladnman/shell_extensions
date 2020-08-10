alias glt_since='_git__log_tickets_since'
alias glt_since_string='_git__log_tickets_since_string'
alias gl_since='_git__log_since'
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
    false
    return
  else
    true
    return
  fi
}
_git__isnot_git_tree() {
  if _git__is_git_tree; then
    false
    return
  else
    true
    return
  fi
}
_git__has_changes() {
  if _git__isnot_git_tree; then
    false
    return
  fi
  # -z testing for empty
  if [[ -z $(_git__status) ]]; then
    false
    return
  else
    true
    return
  fi
}
_git__status() {
  # execute the command and look at both
  # standard out and standard error
  echo $(git status --porcelain 2>&1)
}
_git__local_branch_exists() {
  # https://stackoverflow.com/q/5167957/473501
  #
  # note: this only checks local-known branches!
  #
  git show-ref --verify --quiet refs/heads/$1
  # $? == 0 means local branch with <branch-name> exists.
}
_git__current_branch_name() {
  # https://stackoverflow.com/a/24210877/473501
  git branch --no-color | grep -E '^\*' | awk '{print $2}' ||
    echo "default_value"
  # or
  # git symbolic-ref --short -q HEAD || echo "default_value";
}
_git__log_tickets_since_string() {
  git log -i --grep=NEBULA --grep=IFG ...$1 | grep -ioE "NEBULA[ -][0-9]*|IFG[ -][0-9]*" | tr '[a-z]' '[A-Z]' | sort -u | paste -sd, -
}
_git__log_tickets_since() {
  git log -i --grep=NEBULA --grep=IFG ...$1 | grep -ioE "NEBULA[ -][0-9]*|IFG[ -][0-9]*" | tr '[a-z]' '[A-Z]' | sort -u
}
_git__log_since() {
  git log -i --oneline ...$1
}
