if which kubectl >/dev/null; then
    local fname=$ZSH_GENERATED_DIR/_kubectl
    if is_stale "$fname"; then
        echo "generating kubectl completions $fname"
        kubectl completion zsh > "$fname"
    fi
    myconfigs[kubectl]=installed
else
    myconfigs[kubectl]=not-installed
fi
