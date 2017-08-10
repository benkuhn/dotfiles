### Added by the Heroku Toolbelt
local HEROKU_PATH="/usr/local/heroku/bin"

if [ -d $HEROKU_PATH ]; then
    path+="$HEROKU_PATH"
    myconfigs[heroku]=installed
else
    myconfigs[heroku]=not-installed
fi
