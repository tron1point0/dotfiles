#!/bin/bash

function map { local a; while read a ; do eval "$* $a" ; done ; }
function filter { local a; while read a ; do eval "$* $a" && echo $a ; done ; }
function append { local s=$1; shift 1;echo $*$s ; }
function first { local a; while read a ; do eval "$* $a" && return 0 ; done ; }
function tokens { for t in $@; do echo $t ; done ; }
function untokens {
    local str
    read str
    while read l; do str="$str${FS:- }$l";done
    echo $str
}
function reverse {
    local i=0
    local arr a
    while read a; do arr[$i]=$a && i=$(($i+1)); done
    while [ $i -gt 0 ]; do i=$(($i-1)) && echo ${arr[$i]}; done
}
function all {
    local a
    local ret=0
    while read a ; do eval "$* $a" || ret=1 ; done
    return $ret
}
function any {
    local a
    local ret=1
    while read a ; do eval "$* $a" && ret=0 ; done
    return $ret
}

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
    function execp { [ -x "$1" ] && echo $1 ; }
    local fn='first execp'
    [ "$args" = '-a' ] && fn='any execp'
    [ "$args" = '-s' ] && fn='first execp >/dev/null'
    function check { (IFS=:;tokens $PATH ) | map append /$1 | $fn ; }
    tokens $@ | all check
}
function can { whish -s $1 ; }
function try { can $1 && $* ; }
can which || alias which=whish

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

can brew && path -a "$(brew --prefix coreutils)/libexec/gnubin"

alias ls='ls -v --color'
ls --help | grep [-][-]group-directories-first \
    | column -t | cut -f1 1>/dev/null && \
    alias ls='ls -v --color --group-directories-first'
can axel && alias axel='axel -a'
can tmux && alias screen='tmux attach'
can xdg-open && alias open='xdg-open'

# Change case
function upper {
    echo $1 | tr "[:lower:]" "[:upper:]"
}

function lower {
    echo $1 | tr "[:upper:]" "[:lower:]"
}

if can bc ; then
    function base {
        base=`upper $1`
        num=`lower $2`
        echo "obase=$base; $num" | bc
    }
    function calc {
        echo "$*" | bc
    }
fi

