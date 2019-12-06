#!/bin/bash

function parent-search {
    local target="$1"
    local dir="$PWD"
    local SELF=${FUNCNAME[0]}

    [[ -z "$target" || "$target" == "-h" ]] && cat <<HELP && return -1
$SELF: Find a file in the current directory or its parents.

USAGE:
    $SELF target

ARGUMENTS:
    target
        The file to search for. (May be a directory.)

OUTPUTS:
    Path to target if found.

ENVIRONMENT:
    PWD
        The directory to search for the target in.
HELP

    while [[ "$dir" ]]; do
        [[ -e "$dir/$target" ]] && echo "$dir/$target" && return 0
        dir="${dir%/*}"
    done

    return 1
}

true
