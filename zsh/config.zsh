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
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_verify
setopt histignorespace  # start commands with space if they contain sensitive info
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

WORDCHARS=''

# display directories in light blue, not dark blue
export LSCOLORS=Exfxcxdxbxegedabagacad
# use emacs as editor
export EDITOR='emacs'
# make less use colors in escape sequences
export LESS="-R"
# make grep use colors
export GREP_OPTIONS="--color=auto"

# ~/bin: random local scripts
# ~/conf/bin: version controlled local scripts
# ~/.local/bin: claude code
path+=(~/bin ~/conf/bin ~/.local/bin)
