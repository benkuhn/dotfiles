local GCLOUD_DIR=~/wave/google-cloud-sdk/

if [ -d $GCLOUD_DIR ]; then
    # The next line updates PATH for the Google Cloud SDK.
    source '/Users/ben/wave/google-cloud-sdk/path.zsh.inc'
    # The next line enables shell command completion for gcloud.
    source '/Users/ben/wave/google-cloud-sdk/completion.zsh.inc'
    myconfigs[wave-gcloud]=installed
else
    myconfigs[wave-gcloud]=not-installed
fi

# Postgres settings
export LC_CTYPE=en_US.UTF-8
export PGDATA=/usr/local/var/postgres
export PGHOST=localhost
