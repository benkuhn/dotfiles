# allow Homebrew bins to shadow system bins and manpages
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
# allow Homebrew bins to shadow system bins and manpages
export MANPATH="/usr/local/bin:/usr/local/sbin:$MANPATH"
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
source /usr/local/bin/virtualenvwrapper.sh
# Use GNU coreutils because they're better than OS X's
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
