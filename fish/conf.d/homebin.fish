# Use ~/.bin if it exists
if status is-interactive
    [ -d "$HOME/.bin" ] && fish_add_path -Pp "$HOME/.bin"
    [ -d "$HOME/.local/bin" ] && fish_add_path -Pp "$HOME/.local/bin"
    [ -d "$HOME/Projects" ] && set -p CDPATH "$HOME/Projects"

    # Also prepend the current directory for tab completion
    set -p CDPATH .
end

