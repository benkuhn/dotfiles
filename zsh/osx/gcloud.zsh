local GCLOUD_DIR=$HOME/bin/google-cloud-sdk
if [ -d $GCLOUD_DIR ]; then
    # The next line updates PATH for the Google Cloud SDK.
    source "$GCLOUD_DIR/path.zsh.inc"
    # The next line enables shell command completion for gcloud.
    local fname=$ZSH_GENERATED_DIR/_gcloud
    if is_stale $fname; then
        echo "#compdef gcloud" > $fname
        cat "$GCLOUD_DIR/completion.zsh.inc" >> $fname
    fi
    export CLOUDSDK_PYTHON=$(which python2.7)
    myconfigs[gcloud]=installed
else
    myconfigs[gcloud]=not-installed
fi
