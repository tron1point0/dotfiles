#!/bin/bash

function can {
    type "$1" >&/dev/null
}

function try {
    can "$1" && "$@"
}

function try_source {
    [ -r "$1" ] && source "$1"
}

function ensure_dir {
    [ -d "$1" ] || mkdir -p "$1"
}

function ensure_parent_dir {
    ensure_dir "$(dirname "$1")"
}

unset_after can try try_source ensure_dir ensure_parent_dir

true

