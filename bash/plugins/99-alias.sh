#!/bin/bash

alias ls='ls -v --color'
ls --help | grep [-][-]group-directories-first \
    | column -t | cut -f1 1>/dev/null && \
    alias ls='ls -v --color --group-directories-first'
can axel && alias axel='axel -a'
can tmux && alias screen='tmux attach'
can xdg-open && alias open='xdg-open'

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

