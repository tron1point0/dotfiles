#!/usr/bin/env bash

# Much faster overrides for pyenv's default shell manipulations

if can pyenv ; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PYENV_SHELL=bash

    function __pyenv_deactivate {
        command -v deactivate >/dev/null && deactivate
        unset PYENV_VERSION_FILE
    }

    function __pyenv_activate {
        local version file="$1"
        read version < "$file"
        local activate="$PYENV_ROOT/versions/$version/bin/activate"
        if [[ -r "$activate" ]] ; then
            source "$activate"
            PYENV_VERSION_FILE="$file"
        fi
    }

    function __pyenv_prompt {
        # We're in a venv and still in a descendant dir
        [[ -v VIRTUAL_ENV && "$PWD" = "${PYENV_VERSION_FILE%/\.python-version}"* ]] && return 0

        # We've in a venv, but outside the one containing our `.python-version`
        [[ -v VIRTUAL_ENV ]] && __pyenv_deactivate

        # We're not in a venv at all
        local file="$(parent-search .python-version)"
        [[ -r "$file" ]] && __pyenv_activate "$file"
    }
fi
