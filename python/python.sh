##
# pyenv allows for multiple python environments and
# keeps us from having to keep things in sync.
#
# I install this using brew
#
# https://github.com/pyenv/pyenv
# https://opensource.com/article/19/5/python-3-default-mac

PYENV_ROOT=~/.pyenv
export PATH="$PYENV_ROOT/shims:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# activating pyenv-virtualenv plugin
# this assumes using pyenv
if which pyenv-virtualenv-init >/dev/null; then
  eval "$(pyenv virtualenv-init -)"
fi
