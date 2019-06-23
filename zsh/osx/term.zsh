is_iterm () {
    [[ -v ITERM_SESSION_ID ]]
}
is_kitty () {
    [[ -v KITTY_WINDOW_ID ]]
}

if is_iterm; then
    source_all_from_dir $ZSH_DIR/osx/iterm
fi
if is_kitty; then
    source_all_from_dir $ZSH_DIR/osx/kitty
fi
