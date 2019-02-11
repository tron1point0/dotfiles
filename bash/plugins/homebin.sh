#!/bin/bash

# Add these to PATH
declare -x -a BIN_PATHS=(
    "$HOME/.bin"
)

# Tab-complete these additional paths for `cd`
declare -x -a CD_PATHS=(
    "$HOME/Projects"
    "$HOME/Sync/Projects"
)

# Don't tab-complete files with these extensions
declare -x -a IGNORE_EXTENSIONS=(
    '.o'    # Object files
    '~'     # Default vim backup files
    '.swp'  # vim swap files
)

declare -x P

for P in "${BIN_PATHS[@]}" ; do
    [[ -d "$P" ]] && path -a "$P"
done

for P in "${CD_PATHS[@]}" ; do
    [[ -d "$P" ]] && modify-env -a add -v CDPATH "$P"
done

for P in "${IGNORE_EXTENSIONS[@]}" ; do
    [[ -d "$P" ]] && modify-env -a add -v FIGNORE "$P"
done

unset -v P
unset -v BIN_PATHS
unset -v CD_PATHS
unset -v IGNORE_EXTENSIONS

