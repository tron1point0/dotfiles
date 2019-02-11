#!/bin/bash

unset -v IFS    # Gets default value if unset

function modify-env {
    local ACTION=
    local VAR=
    local E=
    local SELF=${FUNCNAME[0]}
    local IFS=${IFS:-:}
    local OPT
    local OPTIND
    local OPTARG
    local OPTERR

    local USAGE
    read -r -d '' USAGE <<HELP
USAGE: $SELF -a action -v variable [-- elements...]
OPTIONS:
    -a
        The action to perform.
    -v
        The variable that will be modified by action.
    elements
        The elements that will be acted upon by action.

ACTIONS:
    add
        Add the specified elements. If the elements are already present in the
        list, they are brought to the front.
    del
        Delete the specified elements.
    list
        Show all the elements of the list in variable.

ENVIRONMENT:
    IFS
        $SELF uses bash's field separator, IFS, to split and join the list.
HELP

    while getopts a:v:s: OPT ; do
        case "$OPT" in
            a) ACTION=$OPTARG ;;
            v) VAR=$OPTARG ;;
        esac
    done
    shift $(( $OPTIND - 1 ))

    [[ -z "$VAR" ]] && echo "$USAGE" && return 1

    case "$ACTION" in
        add)
            for E in "$@" ; do
                local TEMP="$IFS${!VAR}$IFS"
                TEMP="${TEMP//$IFS${E//\//\\/}$IFS/$IFS}"
                TEMP="${TEMP:${#IFS}:-${#IFS}}"
                declare -g $VAR="$E$IFS$TEMP"
            done
            return 0
            ;;
        del)
            for E in "$@"; do
                local TEMP="$IFS${!VAR}$IFS"
                TEMP="${TEMP//$IFS${E//\//\\/}$IFS/$IFS}"
                TEMP="${TEMP:${#IFS}:-${#IFS}}"
                declare -g $VAR="$TEMP"
            done
            return 0
            ;;
        list)
            for E in ${!VAR} ; do
                echo $E
            done
            return 0
            ;;
        *)
            echo "$USAGE" && return 1 ;;
    esac

    return 0
}

function path {
    local USAGE
    read -r -d '' USAGE <<HELP
USAGE: path -arl [paths...]
OPTIONS:
    -a  Add to PATH
        If paths... already exist in PATH, they are brought to the front
    -r  Remove from PATH
    -l  List paths in PATH, one per line
HELP
    local action=$1
    shift 1
    case $action in
    -a)
        modify-env -a add -v PATH -- "$@" && return $? ;;
    -r)
        modify-env -a del -v PATH -- "$@" && return $? ;;
    -l)
        modify-env -a list -v PATH && return $? ;;
    *)
        echo "$USAGE" && return 1
    esac
    return 1
}

true
