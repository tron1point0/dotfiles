# Really fast way to automatically activate pyenv and venvs when entering
# a directory whose ancestors contain virtual envs.
#
# Depends on parent-search.fish

if status is-interactive
    if type -q pyenv
        set -gx PYENV_ROOT "$HOME/.pyenv"
    end

    function __python_env --on-variable PWD
        function __pyenv_activate -a version_file
            read -l pyenv_version < "$version_file"
            __venv_activate "$PYENV_ROOT/versions/$pyenv_version/bin/activate.fish"
        end

        function __venv_activate -a activator_file
            if [ -r "$activator_file" ]
                source "$activator_file"
                set -g PYTHON_VENV_ROOT "$PWD"
                return 0
            end
            return 1
        end

        function __venv_deactivate
            type -q deactivate && deactivate
            set -e PYTHON_VENV_ROOT
        end

        # We're in a venv and still in a descendant dir
        set -q VIRTUAL_ENV && string match -q "$PYTHON_VENV_ROOT*" "$PWD" && return 0

        # We're in a venv, but outside the descendant dir
        set -q VIRTUAL_ENV && __venv_deactivate

        # We're not in a venv at all
        if type -q pyenv
            if parent-search .python-version | read -l file
                __pyenv_activate "$file" && return 0
            end
        end

        for venv_dir in venv .venv
            if parent-search "$venv_dir/bin/activate.fish" | read -l file
                __venv_activate "$file" && return 0
            end
        end
    end
end

