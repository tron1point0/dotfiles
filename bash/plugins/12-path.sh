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
    -l)
        tokens $(IFS=: ; echo $PATH)
    ;;
    *)
        cat <<HELP
USAGE: path -arl [paths...]
OPTIONS:
    -a  Add to PATH
        If paths... already exist in PATH, they are brought to the front
    -r  Remove from PATH
    -l  List paths in PATH, one per line
HELP
    esac
}

