#!/bin/bash

try_source /etc/bash_completion
try_source /usr/local/etc/bash_completion
try_source /usr/share/bash-completion/bash_completion
try_source /usr/local/share/bash-completion/bash_completion
try_source /usr/share/git-core/git-completion.bash
try_source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
try_source /usr/local/Cellar/git/*/etc/bash_completion.d/*.bash

true

