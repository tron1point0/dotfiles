#!/bin/bash

function __append_history {
    declare -g +x H1="$(history 1 | cut -c 8-)"
    history -a
}

function reset_term {
    # sgr0 = colors
    # cnorm = cursor
    # rmso = background color
    echo -e "sgr0\ncnorm\nrmso" | tput -S
}

function __update_prompt {
    local ret=$?
    local exitstatus=
    local windowtitle="$(basename "$PWD")"

    # Right status
    local user_color='\e[38;5;11m'  # Yellow with no sudo
    [ -n "$HAS_SUDO" ] && user_color='\e[38;5;7m'   # Grey with sudo
    [ -w /etc/passwd ] && user_color='\e[38;5;9m'   # Red if rootish
    local rightstatus="\
\[${user_color}\]$USER\[\e[38;5;240m\]@\[\e[38;5;7m\]$HOSTNAME \
\[\e[38;5;33m\]$(date +%R)"

    if command -v __git_ps1 >/dev/null ; then
        local GIT_PS1_SHOWDIRTYSTATE=1
        local GIT_PS1_SHOWSTASHSTATE=1
        local GIT_PS1_SHOWUNTRACKEDFILES=1
        local GIT_PS1_SHOWUPSTREAM=auto
        local GIT_PS1_SHOWCOLORHINTS=1

        __git_ps1 '' " $rightstatus"
        rightstatus="$PS1"
    fi

    # Strip non-printing escapes
    [ -n "$1" ] && echo "$rightstatus"
    local bare="$(echo "$rightstatus" | sed 's_\\\[__g;s_\\]__g;s_\\e\[\([0-9;]*\)m__g')"
    eval 'bare="'$bare'"'   # Force variable expansion

    local start=$(($COLUMNS - ${#bare} + 1))
    rightstatus="\e[${start}G$rightstatus"

    PS1='\[\e7$(__prompt_exitstatus)\e8\]\
\[\e]2;'${windowtitle}'\a\]\
\[\e7'${rightstatus}'\e8\]\
\[\e[38;5;240m\]⎧\
\[\e[1;38;5;33m\]\w\n\
\[\e[0;38;5;240m\]⎩\[\e[0m\]\$ '
}

function __prompt_exitstatus {
    local ret=$?

    if [[ $ret != 0 ]] ; then
        printf ' \e[38;5;9m︽ \e[4m%03d\e[24m\e[%dG︽\e[1S' $ret $((COLUMNS - 2))
    fi
}

declare +x HAS_SUDO="$(expr "$(groups)" : '\b\(wheel\|admin\|staff\)\b')"

PROMPT_COMMAND='__update_prompt ; __append_history ; reset_term'
PROMPT_DIRTRIM=4

PS2='\[\e7\e[1F\e[38;5;240m⎪\e8\]\
\[\e[38;5;240m\]⎩\[\e[0m\]> '

shopt -s checkwinsize   # Update LINES and COLUMNS after every command

true

