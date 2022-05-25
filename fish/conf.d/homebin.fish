# Use ~/.bin if it exists
if status is-interactive
    [ -d "$HOME/.bin" ] && set -p PATH "$HOME/.bin"
    [ -d "$HOME/Projects" ] && set -p CDPATH "$HOME/Projects"
end

