#!/bin/zsh
local PYUTILS_DIR=$HOME/code/pyutils/
if [[ -d $PYUTILS_DIR ]]; then
    pythonpath+="$PYUTILS_DIR"
    myconfigs[python-pyutils]=installed
else
    myconfigs[python-pyutils]=not-installed
fi

local VIRTUALENVWRAPPER_PATH=/usr/local/bin/virtualenvwrapper_lazy.sh
if [[ -x $VIRTUALENVWRAPPER_PATH ]]; then
    VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
    source $VIRTUALENVWRAPPER_PATH
    myconfigs[python-virtualenvwrapper]=installed
else
    myconfigs[python-virtualenvwrapper]=not-installed
fi

if which pyenv > /dev/null && [[ -d ~/.pyenv ]] ; then
    path+=~/.pyenv/shims
    myconfigs[python-pyenv]=installed
else
    myconfigs[python-pyenv]=not-installed
fi

if which python3 > /dev/null; then
    local python_user_bin=$(python3 -c 'import site; print(site.USER_BASE)')/bin
    if [[ -d $python_user_bin ]]; then
        path+=$python_user_bin
        myconfigs[python-user-bin]=installed
    else
        myconfigs[python-user-bin]=not-installed
    fi
else
    myconfigs[python-user-bin]=not-installed
fi
