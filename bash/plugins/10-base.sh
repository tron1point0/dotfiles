#!/bin/bash

alias ls='ls -v --color'
[ `ls --version | sed -n '/ls/ s/[^0-9]//gp'` -ge 810 ] && \
    alias ls='ls -v --color --group-directories-first'
[ -x "/usr/bin/axel" ] && \
    alias axel='axel -a'
[ -x "/usr/bin/tmux" ] && \
    alias screen='tmux -f $XDG_CONFIG_HOME/tmux/tmuxrc attach'

# Change base
function base {
    base=`upper $1`
    num=`lower $1`
    echo "obase=$base; $num" | bc
}

# Check for ability
if [ ! -x /usr/bin/which ]; then
    function which {
        eval "ls {${PATH//:/,}}/autocutsel -f 2>/dev/null"
    }
fi

alias open='xdg-open'

function can {
    which $1 >/dev/null && return 0
    return 1
}

function try {
    can $1 && $*
}

# Change case
function upper {
    echo $1 | tr "[:lower:]" "[:upper:]"
}

function lower {
    echo $1 | tr "[:upper:]" "[:lower:]"
}

function calc {
    echo "$*" | bc
}

# For those machines where /bin/groups doesn't work
function groups {
    grep $USER /etc/group | cut -d ':' -f 1 | xargs
}
