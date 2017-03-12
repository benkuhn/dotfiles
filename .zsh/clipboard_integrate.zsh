#!/bin/zsh

# integrate ZLE kill buffer with clipboard
# TODO integrate C-w, M-d, etc.
# TODO better integration with C-w
# e.g. foo bar C-w C-w should put "foo bar" in the clipboard, not just "foo"
if exists pbcopy; then
    kill-line() { zle .kill-line ; echo -n $CUTBUFFER | pbcopy }
    zle -N kill-line # bound on C-k

    backward-kill-word() { zle .backward-kill-word ; echo -n $CUTBUFFER | pbcopy }
    zle -N backward-kill-word # bound on C-k

    yank() { LBUFFER=$LBUFFER$(pbpaste) }
    zle -N yank # bound on C-y
fi
