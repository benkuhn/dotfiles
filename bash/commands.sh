function e {
    # run $EDITOR on the given files
    $EDITOR "$@"
}

function title {
    echo -ne "\033]0;$@\007"
}
