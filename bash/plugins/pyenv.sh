#!/usr/bin/env bash

# Much faster overrides for pyenv's default shell manipulations

if can pyenv ; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PYENV_SHELL=bash

    function __pyenv_prompt {
        local version_file="$(parent-search .python-version)"

        if [[ -r "$version_file" ]] ; then
            # TODO: Fix cding directly to directory with different python version file
            if [[ ! -v VIRTUAL_ENV ]] ; then
                local python_version
                read python_version < "$version_file"
                local activate="$PYENV_ROOT/versions/$python_version/bin/activate"
                [[ -r "$activate" ]] && source "$activate"
            fi
        else
            [[ -v VIRTUAL_ENV ]] && command -v deactivate >/dev/null && deactivate
        fi
    }
fi
