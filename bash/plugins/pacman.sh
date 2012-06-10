#!/bin/bash

if can pacman ; then
    alias pacman='pacman-color'
    alias paci='pacman -Sy'
    alias pacr='pacman -Rns'
    alias pacsearch="pacman -Sl | cut -d' ' -f2 | grep"
    alias pacs='pacman -Ss'

    function pacwhy {
        pacman -Qi $1 | grep "Required By" | cut -f 2 -d ':' | cut -c 1 --complement | sed 's/[ ]\+/\n/'
    }

    function paclist {
        local local_dir="local\/"
        pacman -Qs $1 | sed -n '/'$local_dir'/ {
    N
    s/'$local_dir'\([^ ]\+\)[ ]\+\([^ ]\+\)\n[ ]\+\(.*\)/'$L_GRAY'\1\t'$L_GREEN'\2\t'$CLEAR'\3/p
    }' | awk -F '\t' '{printf("%-40s %-18s %s\n",$1,$2,$3)}'
    }
fi
