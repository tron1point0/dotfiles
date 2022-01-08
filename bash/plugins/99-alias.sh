#!/bin/bash

alias ls='ls -v --color'
alias ll='ls -l'
alias la='ls -lA'
alias l='ls'
ls --help | grep [-][-]group-directories-first \
    | column -t | cut -f1 1>/dev/null && \
    alias ls='ls -v --color --group-directories-first'
can axel && alias axel='axel -a'
can tmux && alias screen='tmux attach'
can xdg-open && alias open='xdg-open'
can nvim && alias vim=nvim

true
