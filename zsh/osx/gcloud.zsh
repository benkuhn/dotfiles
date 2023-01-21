local GCLOUD_DIR=$HOME/bin/google-cloud-sdk
if [ -d $GCLOUD_DIR ]; then
    # The next line updates PATH for the Google Cloud SDK.
    if [ -f '/Users/ben/bin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ben/bin/google-cloud-sdk/path.zsh.inc'; fi

    # The next line enables shell command completion for gcloud.
    if [ -f '/Users/ben/bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ben/bin/google-cloud-sdk/completion.zsh.inc'; fi    # The next line updates PATH for the Google Cloud SDK.
    export CLOUDSDK_PYTHON=$(which python3)
    myconfigs[gcloud]=installed
else
    myconfigs[gcloud]=not-installed
fi
