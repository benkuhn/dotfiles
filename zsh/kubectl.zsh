if which kubectl >/dev/null; then
    local fname=$ZSH_GENERATED_DIR/_kubectl
    if is_stale "$fname"; then
        kubectl completion zsh > "$fname" &
    fi
    KUBECONFIG=''
    for fname in ~/.kube/config.*; do
        KUBECONFIG=$KUBECONFIG:$fname
    done
    export KUBECONFIG
    myconfigs[kubectl]=installed
else
    myconfigs[kubectl]=not-installed
fi
