if [ -d /opt/homebrew/bin ]; then
    # allow Homebrew bins to shadow system bins and manpages
    path+=(/opt/homebrew/bin)
    myconfigs[homebrew]=installed
elif [ -d /usr/local/bin ]; then
    path+=(/usr/local/bin /usr/local/sbin)
    myconfigs[homebrew]=installed
else
    myconfigs[homebrew]=not-installed
fi

# Use GNU coreutils because they're better than OS X's
local GNUBIN_PATH=/usr/local/opt/coreutils/libexec/gnubin
if [ -d $GNUBIN_PATH ]; then
    path+=$GNUBIN_PATH
    myconfigs[gnu-coreutils]=installed
else
    myconfigs[gnu-coreutils]=not-installed
fi

# Fuck Homebrew auto update
export HOMEBREW_NO_AUTO_UPDATE=1
