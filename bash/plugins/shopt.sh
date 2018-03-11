#!/usr/bin/env bash

shopt -s checkjobs      # Defer exit if there are running backgrounded jobs
shopt -s cmdhist        # Save multiline history entries to single line
shopt -s direxpand      # Expand words when doing filename completion
shopt -s extglob        # ?(...) *(...) +(...) @(...) !(...) globbing
shopt -s extquote       # $'' and $"" expand parameters
shopt -s globstar       # ** in glob expands recursively
shopt -s histappend     # Append to history instead of overwriting
shopt -s histverify     # History expansion into readline buffer

true

