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

function __modify-env-completion {
    local command="$1"
    local curr_word="$2"
    local prev_word="$3"

    # Are we currently specifying an argument's value?

    case "$prev_word" in
        -a) COMPREPLY=($(compgen -W 'add del list' -- "$curr_word")) ; return ;;
        -v) COMPREPLY=($(compgen -A variable -- "$curr_word")) ; return ;;
    esac

    # Which arguments are already specified?

    local action
    local var
    local -A missing=(['-a']=1 ['-v']=1)

    local i
    for i in "${!COMP_WORDS[@]}" ; do
        case "${COMP_WORDS[$i]}" in
            -a) action="${COMP_WORDS[((i + 1))]}"
                [[ -n "$action" ]] && unset missing['-a'] ;;
            -v) var="${COMP_WORDS[((i + 1))]}"
                [[ -n "$var" ]] && unset missing['-v'] ;;
        esac
    done

    # Complete with the missing argument first

    [[ ${#missing[@]} > 0 ]] && \
        COMPREPLY=($(compgen -W "${!missing[*]}" -- "$curr_word")) && \
        return

    # We know what to do and with which var

    case "$action" in
        del)
            COMPREPLY=($(compgen -C 'modify-env -a list -v '"$var" -- "$curr_word" 2>/dev/null))
            return ;;
        add) COMPREPLY=($(compgen -A directory -A file -- "$curr_word")) ; return ;;
        list) COMPREPLY=() ; return ;;
    esac
}

complete -F __modify-env-completion modify-env

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

function __path-completion {
    case "$3" in
        -r) COMPREPLY=($(compgen -C 'path -l' -- "$2" 2>/dev/null)) ; return ;;
        -a) COMPREPLY=($(compgen -df -- "$2")) ; return ;;
        -l) COMPREPLY=() ; return ;;
    esac

    COMPREPLY=($(compgen -W '-r -a -l' -- "$2"))
}

complete -F __path-completion path

true
