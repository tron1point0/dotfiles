#!/bin/bash

alias ls='ls -v --color'
alias ll='ls -l'
alias la='ls -la'
alias l='ls'
can axel && alias axel='axel -a'
can tmux && alias screen='tmux attach'
can xdg-open && alias open='xdg-open'
can nvim && alias vim=nvim
can exa && alias ls='exa -F --group-directories-first'
# The ubuntu package only installs "batcat", but not "bat"
can bat || { can batcat && alias bat='batcat' ; }
can batman && alias man='batman'

true
