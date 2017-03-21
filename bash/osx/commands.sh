alias ls='ls -h'
function title {
    echo -ne "\033]0;$@\007"
}
