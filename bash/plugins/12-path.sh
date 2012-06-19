#!/bin/bash

function path {
    local action=$1
    shift 1
    case $action in
    -a)
        path -r "$@"
        export PATH=$(tokens $@ | ( FS=: untokens )):$PATH
    ;;
    -r)
        for p in "$@"; do
            export PATH=$( ( IFS=: tokens $PATH ) | filter test $p != | ( FS=: untokens ))
        done
    ;;
    *)
        cat <<HELP
USAGE: path -ar [paths...]
OPTIONS:
    -a  Add to PATH
        If paths... already exist in PATH, they are brought to the front
    -r  Remove from PATH
HELP
    esac
}

