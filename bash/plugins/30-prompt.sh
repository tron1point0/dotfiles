#!/bin/bash

function append_history {
    export H1="$(history 1 | cut -c 8-)"
    history -a
}

function reset_term {
    # sgr0 = colors
    # cnorm = cursor
    # rmso = background color
    echo -e "sgr0\ncnorm\nrmso" | tput -S
}

PROMPT_COMMAND='append_history ; reset_term'
PROMPT_DIRTRIM=3

function prompt_part {
    echo "\[$2\][\[$3\]$1\[$2\]]\[$CLEAR\]"
}

wheel=`groups | grep wheel`
color=$BROWN
l_color=$L_BROWN
[ -n "$wheel" ] && color=$GREEN && l_color=$L_GREEN
[ -w /etc/passwd ] && color=$RED && l_color=$L_RED

host=`prompt_part '\h' $color $l_color`
user=`prompt_part '\u' $color $l_color`
dir=`prompt_part '\w' $color $L_BLUE`

export PS1="${host}${user}${dir}\\$ "
export PS2="> "

unset wheel color l_color host user dir
unset -f prompt_part

shopt -s checkwinsize
shopt -s histappend
