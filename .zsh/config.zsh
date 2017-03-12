#!/bin/zsh

# fix line editing in case 
[[ $EMACS = t ]] && unsetopt zle
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ '
autoload colors
colors

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
# share history quickly
setopt share_history
setopt hist_ignore_dups
setopt autocd
setopt nomatch
setopt notify
setopt autopushd
setopt prompt_subst
unsetopt beep
bindkey -e

bk_reset_prompt () {
    PROMPT='$(parse_git_branch) %{$terminfo[bold]%}%{$fg[cyan]%}%.%(?..%{$fg[red]%} %?)%{$terminfo[sgr0]%} %# '
    BK_DID_SET_PROMPT=1
}
if [[ $BK_DID_SET_PROMPT != '1' ]]; then
    bk_reset_prompt
fi

export EDITOR="emacs -Q"
WORDCHARS=${WORDCHARS//[\/\.]}

# TODO(ben): make this idempotent so I can reload .zshrc properly
export PATH=$PATH:~/bin
