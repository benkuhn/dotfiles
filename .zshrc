# The following lines were added by compinstall
zstyle :compinstall filename '/home/ben/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

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
