#!/bin/bash

if can brew ; then
    path -a "$(brew --prefix coreutils)/libexec/gnubin"
    FS=: modify_env -a add -v MANPATH -- /usr/local/opt/coreutils/libexec/gnuman
    path -a "/usr/local/bin"
    path -a "/usr/local/sbin"
fi
