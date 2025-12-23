if which kubectl >/dev/null; then
    local fname=$ZSH_GENERATED_DIR/_kubectl
    if is_stale "$fname"; then
        ( kubectl completion zsh > "$fname" & ) &> /dev/null
    fi
    KUBECONFIG=''
    for fname in ~/.kube/config.*(N); do
        KUBECONFIG=$KUBECONFIG:$fname
    done
    KUBECONFIG=${KUBECONFIG:1}
    export KUBECONFIG
    myconfigs[kubectl]=installed
else
    myconfigs[kubectl]=not-installed
fi
