# The following lines were added by compinstall
zstyle :compinstall filename '/home/ben/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export LC_CTYPE=en_US.UTF-8
export PGDATA=/usr/local/var/postgres
export PGHOST=localhost

# help determine whether commands work
exists () {
    type $* > /dev/null
}
is_osx () {
    [[ `uname` == 'Darwin' ]]
}
is_linux () {
    [[ `uname` == 'Linux' ]]
}

source ~/conf/setup_paths

source_all_from_dir () {
    for module in $1/*.zsh(N); do
        source $module
    done
}

if is_osx; then
    source_all_from_dir ~/.zsh/osx
fi
if is_linux; then
    source_all_from_dir ~/.zsh/linux
fi
source_all_from_dir ~/.zsh
HOST_CLEANED=`echo $HOST | sed 's/\..*$//'`
source_all_from_dir ~/.zsh/$HOST_CLEANED

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export NVM_DIR="/Users/ben/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
