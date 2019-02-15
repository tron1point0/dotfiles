#!/bin/bash

#try_source /etc/bash_completion
#try_source /usr/local/etc/bash_completion

# Arch linux, Raspbian
try_source /usr/share/bash-completion/bash_completion

# From bash-completion@2 package (OSX)
# This also loads /usr/local/share/bash-completion
try_source /usr/local/etc/profile.d/bash_completion.sh

# From individual apps (OSX)
try_source /usr/local/etc/bash_completion.d/*

true
