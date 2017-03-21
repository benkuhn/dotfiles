# === DISPLAY LOGIC ===
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

function set_title {
    local LAST_STATUS=$?
    local git_repo=$(git rev-parse --show-toplevel 2> /dev/null)
    if [[ -n $VIRTUAL_ENV ]]; then
        title "py:$(basename $VIRTUAL_ENV) "
    elif [[ -n $git_repo ]]; then
        title "git:$(basename $git_repo) "
    else
        title ".../$(basename $PWD) "
    fi
    return $LAST_STATUS
}

# color escape sequences
cbblue="$(tput bold; tput setaf 4)"
cbcyan="$(tput bold; tput setaf 6)"
cbred="$(tput bold; tput setaf 1)"
creset="$(tput sgr0)"

# === ACTUAL PROMPT ===
PS1=' \[$cbblue\]$(describe_git_branch)'  # Git status
PS1+='\[$cbcyan\]\W '                     # Working directory
PS1+='\[$cbred\]$(describe_exit_status)'  # $? if nonzero
PS1+='\[$creset\]\$ '                     # And a $
PS1+='\[$(set_title)\]'                   # And set the window title
