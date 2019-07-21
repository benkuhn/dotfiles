not_focused () {
    local EXIT_STATUS
    ( kitty @ --to=unix:/tmp/kitty ls \
        | grep -A 1 '            "id": '$KITTY_WINDOW_ID \
        | grep false > /dev/null ) \
        || EXIT_STATUS=$?
    return $EXIT_STATUS
}

send_notification () {
    # TODO
    if exists terminal-notifier; then
        local APPID=com.googlecode.iTerm2
        terminal-notifier -message "$2" -title "$1" -activate $APPID -sender $APPID
    else
        osascript -e "display notification \"$2\" with title \"$1\""
    fi
}
