#!/bin/bash

# Bash completion & proper env parsing
[ -n "$HAS_SUDO" ] && \
    alias sudo='sudo ' && \
    [ -n "$BASH_COMPLETION" ] && \
        complete -o filenames -F _root_command sudo && \
        complete -cf sudo

