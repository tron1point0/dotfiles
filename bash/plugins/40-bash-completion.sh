#!/bin/bash

[ -z $BASH_COMPLETION ] && [ -r /etc/bash_completion ] && \
	source /etc/bash_completion

[ -z $BASH_COMPLETION ] && [ -r /usr/share/bash-completion/bash_completion ] && \
	source /usr/share/bash-completion/bash_completion
