#!/bin/bash

[ -r /etc/bash_completion ] && \
	source /etc/bash_completion

[ -r /usr/local/etc/bash_completion ] && \
	source /usr/local/etc/bash_completion

[ -r /usr/share/bash-completion/bash_completion ] && \
	source /usr/share/bash-completion/bash_completion
