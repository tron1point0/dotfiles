#!/bin/bash

if can brew ; then
    declare -x COREUTILS="/usr/local/opt/coreutils"
    path -a "$COREUTILS/libexec/gnubin"
    modify_env -a add -v MANPATH -- "$COREUTILS/libexec/gnuman"
    unset -v COREUTILS
    path -a '/usr/local/bin'
    path -a '/usr/local/sbin'
fi

true

