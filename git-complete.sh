# https://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion
# brew install bash-completion

# bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
echo "git-complete installed"
