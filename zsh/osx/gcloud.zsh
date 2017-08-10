local GCLOUD_DIR=/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/
if [ -d $GCLOUD_DIR ]; then
    # The next line updates PATH for the Google Cloud SDK.
    source "$GCLOUD_DIR/path.zsh.inc"
    # The next line enables shell command completion for gcloud.
    source "$GCLOUD_DIR/completion.zsh.inc"
    myconfigs[gcloud]=installed
else
    myconfigs[gcloud]=not-installed
fi
