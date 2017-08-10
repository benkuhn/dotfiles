if [ -d /usr/local/bin ]; then
    # allow Homebrew bins to shadow system bins and manpages
    path+=(/usr/local/bin /usr/local/sbin)
    myconfigs[homebrew]=installed
else
    myconfigs[homebrew]=not-installed
fi
# Use GNU coreutils because they're better than OS X's
local GNUBIN_PATH=/usr/local/opt/coreutils/libexec/gnubin
if [ -d $GNUBIN_PATH ]; then
    path[1,0]=$GNUBIN_PATH
    manpath[1,0]=/usr/local/opt/coreutils/libexec/gnuman
fi
