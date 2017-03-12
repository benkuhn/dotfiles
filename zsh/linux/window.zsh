#!/bin/zsh

not_focused () {
    if [[ $( xprop -root 32i _NET_ACTIVE_WINDOW | sed 's/.*# //') == $WINDOWID ]]; then
        return 1
    else
        return 0
    fi
}

send_notification () {
    notify-send $1 $2
}
