#!/bin/bash

# Bash completion & proper env parsing
[ -n "`groups | grep wheel`" ] && \
    alias sudo='sudo ' && \
    [ -n "$BASH_COMPLETION" ] && \
        complete -o filenames -F _root_command sudo && \
        complete -cf sudo
