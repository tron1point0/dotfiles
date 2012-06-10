#!/bin/bash

function whish {
    local args="$(expr "$1" : '^-\([as]\{1,2\}\)$')"
    local search=${2:-$1}
    local found=($(for i in ${PATH//:/ }; do [ -x "$i/$search" ] && echo "$i/$search";done))
    if [ ${#found} ]; then
        expr "$args" : '.*s.*' >/dev/null && return 0
        expr "$args" : '.*a.*' >/dev/null && for i in ${found[*]}; do echo $i; done && return 0
        echo "${found[0]}" && return 0
    fi
    return 1
}
whish -s which || alias which=whish

function can {
    which -s $1
}

function try {
    can $1 && $*
}

function add_to_path {
    expr $PATH : '.*'$1'.*' >/dev/null && export PATH=$1:$PATH
}

can brew && add_to_path "$(brew --prefix coreutils)/libexec/gnubin"

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

