local RUST_BIN="$HOME/.cargo/bin"

if [[ -d "$RUST_BIN" ]]; then
    path+="$RUST_BIN"
    myconfigs[rust]=installed
else
    myconfigs[rust]=not-installed
fi
