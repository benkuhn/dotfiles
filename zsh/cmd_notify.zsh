#!/bin/zsh

# hooks to time long running functions and notify me when they're done

exists not_focused || exit
exists send_notification || exit

BK_LAST_TIME=$SECONDS
BK_LAST_COMMAND=""

preexec () {
    BK_LAST_COMMAND="$1"
    BK_LAST_TIME=$SECONDS
}
precmd () {
    if not_focused && [[ $(($SECONDS - $BK_LAST_TIME)) -gt 5 && $BK_LAST_COMMAND != "" ]]; then
        send_notification "Command finished" "$BK_LAST_COMMAND"
        # we start it in the background and disown so we don't get noisy output or info
        say "command finished" &!
    fi
    BK_LAST_COMMAND=""
}
