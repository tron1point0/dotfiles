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

# Change case
function upper {
    echo $1 | tr "[:lower:]" "[:upper:]"
}

function lower {
    echo $1 | tr "[:upper:]" "[:lower:]"
}

