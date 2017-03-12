#!/bin/zsh

alias gitsquash='git rebase -i `git merge-base HEAD master`'
alias gitprune="git branch --merged | grep -v '\*' | xargs -n 1 git branch -d"

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
