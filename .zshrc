HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
# share history quickly
setopt share_history
setopt hist_ignore_dups
setopt autocd
setopt nomatch
setopt notify
unsetopt beep
bindkey -e
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ben/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
[[ $EMACS = t ]] && unsetopt zle
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ '
autoload colors
colors
PROMPT=" %{$terminfo[bold]%}%{$fg[cyan]%}%.%(?..%{$fg[red]%} %?)%{$terminfo[sgr0]%} %# "
setopt autopushd
export EDITOR="emacsclient -a emacs"
export PATH=$PATH:~/bin:~/.cabal/bin
export EC2_PRIVATE_KEY=pk-TBY5INXXQIFTIAUEB3SLPWAVYIBPMUDQ.pem
export EC2_CERT=cert-TBY5INXXQIFTIAUEB3SLPWAVYIBPMUDQ.pem
WORDCHARS=${WORDCHARS//[\/\.]}

# help determine whether commands work
exists () {
    type $* > /dev/null
}
is_osx () {
    [[ `uname` == 'Darwin' ]]
}
is_linux () {
    [[ `uname` == 'Linux' ]]
}

# nice aliases
if is_linux; then
    alias grep='grep --color=auto'
    alias ls='ls -h --color=auto'
    alias canhaz='sudo apt-get install'
    alias open=xdg-open
    alias clip='xclip -sel clip'
    alias ts='trash-put'
    alias pbcopy='xclip -selection clipboard -i'
    alias pbpaste='xclip -selection clipboard -o'
else
    alias grep='grep --color=auto'
    alias ls='ls -hG'
    alias canhaz='brew install'
fi

alias gitsquash='git rebase -i `git merge-base HEAD master`'
alias gitprune="git branch --merged | grep -v '\*' | xargs -n 1 git branch -d"

gitpushbranch () {
    # push a branch to master
    $BRANCH="`git rev-parse --abbrev-ref HEAD`"
    git checkout master && git fetch && git pull && git merge $BRANCH --ff-only && git push origin master
}

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
exists rvm && rvm use 1.9.2 > /dev/null
# configure OPAM
exists opam && eval `opam config env`

# hooks to time long running functions and notify me when they're done
# TODO make portable
if exists xprop; then
    BK_LAST_TIME=`date +%s`
    BK_LAST_COMMAND=""
    not_focused () {
        if [[ $( xprop -root 32i _NET_ACTIVE_WINDOW | sed 's/.*# //') == $WINDOWID ]]; then
            return 1;
        else
            return 0;
        fi
    }
    preexec () {
        BK_LAST_COMMAND="$1"
        BK_LAST_TIME=`date +%s`
    }
    precmd () {
        if not_focused && [[ $((`date +%s` - BK_LAST_TIME)) > 1 && $BK_LAST_COMMAND != "" ]]; then
            notify-send "Command finished" "$BK_LAST_COMMAND"
            BK_LAST_COMMAND=""
        fi
    }
fi

# integrate ZLE kill buffer with clipboard
# TODO integrate C-w, M-d, etc.
if exists pbcopy; then
    kill-line() { zle .kill-line ; echo -n $CUTBUFFER | pbcopy }
    zle -N kill-line # bound on C-k

    backward-kill-word() { zle .backward-kill-word ; echo -n $CUTBUFFER | pbcopy }
    zle -N backward-kill-word # bound on C-k

    yank() { LBUFFER=$LBUFFER$(pbpaste) }
    zle -N yank # bound on C-y
fi

alr () {
    # get rid of any other venv if necessary
    declare -f deactivate > /dev/null && deactivate
    source ~/Apps/Enthought/Canopy/User/bin/activate
    local al="/home/bkuhn/code/al"
    PYTHONPATH="$al/alpha:$al/prosper-data/:$al/pdl-scikit/:$PYTHONPATH"
    export PYTHONPATH
    cd ~/code/al/
}
