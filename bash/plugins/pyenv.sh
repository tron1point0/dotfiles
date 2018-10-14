#!/bin/bash

# Load pyenv automatically by appending
# the following to ~/.bash_profile:
can pyenv && eval "$(pyenv init -)"

# To enable auto-activation add to your profile:
can pyenv-virtualenv-init && eval "$(pyenv virtualenv-init -)"

