#!/bin/bash

function whish {
    local args=
    [ ! "${1#-[as]}" ] && args=$1 && shift 1
    if [ "$args" = '-h' -o -z "$*" ]; then
        cat <<HELP
USAGE: which [-ahs] program...
OPTIONS:
    -a  Show all matches
    -s  Silent
HELP
        return 0
    fi
    local fn='first execp'
    [ "$args" = '-a' ] && fn='any execp'
    [ "$args" = '-s' ] && fn='first execp >/dev/null'
    function execp { [ -x "$1" ] && echo $1 ; }
    function check { (IFS=:;tokens $PATH ) | map append /$1 | $fn ; }
    tokens $@ | all check
    local rv=$?
    unset -f execp
    unset -f check
    return $rv
}

whish -s which || alias which=whish
function can { which -s $1 ; }
function try { can $1 && $* ; }

