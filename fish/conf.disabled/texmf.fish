# Include texlive configuration if texlive is installed

if status is-interactive
    # TODO: Only set these if texlive is actually installed
    set -gx TEXMFHOME "$XDG_DATA_HOME/texmf"
    set -gx TEXMFVAR "$XDG_CACHE_HOME/texmf"
    set -gx TEXMFCONFIG "$XDG_CONFIG_HOME/texmf"
end

