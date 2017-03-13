#!/bin/zsh

if exists opam; then
    eval `opam config env`
    myconfigs[opam]=installed
else
    myconfigs[opam]=not-installed
fi
