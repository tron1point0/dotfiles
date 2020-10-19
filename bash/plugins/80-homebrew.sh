#!/bin/bash

if can brew ; then
    BREWPREFIX='/usr/local/opt'
    GNUBIN_PACKAGES=(
        coreutils
        inetutils
        make
    )

    function add_gnubin_package {
        local libexec_path="$1/libexec"
        [[ -d "$libexec_path/gnubin" ]] && path -a "$libexec_path/gnubin"
        [[ -d "$libexec_path/gnuman" ]] && modify-env -a add -v MANPATH "$libexec_path/gnuman"
    }

    for pkg in "${GNUBIN_PACKAGES[@]}" ; do
        add_gnubin_package "$BREWPREFIX/$pkg"
    done

    path -a '/usr/local/bin'
    path -a '/usr/local/sbin'

    unset pkg
    unset add_gnubin_package
    unset -v GNUBIN_PACKAGES
    unset -v BREWPREFIX
fi

true
