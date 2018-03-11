#!/bin/bash

function append_history {
    declare -g +x H1="$(history 1 | cut -c 8-)"
    history -a
}

function reset_term {
    # sgr0 = colors
    # cnorm = cursor
    # rmso = background color
    echo -e "sgr0\ncnorm\nrmso" | tput -S
}

function __prompt_exitstatus {
    local ret=$?
    if [[ $ret != 0 ]] ; then
        printf ' \e[38;5;9m︽ \e[4m%03d\e[24m\e[%dC\e[2D︽\e[1S' $ret $COLUMNS
    fi
}

function __prompt_rightstatus {
    local bare="$USER@$HOSTNAME $(date +%R)"
    local start=$(($COLUMNS - ${#bare} + 1))
    local user_color='\e[38;5;11m'  # Yellow with no sudo
    [ -n "$HAS_SUDO" ] && user_color='\e[38;5;7m'   # Grey with sudo
    [ -w /etc/passwd ] && user_color='\e[38;5;9m'   # Red if rootish
    printf '\e['$start'G'$user_color$USER'\e[38;5;240m'@'\e[38;5;7m'$HOSTNAME' \e[38;5;33m'$(date +%R)
}

declare +x HAS_SUDO="$(expr "$(groups)" : '\b\(wheel\|admin\|staff\)\b')"

PROMPT_COMMAND='append_history ; reset_term'
PROMPT_DIRTRIM=4

PS1='\[\e]2;$(basename "$PWD")\a\]\
\[\e7$(__prompt_exitstatus)\e8\]\
\[\e7$(__prompt_rightstatus)\e8\]\
\[\e[38;5;240m\]⎧\
\[\e[1;38;5;33m\]\w\n\
\[\e[0;38;5;240m\]⎩\[\e[0m\]\$ '

PS2='\[\e7\e[1F\e[38;5;240m⎪\e8\]\
\[\e[38;5;240m\]⎩\[\e[0m\]> '

shopt -s checkwinsize   # Update LINES and COLUMNS after every command

true

