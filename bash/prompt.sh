function echo_star_if_git_dirty {
    [[ "$(git status --porcelain 2> /dev/null )" != "" ]] && echo "*"
}
function describe_git_branch {
    # HACK: make sure we don't affect $? by saving it to a variable and returning
    # $? at the end
    local LAST_STATUS=$?
    local BRANCH_DESC=$( \
        git branch --no-color 2> /dev/null \
        | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(echo_star_if_git_dirty)]/" \
    )
    [[ -n $BRANCH_DESC ]] && echo "$BRANCH_DESC "
    return $LAST_STATUS
}
function describe_exit_status {
    local LAST_STATUS=$?
    [[ $LAST_STATUS == 0 ]] && return
    echo "$LAST_STATUS "
    return $LAST_STATUS
}
# color escape sequences
cbblue="$(tput bold; tput setaf 4)"
cbcyan="$(tput bold; tput setaf 6)"
cbred="$(tput bold; tput setaf 1)"
creset="$(tput sgr0)"

PS1=' \[$cbblue\]$(describe_git_branch)\[$cbcyan\]\W \[$cbred\]$(describe_exit_status)\[$creset\]\$ '
