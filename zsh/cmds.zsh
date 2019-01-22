#!/bin/zsh

gitpushbranch () {
    # push a branch to master
    $BRANCH="`git rev-parse --abbrev-ref HEAD`"
    git checkout master && git fetch && git pull && git merge $BRANCH --ff-only && git push origin master
}

function ssha {
    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $@
}

function scpa {
    scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $@
}

function e {
    # run $EDITOR on the given files
    # word-split it in case $EDITOR includes CLI options
    ${=EDITOR} "$@"
}
