#!/bin/zsh

# hooks to time long running functions and notify me when they're done

if exists not_focused && exists send_notification ; then
    maybe_notify_command_finished () {
        local last_command="$(fc -lL -1 | sed -E 's/[0-9]+ +//')"
        if [[ $TTYIDLE -gt 5 ]] && not_focused; then
            send_notification "Command finished" "$last_command"
            # we start it in the background and disown so we don't get noisy output or info
            say "command finished" &!
        fi
    }
    precmd_functions+=maybe_notify_command_finished
    myconfigs[notifications]=installed
else
    myconfigs[notifications]=not-installed
fi
