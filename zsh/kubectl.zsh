if which kubectl >/dev/null; then
    source <(kubectl completion zsh)
    myconfigs[kubectl]=installed
else
    myconfigs[kubectl]=not-installed
fi
