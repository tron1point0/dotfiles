# Use ~/.bin if it exists
if status is-interactive
    [ -d "$HOME/.bin" ] && set -p PATH "$HOME/.bin"
    [ -d "$HOME/.local/bin" ] && set -p PATH "$HOME/.local/bin"
    [ -d "$HOME/Projects" ] && set -p CDPATH "$HOME/Projects"

    # Also prepend the current directory for tab completion
    set -p CDPATH .
end

