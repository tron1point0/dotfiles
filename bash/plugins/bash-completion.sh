#!/bin/bash

[ -r /etc/bash_completion ] && \
	source /etc/bash_completion

[ -r /usr/local/etc/bash_completion ] && \
	source /usr/local/etc/bash_completion

[ -r /usr/share/bash-completion/bash_completion ] && \
	source /usr/share/bash-completion/bash_completion

[ -r /usr/share/git-core/git-completion.bash ] && \
	source /usr/share/git-core/git-completion.bash

[ -r /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ] && \
    source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
