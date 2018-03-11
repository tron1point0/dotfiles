#!/bin/bash

export LESSHISTFILE="$XDG_DATA_HOME/less/lesshst"
ensure_parent_dir "$LESSHISTFILE"

declare -x -a LESS_OPTIONS=(
    '--hilite-search'
    '--ignore-case'
    '--jump-target=.5'
    '--status-column'
    '--long-prompt'
    '--RAW-CONTROL-CHARS'
    '--tabs=4'
    '--shift=.3'
)
export LESS="${LESS_OPTIONS[@]}"
unset -v LESS_OPTIONS

export LESS_TERMCAP_md=$'\e[38;5;9m'        # section titles
export LESS_TERMCAP_us=$'\e[38;5;10m'       # code/literal
export LESS_TERMCAP_mb=$'\e[4;38;5;3m'      # ???
export LESS_TERMCAP_so=$'\e[1;38;5;11m'     # highlight/modeline
export LESS_TERMCAP_me=$'\e[0m'             # reset section title
export LESS_TERMCAP_se=$'\e[0m'             # reset highlight/modeline
export LESS_TERMCAP_ue=$'\e[0m'             # reset code/literal

true

