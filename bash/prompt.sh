function echo_star_if_git_dirty {
  [[ "$(git status --porcelain 2> /dev/null )" != "" ]] && echo "*"
}
function describe_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(echo_star_if_git_dirty)]/"
}
function describe_exit_status {
    [[ $? == 0 ]] && return
    echo "$? "
}
# color escape sequences
cbblue="$(tput bold; tput setaf 4)"
cbcyan="$(tput bold; tput setaf 6)"
cbred="$(tput bold; tput setaf 1)"
creset="$(tput sgr0)"
last_status='hi :)'
git_desc=''
# set prompt variables so we can display them without running commands, which
# allows us to put \[ and \] in the right place below
function set_prompt_vars {
    local LAST_STATUS=$?
    local GIT_DESC="$(describe_git_branch)"
    if [[ $LAST_STATUS = 0 ]]; then
        last_status=''
    else
        last_status="$LAST_STATUS "
    fi
    if [[ -n $GIT_DESC ]]; then
        git_desc="$GIT_DESC "
    else
        git_desc=''
    fi
}
PROMPT_COMMAND='set_prompt_vars'
PS1=' \[$cbblue\]$git_desc\[$cbcyan\]\W \[$cbred\]$last_status\[$creset\]\$ '
