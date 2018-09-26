set_title () {
    echo -ne "\033]0;$1\007"
}

echo_default_title () {
    local title=$(basename "$PWD")
    if [[ -n "$VIRTUAL_ENV" ]]; then
        title="($(basename "$VIRTUAL_ENV")) $title"
    fi
    echo $title
}

precmd_set_title () {
    set_title $(echo_default_title)
}

preexec_set_title () {
    local words=(${(z)2})
    while [[ $words[1] =~ ".*=.*" ]]; do shift words; done
    local cmd=$(basename $words[1])
    case $cmd in
    # special cases for things that open subshells
    runin)
        set_title "runin $words[2]"
        ;;
    docker-compose)
        local subcmd=$words[2]
        case $subcmd in
        logs)
            local service=$words[-1]
            set_title "dc:$service logs"
            ;;
        run)
            local service=$words[-2]
            set_title "dc:$service"
            ;;
        esac
        ;;
    find|grep)
        set_title "$cmd in $(echo_default_title)"
        ;;
    ssh|ipython)
        # these handle the title themselves
        ;;
    *)
        # do nothing
        ;;
    esac
}

precmd_functions+=precmd_set_title

preexec_functions+=preexec_set_title
