#!/bin/zsh

local PYUTILS_DIR=$HOME/code/pyutils/
if [ -d $PYUTILS_DIR ]; then
    export PYTHONPATH="$PYUTILS_DIR:$PYTHONPATH"
    myconfigs[python-pyutils]=installed
else
    myconfigs[python-pyutils]=not-installed
fi

local VIRTUALENVWRAPPER_PATH=/usr/local/bin/virtualenvwrapper.sh
if [ -x $VIRTUALENVWRAPPER_PATH ]; then
    VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
    source $VIRTUALENVWRAPPER_PATH
    myconfigs[python-virtualenvwrapper]=installed
else
    myconfigs[python-virtualenvwrapper]=not-installed
fi
