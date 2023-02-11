#!/bin/bash

function __append_history {
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

    # Exit status
    local exitstatus=
    if [[ "$ret" != 0 ]] ; then
        ret="$(printf '▲ %03d ▲' "$ret")"
        local offset=$(( (COLUMNS - ${#ret} - 2) / 2 ))
        exitstatus=" \e[38;5;9m✘\e[${offset}C\e[4m$ret\e[24m\e[${offset}C✘\e[0m\n"
    fi

    # Right status
    local user_color='\e[38;5;11m'                      # Yellow with no sudo
    [[ -v HAS_SUDO ]] && user_color='\e[38;5;7m'        # Grey with sudo
    [[ -w /etc/passwd ]] && user_color='\e[38;5;9m'     # Red if rootish

    local host_color='\e[38;5;7m'
    [[ -v SSH_TTY ]] && host_color='\e[1;38;5;15m'      # Bold if in SSH connection
    local rightstatus=" \
\[\e[38;5;238m\]\[\e[48;5;238m${user_color}\] \
\u\[\e[38;5;240m\]@\[${host_color}\]\h\[\e[22m\] \
\[\e[38;5;33m\]\[\e[48;5;33m\] \
\[\e[38;5;15m\]\A \[\e[0m\e[38;5;33m\]\[\e[0m\] "

    if command -v __git_prompt >/dev/null ; then
        rightstatus=" $(__git_prompt)$rightstatus"
    elif command -v __git_ps1 >/dev/null ; then
        if parent-search .git >/dev/null ; then
            local GIT_PS1_SHOWDIRTYSTATE=1
            local GIT_PS1_SHOWSTASHSTATE=1
            local GIT_PS1_SHOWUNTRACKEDFILES=1
            local GIT_PS1_SHOWUPSTREAM=auto
            local GIT_PS1_SHOWCOLORHINTS=1

            __git_ps1 '' " $rightstatus"
            rightstatus="$PS1"
        fi
    fi

    if command -v __pyenv_prompt >/dev/null ; then
        __pyenv_prompt
    fi

    if [[ -v VIRTUAL_ENV ]] ; then
        rightstatus=" \[\e[38;5;240m\]❲\
\[\e[38;5;6m\]${VIRTUAL_ENV##*/}\[\e[38;5;240m\]\
❳\[\e[0m\]$rightstatus"
    fi

    rightstatus="${rightstatus@P}"
    local bare="${rightstatus//$'\001'*([^$'\002'])$'\002'}"

    local start=$(($COLUMNS - ${#bare} + 1))
    rightstatus="\e[${start}G$rightstatus"

    PS1=${exitstatus}"\
\[\e]2;${PWD##*/}\a\]\
\[\e7${rightstatus}\e8\]\
\[\e[38;5;240m\]⎧\
\[\e[1;38;5;33m\]\w\n\
\[\e[0;38;5;240m\]⎩\[\e[0m\]\$ "
}

for g in $(groups) ; do
    [[ "$g" = wheel || "$g" = admin || "$g" = staff || "$g" = sudo ]] && declare +x HAS_SUDO=1 && break
done
unset g

PROMPT_COMMAND='__update_prompt ; __append_history ; reset_term'
PROMPT_DIRTRIM=4

PS2='\[\e7\e[1F\e[38;5;240m⎪\e8\]\
\[\e[38;5;240m\]⎩\[\e[0m\]> '

# Update the window title with the currently running command
PS0='\[\e]2;$(history 1 | cut -c8-)\a\]'

shopt -s checkwinsize   # Update LINES and COLUMNS after every command

true
