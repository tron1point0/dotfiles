#!/bin/bash

export EDITOR=vim
export BROWSER=elinks
can google-chrome && export BROWSER=google-chrome
export PAGER=less

export XDG_DATA_HOME="$HOME/.local/share"
ensure_dir "$XDG_DATA_HOME"
export XDG_CONFIG_HOME="$HOME/.config"
ensure_dir "$XDG_CONFIG_HOME"
export XDG_CACHE_HOME="$HOME/.cache"
ensure_dir "$XDG_CACHE_HOME"

declare +x INPUTRC="$BASH_CONFIG_DIR/inputrc"
declare +x HISTFILE="$XDG_DATA_HOME/bash/history"
ensure_parent_dir "$HISTFILE"
declare +x HISTCONTROL=erasedups
declare +x HISTIGNORE="truecrypt*:sudo truecrypt*"
declare +x HISTSIZE=10000
declare +x HISTFILESIZE=10000

true

