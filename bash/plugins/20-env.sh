#!/bin/bash

export EDITOR="vim"
export BROWSER="elinks"
can google-chrome && export BROWSER="google-chrome"
export PAGER="less"
export INPUTRC=$BASH_CONFIG_DIR/inputrc

export HISTFILE="$BASH_CONFIG_DIR/history"
export HISTCONTROL=erasedups
export HISTIGNORE="truecrypt*:sudo truecrypt*"
export HISTSIZE=10000
export HISTFILESIZE=10000

export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
