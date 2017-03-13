#!/bin/zsh

if [ -d "/usr/texbin" ]; then
    path+=/usr/texbin
    myconfigs[tex]=installed
else
    myconfigs[tex]=not-installed
fi
