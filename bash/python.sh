VIRTUALENVWRAPPER_PATH=/usr/local/bin/virtualenvwrapper.sh
if [ -x $VIRTUALENVWRAPPER_PATH ]; then
    export VIRTUALENVWRAPPER_PYTHON=$(which python3)
    source $VIRTUALENVWRAPPER_PATH
fi
