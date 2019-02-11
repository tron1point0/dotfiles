#!/bin/bash

function can {
    command -v "$1" >/dev/null
}

function try {
    can "$1" && "$@"
}

function try_source {
    for arg in "$@" ; do
        [[ -r "$arg" ]] && source "$arg"
    done
}

function ensure_dir {
    for arg in "$@" ; do
        [[ -d "$arg" ]] || mkdir -p "$arg"
    done
}

function ensure_parent_dir {
    ensure_dir "$(dirname "$1")"
}

unset_after can try try_source ensure_dir ensure_parent_dir

true
